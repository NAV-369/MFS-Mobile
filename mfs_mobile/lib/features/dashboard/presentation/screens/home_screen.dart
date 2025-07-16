import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isMenuOpen = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  Widget _buildNavItem(String title, IconData icon, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, size: 20, color: const Color(0xFF4B5563)),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1F2937),
        ),
      ),
      onTap: onTap ?? () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      minLeadingWidth: 0,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'MF-SOLUTION',
        style: TextStyle(
          color: Color(0xFF1E3A8A),
          fontWeight: FontWeight.w900,
          fontSize: 20,
          letterSpacing: 1.2,
        ),
      ),
      centerTitle: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        // Toggle Menu Button
        IconButton(
          icon: Icon(
            _isMenuOpen ? Icons.close : Icons.menu,
            color: const Color(0xFF1E3A8A),
            size: 28,
          ),
          onPressed: _toggleMenu,
        ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 12, bottom: 8),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade200,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () => context.go('/register'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'REGISTER NOW',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  letterSpacing: 0.8,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: const Color(0xFFE5E7EB).withOpacity(0.5),
          height: 1.0,
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 80, left: 24, right: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF0F7FF), Color(0xFFFFFFFF)],
          stops: [0.0, 0.7],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2FE),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade100,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Text(
              'AI-POWERED FINANCE',
              style: TextStyle(
                color: Color(0xFF1E40AF),
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 32),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Smart Financial ', 
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E3A8A),
                    height: 1.2,
                    letterSpacing: -0.5,
                  ),
                ),
                TextSpan(
                  text: 'Solutions',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF3B82F6),
                    height: 1.2,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Empowering your financial journey with cutting-edge AI technology',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF4B5563),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Our cutting-edge AI platform revolutionizes microfinance by using advanced algorithms to provide personalized financial solutions, smarter risk assessment, and faster approvals for underserved communities.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 11, 10, 10),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => context.go('/dashboard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  shadowColor: const Color(0xFF3B82F6).withOpacity(0.3),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Learn more →',
                  style: TextStyle(
                    color: Color(0xFF3B82F6),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          const Text(
            'Quick Access',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildQuickAccessItem(
                'Sign In',
                Icons.login_rounded,
                onPressed: () => context.go('/login'),
              ),
              const SizedBox(width: 16),
              _buildQuickAccessItem(
                'Create Account',
                Icons.person_add_alt_1_rounded,
                onPressed: () => context.go('/register'),
              ),
            ],
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildQuickAccessItem(String title, IconData icon, {required VoidCallback onPressed}) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      icon: Icon(icon, color: const Color(0xFF3B82F6)),
      label: Text(
        title,
        style: const TextStyle(color: Color(0xFF2C3E50)),
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
      color: Colors.white,
      child: Column(
        children: [
          const Text(
            'Our Features',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A2B4D),
            ),
          ),
          const SizedBox(height: 40),
          _buildFeatureCard(
            icon: Icons.rocket_launch_rounded,
            title: 'AI-Powered Lending',
            description: 'Get personalized loan recommendations with AI-driven risk assessment for faster approvals and better terms.',
          ),
          const SizedBox(height: 20),
          _buildFeatureCard(
            icon: Icons.insights_rounded,
            title: 'Smart Financial Insights',
            description: 'Receive AI-generated financial insights and personalized recommendations to optimize your financial health.',
          ),
          const SizedBox(height: 20),
          _buildFeatureCard(
            icon: Icons.analytics_rounded,
            title: 'Predictive Analytics',
            description: 'Leverage our AI\'s predictive analytics to anticipate financial needs and identify growth opportunities.',
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0F3F7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 28, color: const Color(0xFF3B82F6)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          // Main Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _buildHeroSection(context),
                _buildFeaturesSection(),
              ],
            ),
          ),
          // Navigation Menu Overlay
          if (_isMenuOpen) ...[
            // Semi-transparent overlay
            GestureDetector(
              onTap: _toggleMenu,
              child: Container(
                color: Colors.black26,
              ),
            ),
            // Menu Content
            Positioned(
              top: kToolbarHeight + 1, // Below app bar
              right: 0,
              bottom: 0,
              width: MediaQuery.of(context).size.width * 0.75,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(-2, 0),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Text(
                          'Navigation',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            _buildNavItem('About Us', Icons.info_outline),
                            _buildNavItem('Our Services', Icons.work_outline),
                            _buildNavItem('Contact', Icons.email_outlined),
                            const Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
                            _buildNavItem('Privacy Policy', Icons.privacy_tip_outlined),
                            _buildNavItem('Terms of Service', Icons.description_outlined),
                          ],
                        ),
                      ),
                      // Footer with app version
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'v1.0.0',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}