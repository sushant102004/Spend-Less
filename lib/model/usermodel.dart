class UserModel {
  final String? displayName;
  final String? email;
  final String uid;
  final int balanceOut;
  final int balanceIn;

  UserModel(
      {required this.displayName,
      required this.email,
      required this.uid,
      required this.balanceOut,
      required this.balanceIn});
}
