class User{

  final String user;
  final String token;

  User({required this.user, required this.token});

  factory User.fromJson(Map<String, dynamic> json){
    return User(user: json["user"], token: json["token"]);
  }
}