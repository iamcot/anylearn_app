class LoginCallback {
  final message;
  final routeName;
  final routeArgs;

  LoginCallback({this.message = "", this.routeName = "", this.routeArgs = ""});

  @override
  String toString() {
    return 'LoginCallback {message: $message, routeName: $routeName, routeArgs: $routeArgs}';
  }
}
