
import '../../domain/entities/account.dart';

class AccountModal extends Account {
  const AccountModal({
    required super.password,
    required super.id,
    super.rePassword
});

  factory AccountModal.fromJson(Map<String, dynamic> json) {
    return AccountModal(
      password: json['password'],
      id: json['id'],
      rePassword: json['re-password']
    );
  }

  static Map<String, dynamic> toJson(AccountModal accountModal) {
    return {
      'id' : accountModal.id,
      'password' : accountModal.password,
      're-password' : accountModal.rePassword
    };
  }
}