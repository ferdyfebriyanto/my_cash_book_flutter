class UserModel {
  int? id;
  String? username, password, createdAt, updatedAt;

  UserModel(
      {this.id, this.username, this.password, this.createdAt, this.updatedAt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        username: json['username'],
        password: json['password'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
