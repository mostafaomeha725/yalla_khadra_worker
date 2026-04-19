class EndPoints {
  static const String apiSecret = 'kJ5kHX2vCfiy0zc2mWulKgZy0TFo6pTF';

  /// Auth endpoints
  static const String register = 'auth/register';

  static const String login = 'auth/login';

  static const String sendOtp = 'send-otp';

  static const String verifyOtp = 'auth/verify-otp';

  static const String resendOtp = 'auth/receive-otp';

  static const String forgotPassword = 'auth/forgot-password';

  static const String resetPassword = 'auth/reset-password';

  /// Profile endpoints
  static const String profileSetup = 'profile/setup';
  static const String profile = 'profile';
  static const String currencies = 'currencies';
  static const String savedProperties = 'saved-properties';

  static const String homeProperties = 'properties';

  /// Wallet endpoints
  static const String wallet = 'wallet';
  static const String walletCurrency = 'wallet/currency';

  static const String allTransactions = 'transactions';

  /// Notification endpoints
  static const String notifications = 'notifications';

  /// Rewards endpoints
  static const String rewardsTier = 'rewards/tier';
  static const String rewards = 'rewards';

  /// Referral endpoints
  static const String referralStats = 'referral/stats';

  /// Deposit endpoints
  static const String deposit = 'payments/deposit-intent';

  /// Investment endpoints
  static const String investments = 'investments';
  static const String calculateReturns =
      'investments/calculate-returns';
  static const String portfolio = 'portfolio';
  static const String portfolioProperties = 'portfolio/properties';
  static const String propertyCalculator = 'properties';
}
