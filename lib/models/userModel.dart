class UserModel {
  String email;
  String password;
  String? name;
  String? confirmPassword;

  UserModel(
      {required this.email,
      required this.password,
      this.name,
      this.confirmPassword});
}
