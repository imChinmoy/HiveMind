class AppConstants {

  static const String apiBaseUrl = "https://api.hivemind.com";
  static const String apiDevelopmentUrl = "http://localhost:3000";

}

class AppEndpoints{
  static const String register = "/auth/register";
  static const String login = "/auth/login";

  static const String getServers = '/servers/myservers';
  static const String joinServer = '/servers/join';
  static const String leaveServer = '/servers/leave';
  static const String createServer = '/servers/create';
}