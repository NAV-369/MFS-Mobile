import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/env.dart';
import '../models/user_model.dart';
import '../models/transaction_model.dart';
import '../models/balance_model.dart' as balance_model;
import '../models/loan_model.dart' as loan_model;
import '../utils/storage_utils.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final http.Client _client = http.Client();
  String? _accessToken;

  // Initialize with stored token
  Future<void> initialize() async {
    _accessToken = await StorageUtils.getString(Environment.accessTokenKey);
  }

  // Set token after login
  void setToken(String token) {
    _accessToken = token;
  }

  // Clear token on logout
  void clearToken() {
    _accessToken = null;
  }

  // Get headers with auth
  Map<String, String> get _headers {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (_accessToken != null) {
      headers['Authorization'] = 'Bearer $_accessToken';
    }
    return headers;
  }

  // Handle API response
  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      final error = json.decode(response.body);
      throw ApiException(
        message: error['error'] ?? 'Unknown error',
        statusCode: response.statusCode,
      );
    }
  }

  // Auth endpoints
  Future<AuthResponse> login(String username, String password) async {
    final response = await _client.post(
      Uri.parse('${Environment.apiBaseUrl}${Environment.authEndpoint}/login'),
      headers: _headers,
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    final data = _handleResponse(response);
    final authResponse = AuthResponse.fromJson(data);
    
    // Store tokens
    await StorageUtils.setString(Environment.accessTokenKey, authResponse.accessToken);
    await StorageUtils.setString(Environment.refreshTokenKey, authResponse.refreshToken);
    await StorageUtils.setString(Environment.userDataKey, json.encode(authResponse.user.toJson()));
    
    setToken(authResponse.accessToken);
    return authResponse;
  }

  Future<AuthResponse> register(String username, String email, String password, {String role = 'client'}) async {
    final response = await _client.post(
      Uri.parse('${Environment.apiBaseUrl}${Environment.authEndpoint}/register'),
      headers: _headers,
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
        'role': role,
      }),
    );

    final data = _handleResponse(response);
    final authResponse = AuthResponse.fromJson(data);
    
    // Store tokens
    await StorageUtils.setString(Environment.accessTokenKey, authResponse.accessToken);
    await StorageUtils.setString(Environment.refreshTokenKey, authResponse.refreshToken);
    await StorageUtils.setString(Environment.userDataKey, json.encode(authResponse.user.toJson()));
    
    setToken(authResponse.accessToken);
    return authResponse;
  }

  Future<String> refreshToken() async {
    final refreshToken = await StorageUtils.getString(Environment.refreshTokenKey);
    if (refreshToken == null) throw ApiException(message: 'No refresh token', statusCode: 401);

    final response = await _client.post(
      Uri.parse('${Environment.apiBaseUrl}${Environment.authEndpoint}/refresh'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $refreshToken',
      },
    );

    final data = _handleResponse(response);
    final newToken = data['access_token'];
    
    await StorageUtils.setString(Environment.accessTokenKey, newToken);
    setToken(newToken);
    
    return newToken;
  }

  Future<User> getCurrentUser() async {
    final response = await _client.get(
      Uri.parse('${Environment.apiBaseUrl}${Environment.authEndpoint}/me'),
      headers: _headers,
    );

    final data = _handleResponse(response);
    return User.fromJson(data['user']);
  }

  // Balance endpoints
  Future<balance_model.Balance> getBalance() async {
    final response = await _client.get(
      Uri.parse('${Environment.apiBaseUrl}${Environment.balanceEndpoint}/'),
      headers: _headers,
    );

    final data = _handleResponse(response);
    return balance_model.Balance.fromJson(data['balance']);
  }

  // Transaction endpoints
  Future<List<Transaction>> getTransactions() async {
    final response = await _client.get(
      Uri.parse('${Environment.apiBaseUrl}${Environment.transactionsEndpoint}/'),
      headers: _headers,
    );

    final data = _handleResponse(response);
    return (data['transactions'] as List)
        .map((json) => Transaction.fromJson(json))
        .toList();
  }

  // Deposit endpoints
  Future<Map<String, dynamic>> createDeposit(double amount) async {
    final response = await _client.post(
      Uri.parse('${Environment.apiBaseUrl}${Environment.depositsEndpoint}/'),
      headers: _headers,
      body: json.encode({'amount': amount}),
    );

    return _handleResponse(response);
  }

  Future<List<Transaction>> getDeposits() async {
    final response = await _client.get(
      Uri.parse('${Environment.apiBaseUrl}${Environment.depositsEndpoint}/'),
      headers: _headers,
    );

    final data = _handleResponse(response);
    return (data['deposits'] as List)
        .map((json) => Transaction.fromJson(json))
        .toList();
  }

  // Withdrawal endpoints
  Future<Map<String, dynamic>> createWithdrawal(double amount) async {
    final response = await _client.post(
      Uri.parse('${Environment.apiBaseUrl}${Environment.withdrawalsEndpoint}/'),
      headers: _headers,
      body: json.encode({'amount': amount}),
    );

    return _handleResponse(response);
  }

  Future<List<Transaction>> getWithdrawals() async {
    final response = await _client.get(
      Uri.parse('${Environment.apiBaseUrl}${Environment.withdrawalsEndpoint}/'),
      headers: _headers,
    );

    final data = _handleResponse(response);
    return (data['withdrawals'] as List)
        .map((json) => Transaction.fromJson(json))
        .toList();
  }

  // Transfer endpoints
  Future<Map<String, dynamic>> createTransfer(String recipientUsername, double amount) async {
    final response = await _client.post(
      Uri.parse('${Environment.apiBaseUrl}${Environment.transfersEndpoint}/'),
      headers: _headers,
      body: json.encode({
        'recipient_username': recipientUsername,
        'amount': amount,
      }),
    );

    return _handleResponse(response);
  }

  Future<List<Transaction>> getTransfers() async {
    final response = await _client.get(
      Uri.parse('${Environment.apiBaseUrl}${Environment.transfersEndpoint}/'),
      headers: _headers,
    );

    final data = _handleResponse(response);
    return (data['transfers'] as List)
        .map((json) => Transaction.fromJson(json))
        .toList();
  }

  // Loan endpoints
  Future<Map<String, dynamic>> requestLoan(double principal, double interestRate, int termMonths) async {
    final response = await _client.post(
      Uri.parse('${Environment.apiBaseUrl}${Environment.loansEndpoint}/'),
      headers: _headers,
      body: json.encode({
        'principal': principal,
        'interest_rate': interestRate,
        'term_months': termMonths,
      }),
    );

    return _handleResponse(response);
  }

  Future<List<loan_model.Loan>> getLoans() async {
    final response = await _client.get(
      Uri.parse('${Environment.apiBaseUrl}${Environment.loansEndpoint}/'),
      headers: _headers,
    );

    final data = _handleResponse(response);
    return (data['loans'] as List)
        .map((json) => loan_model.Loan.fromJson(json))
        .toList();
  }

  // Health check
  Future<Map<String, dynamic>> healthCheck() async {
    final response = await _client.get(
      Uri.parse('${Environment.apiBaseUrl.replaceAll('/api', '')}/api/health'),
      headers: _headers,
    );

    return _handleResponse(response);
  }

  void dispose() {
    _client.close();
  }
}

class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException({required this.message, required this.statusCode});

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}
