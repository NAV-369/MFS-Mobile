class Environment {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:5000/api',
  );
  
  static const String appName = 'Flip Mobile';
  static const String version = '1.0.0';
  
  // API endpoints
  static const String authEndpoint = '/auth';
  static const String balanceEndpoint = '/balance';
  static const String transactionsEndpoint = '/transactions';
  static const String loansEndpoint = '/loans';
  static const String transfersEndpoint = '/transfers';
  static const String depositsEndpoint = '/deposits';
  static const String withdrawalsEndpoint = '/withdrawals';
  static const String notificationsEndpoint = '/notifications';
  static const String auditEndpoint = '/audit';
  static const String adminEndpoint = '/admin';
  
  // Storage keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
}