class UserModel {
  String userName = "";
  String email = "";
  String password = "";

  UserModel(this.userName, this.email, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_name': userName,
      'email': email,
      'password': password
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    userName = map['user_name'];
    email = map['email'];
    password = map['password'];
  }
}
