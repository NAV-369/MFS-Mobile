import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double logoScale = 0.6;

  @override
  void initState() {
    super.initState();

    // Animate logo scale slightly after build
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          logoScale = 1.0;
        });
      }
    });

    // Navigate to Login after 2.5 seconds using GoRouter
    Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        context.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Wallet-style dark background
      body: SafeArea(
        child: Center(
          child: AnimatedScale(
            scale: logoScale,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutBack,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 80,
                ),
                SizedBox(height: 20),
                Text(
                  'Microfinance App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}