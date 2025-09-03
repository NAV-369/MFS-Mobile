import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/dashboard_card.dart';
import '../../../core/widgets/income_expense_card.dart';
import '../../../core/widgets/loan_card.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/auth_provider.dart';
import 'package:mfs_mobile/features/ai/ai_chatbot_widget.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with SingleTickerProviderStateMixin {
  bool _showChatbot = false;
  final bool _showNotification = false;
  final String _notificationText = '';
  final Color _notificationColor = Colors.green;

  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Chatbot animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _toggleChatbot() {
    setState(() => _showChatbot = !_showChatbot);
    if (_showChatbot) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final dashboardSummary = ref.watch(dashboardSummaryProvider);
    final balance = ref.watch(balanceProvider);

    // Redirect to login if not authenticated
    if (!authState.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/login');
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final double topPadding = MediaQuery.of(context).padding.top + kToolbarHeight;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Welcome, ${authState.user?.username ?? "User"}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.transparent,    
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => context.push('/profile'),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, topPadding + 8, 16, 140),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Notification banner
                if (_showNotification)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _notificationColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info, color: Colors.white),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _notificationText,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),

                // AI Chatbot Card
                InkWell(
                  onTap: _toggleChatbot,
                  child: _glassCard(
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'AI Assistant',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Hello! I am your AI assistant. Tap here to chat.',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Dashboard Cards Grid
                dashboardSummary.when(
                  data: (summary) => GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.35,
                    children: [
                      DashboardCard(
                        title: 'Balance',
                        value: '\$${summary.totalBalance.toStringAsFixed(2)}',
                        startColor: Colors.tealAccent.shade700,
                        endColor: Colors.green.shade700,
                        icon: Icons.account_balance_wallet,
                        onTap: () => context.push('/balance'),
                      ),
                      DashboardCard(
                        title: 'Active Loans',
                        value: '${summary.activeLoans}',
                        startColor: Colors.redAccent.shade700,
                        endColor: Colors.red.shade400,
                        icon: Icons.attach_money,
                        onTap: () => context.push('/loans'),
                      ),
                      DashboardCard(
                        title: 'Transactions',
                        value: '${summary.totalTransactions}',
                        startColor: Colors.lightBlueAccent.shade700,
                        endColor: Colors.blue.shade400,
                        icon: Icons.receipt_long,
                        onTap: () => context.push('/transactions'),
                      ),
                    ],
                  ),
                  loading: () => const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (error, stack) => Container(
                    height: 200,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, color: Colors.redAccent, size: 48),
                        const SizedBox(height: 8),
                        Text(
                          'Failed to load dashboard data',
                          style: const TextStyle(color: Colors.redAccent),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => ref.refresh(dashboardSummaryProvider),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Income vs Expenses
                const _SectionTitle(title: 'Monthly Overview'),
                const SizedBox(height: 8),
                dashboardSummary.when(
                  data: (summary) => _glassCard(
                    child: IncomeExpenseCard(
                      income: summary.monthlyIncome,
                      expenses: summary.monthlyExpenses,
                    ),
                  ),
                  loading: () => _glassCard(
                    child: const SizedBox(
                      height: 120,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  error: (_, __) => _glassCard(
                    child: const SizedBox(
                      height: 120,
                      child: Center(
                        child: Text(
                          'Failed to load monthly data',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // AI Chatbot overlay
          if (_showChatbot)
            FadeTransition(
              opacity: _fadeAnimation,
              child: GestureDetector(
                onTap: _toggleChatbot,
                child: Container(
                  color: Colors.black54,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: SafeArea(
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.2)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          height: MediaQuery.of(context).size.height * 0.55,
                          child: const AIChatbotWidget(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),

      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _QuickActionButton(
                  icon: Icons.attach_money,
                  label: 'Deposit',
                  color: Colors.green,
                  onTap: () => context.push('/deposit')),
              _QuickActionButton(
                  icon: Icons.swap_horiz,
                  label: 'Transfer',
                  color: Colors.blue,
                  onTap: () => context.push('/transfer')),
              _QuickActionButton(
                  icon: Icons.money_off,
                  label: 'Withdraw',
                  color: Colors.orange,
                  onTap: () => context.push('/withdraw')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _glassCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}