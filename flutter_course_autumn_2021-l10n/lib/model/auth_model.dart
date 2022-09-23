class AuthModel {
  String? password;
  bool? rememberMe;
  String? username;
  String? token;

  AuthModel(
      {required this.password,
      required this.rememberMe,
      required this.username,
      this.token});

  AuthModel.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    rememberMe = json['rememberMe'];
    username = json['username'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['rememberMe'] = this.rememberMe;
    data['username'] = this.username;
    data['token'] = this.token;
    return data;
  }
}
