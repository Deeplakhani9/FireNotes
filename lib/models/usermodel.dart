class UserModel {
  String? Uid;
  String? email;
  String? password;

  UserModel({
    this.Uid,
    this.email,
    this.password,
  });
  UserModel.fromMap(Map<String, dynamic> map) {
    Uid = map['Uid'];
    email = map['email'];
    password = map['password'];
  }
  Map<String, dynamic> toMap() {
    return {
      'Uid': Uid,
      'email': email,
      'password': password,
    };
  }
}
