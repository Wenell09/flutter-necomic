class UserModel {
  final String uid, email, username, photo;

  UserModel(
      {required this.uid,
      required this.email,
      required this.username,
      required this.photo});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"] ?? "",
      email: json["email"] ?? "",
      username: json["username"] ?? "",
      photo: json["photo"] ?? "",
    );
  }
}
