class UserModel {
  int? id_user;
  String? username, password, createdAt, updatedAt;

  UserModel(
      {this.id_user,
      this.username,
      this.password,
      this.createdAt,
      this.updatedAt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id_user: json['id_user'],
        username: json['username'],
        password: json['password'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
