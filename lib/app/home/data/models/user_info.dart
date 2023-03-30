import '../../domain/entities/user_info.dart';

class UserInfoModal extends UserInfoEntity {
  const UserInfoModal({
    required super.phone,
    required super.group,
    required super.id,
    required super.email,
    required super.displayName,
    required super.gender,
    required super.birthday,
    required super.background,
    required super.avatar
});

  factory UserInfoModal.fromJson(Map<String, dynamic> json) {
    return UserInfoModal(
      displayName: json['display_name'],
      birthday: json['birthday'],
      gender: json['gender'] == 1,
      phone: json['phone_number'],
      email: json['email'],
      id: json['id'],
      group: json['group_class'],
      avatar: json['avatar'],
      background: json['background']
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'display_name' : displayName,
      'birthday' : birthday,
      'gender' : gender,
      'phone_number' : phone,
      'email' : email,
      'id' : id,
      'group_class' : group,
      'avatar' : avatar,
      'background' : background
    };
  }
}