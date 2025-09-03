import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileSettingsScreen extends ConsumerStatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  ConsumerState<ProfileSettingsScreen> createState() =>
      _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState
    extends ConsumerState<ProfileSettingsScreen>
    with SingleTickerProviderStateMixin {
  bool isDarkMode = false;
  bool _showNotification = false;
  String _notificationText = '';
  Color _notificationColor = Colors.green;

  // Animation controller for cards
  late final AnimationController _cardController;
  late final Animation<double> _cardAnimation;

  @override
  void initState() {
    super.initState();
    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _cardAnimation =
        CurvedAnimation(parent: _cardController, curve: Curves.easeOut);
    _cardController.forward();
  }

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
      _showTemporaryNotification(
        isDarkMode ? 'Dark mode activated' : 'Light mode activated',
        Colors.deepPurpleAccent,
      );
    });
  }

  void _showTemporaryNotification(String message, Color color) {
    setState(() {
      _notificationText = message;
      _notificationColor = color;
      _showNotification = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showNotification = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Profile & Settings',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: FadeTransition(
              opacity: _cardAnimation,
              child: Column(
                children: [
                  _glassCard(
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage('assets/profile_pic.png'),
                      ),
                      title: const Text(
                        'Nav Abnet',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      subtitle: const Text(
                        'nav@example.com',
                        style: TextStyle(color: Colors.white70),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit,
                            color: Colors.deepPurpleAccent),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildAnimatedCard(Icons.person, 'Personal Info',
                      'View & update your personal information', () {
                    _showTemporaryNotification('Opened Personal Info', Colors.blue);
                  }),
                  const SizedBox(height: 12),
                  _buildAnimatedCard(Icons.folder, 'KYC Documents',
                      'Upload/verify identity documents', () {
                    _showTemporaryNotification('Opened KYC Documents', Colors.orange);
                  }),
                  const SizedBox(height: 12),
                  _glassCard(
                    child: ListTile(
                      leading: const Icon(Icons.palette,
                          color: Colors.purpleAccent),
                      title: const Text(
                        'Preferences',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      subtitle: const Text('Theme, notifications, and more',
                          style: TextStyle(color: Colors.white54, fontSize: 12)),
                      trailing: Switch(
                        value: isDarkMode,
                        thumbColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                        onChanged: (val) => _toggleTheme(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildAnimatedCard(Icons.lock, 'Account Security',
                      '2FA, biometric login & password', () {
                    _showTemporaryNotification('Opened Account Security', Colors.redAccent);
                  }),
                  const SizedBox(height: 80), // Extra bottom spacing
                ],
              ),
            ),
          ),

          // Notification Banner
          if (_showNotification)
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _showNotification ? 1 : 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: _notificationColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.notifications, color: Colors.white),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _notificationText,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          setState(() => _showNotification = false);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCard(
      IconData icon, String title, String subtitle, VoidCallback onTap) {
    return ScaleTransition(
      scale: _cardAnimation,
      child: _glassCard(
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          subtitle: Text(subtitle,
              style: const TextStyle(color: Colors.white54, fontSize: 12)),
          trailing: const Icon(Icons.arrow_forward_ios,
              color: Colors.white70, size: 16),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _glassCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
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