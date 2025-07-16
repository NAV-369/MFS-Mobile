import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFF),
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white),
            ),
            onPressed: () => context.go('/dashboard/profile'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeHeader(),
              SizedBox(height: 20),
              _buildQuickActions(context),
              SizedBox(height: 24),
              _buildSavingsCard(context),
              SizedBox(height: 16),
              _buildLoansCard(context),
              SizedBox(height: 16),
              _buildRecentActivity(),
              SizedBox(height: 24), // Extra padding at the bottom
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back!',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A2B4D),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Here\'s your financial overview',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7B8F),
              height: 1.4,
            ),
          ),
          SizedBox(height: 16),
          Divider(thickness: 1, color: Colors.grey.shade200),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      {'title': 'Deposit', 'icon': Icons.account_balance, 'route': '/dashboard/savings', 'color1': Color(0xFF4A90E2), 'color2': Color(0xFF3B82F6)},
      {'title': 'Apply Loan', 'icon': Icons.request_quote, 'route': '/dashboard/loans', 'color1': Color(0xFF8E54E9), 'color2': Color(0xFF6A11CB)},
      {'title': 'Make Payment', 'icon': Icons.payment, 'route': '/dashboard/loans/repayment', 'color1': Color(0xFFFF6B6B), 'color2': Color(0xFFFF8E53)},
      {'title': 'Credit Score', 'icon': Icons.credit_score, 'route': '/dashboard/credit-score', 'color1': Color(0xFF4CAF50), 'color2': Color(0xFF2E7D32)},
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.6,
      padding: EdgeInsets.zero,
      children: actions.map((action) {
        return _buildActionButton(
          action['title'] as String,
          action['icon'] as IconData,
          color1: action['color1'] as Color,
          color2: action['color2'] as Color,
          onTap: () => context.go(action['route'] as String),
        );
      }).toList(),
    );
  }

  Widget _buildActionButton(String title, IconData icon, {required Color color1, required Color color2, VoidCallback? onTap}) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color1, color2],
            ),
            boxShadow: [
              BoxShadow(
                color: color1.withOpacity(0.2),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSavingsCard(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Color(0xFFF0F7FF), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border.all(color: Color(0xFFE3F2FD)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Savings Account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A2B4D),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Color(0xFF6B7B8F)),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Current Balance',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7B8F),
                    ),
                  ),
                  Text(
                    'ETB 0',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A2B4D),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              LinearPercentIndicator(
                lineHeight: 8,
                percent: 0,
                backgroundColor: Color(0xFFE3F2FD),
                progressColor: Color(0xFF4285F4),
                barRadius: Radius.circular(4),
                padding: EdgeInsets.zero,
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Savings Goal',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7B8F),
                    ),
                  ),
                  Text(
                    '0% Complete',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A2B4D),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoansCard(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Color(0xFFFFF8E1), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border.all(color: Color(0xFFFFF3E0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Loan Progress',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A2B4D),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Color(0xFF6B7B8F)),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'You don\'t have any active loans',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7B8F),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go('/dashboard/loans'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4285F4),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Apply for a Loan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Divider(color: Colors.grey.shade200, height: 1),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.credit_score_rounded, color: Color(0xFFFBBC05), size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Credit Score',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7B8F),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '750',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A2B4D),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              LinearPercentIndicator(
                lineHeight: 6,
                percent: 0.75,
                backgroundColor: Color(0xFFE3F2FD),
                progressColor: Color(0xFFFBBC05),
                barRadius: Radius.circular(3),
                padding: EdgeInsets.zero,
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Good',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF4285F4),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '75%',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7B8F),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A2B4D),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(50, 24),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFF4285F4),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.receipt_long_rounded, size: 48, color: Color(0xFFE3F2FD)),
              SizedBox(height: 16),
              Text(
                'No recent activity',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7B8F),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}