import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool showLogin = true;
  late AnimationController _controller;
  
  // Form controllers
  final _loginUsernameController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  final _registerUsernameController = TextEditingController();
  final _registerEmailController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  
  // Form keys
  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  void toggleForm() {
    if (showLogin) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() => showLogin = !showLogin);
  }

  @override
  void dispose() {
    _controller.dispose();
    _loginUsernameController.dispose();
    _loginPasswordController.dispose();
    _registerUsernameController.dispose();
    _registerEmailController.dispose();
    _registerPasswordController.dispose();
    super.dispose();
  }

  Widget _inputField(String label, TextEditingController controller, {bool obscure = false, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        errorStyle: const TextStyle(color: Colors.redAccent),
      ),
    );
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> _handleLogin() async {
    if (!_loginFormKey.currentState!.validate()) return;

    try {
      await ref.read(authProvider.notifier).login(
        _loginUsernameController.text.trim(),
        _loginPasswordController.text,
      );
      
      if (mounted) {
        context.go('/dashboard');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${e.toString()}'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  Future<void> _handleRegister() async {
    if (!_registerFormKey.currentState!.validate()) return;

    try {
      await ref.read(authProvider.notifier).register(
        _registerUsernameController.text.trim(),
        _registerEmailController.text.trim(),
        _registerPasswordController.text,
      );
      
      if (mounted) {
        context.go('/dashboard');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${e.toString()}'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  Widget _loginForm() {
    final authState = ref.watch(authProvider);
    
    return _glassCard(
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Welcome Back",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 8),
            const Text("Login to continue",
                style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 24),
            _inputField("Username", _loginUsernameController, validator: _validateUsername),
            const SizedBox(height: 16),
            _inputField("Password", _loginPasswordController, obscure: true, validator: _validatePassword),
            const SizedBox(height: 24),
            _primaryButton("Login", authState.isLoading ? null : _handleLogin, isLoading: authState.isLoading),
            const SizedBox(height: 16),
            TextButton(
              onPressed: authState.isLoading ? null : toggleForm,
              child: const Text("Don't have an account? Register",
                  style: TextStyle(color: Colors.white70)),
            )
          ],
        ),
      ),
    );
  }

  Widget _registerForm() {
    final authState = ref.watch(authProvider);
    
    return _glassCard(
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Create Account",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 8),
            const Text("Sign up to get started",
                style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 24),
            _inputField("Username", _registerUsernameController, validator: _validateUsername),
            const SizedBox(height: 16),
            _inputField("Email", _registerEmailController, validator: _validateEmail),
            const SizedBox(height: 16),
            _inputField("Password", _registerPasswordController, obscure: true, validator: _validatePassword),
            const SizedBox(height: 24),
            _primaryButton("Register", authState.isLoading ? null : _handleRegister, isLoading: authState.isLoading),
            const SizedBox(height: 16),
            TextButton(
              onPressed: authState.isLoading ? null : toggleForm,
              child: const Text("Already have an account? Login",
                  style: TextStyle(color: Colors.white70)),
            )
          ],
        ),
      ),
    );
  }

  Widget _primaryButton(String text, VoidCallback? onTap, {bool isLoading = false}) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: onTap,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(text,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _glassCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 6))
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            final angle = _controller.value * pi;
            final isFront = angle < pi / 2;

            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(angle),
              child: isFront
                  ? _loginForm()
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: _registerForm(),
                    ),
            );
          },
        ),
      ),
    );
  }
}