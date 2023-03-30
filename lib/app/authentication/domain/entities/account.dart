class Account {
  const Account({required this.id, required this.password, this.rePassword});
  
  final String id;
  final String password;
  final String? rePassword;
}