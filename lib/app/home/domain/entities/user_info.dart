class UserInfoEntity {
  const UserInfoEntity({
    required this.displayName,
    required this.birthday,
    required this.gender,
    required this.avatar,
    required this.background,
    required this.email,
    required this.id,
    required this.group,
    required this.phone
  });
  final String displayName;
  final String birthday;
  final bool gender;
  final String avatar;
  final String background;
  final int group;
  final String email;
  final String phone;
  final String id;
}