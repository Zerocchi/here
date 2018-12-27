class Key {
  final String clientId;
  final String clientSecret;

  Key({this.clientId = "", this.clientSecret = ""});

  factory Key.fromJson(Map<String, dynamic> json) {
    return Key(clientId: json["client_id"], clientSecret: json["client_secret"]);
  }
}