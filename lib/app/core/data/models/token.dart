import '../../domain/entities/token.dart';

class TokenModal extends Token {
  TokenModal({required super.token, required super.refreshToken});

  factory TokenModal.fromJson(Map<String, dynamic> json) {
    return TokenModal(
        token: json['token'],
        refreshToken: json['re-fresh-token'],
    );
  }

  static Map<String, dynamic> toJson(TokenModal tokenModal) {
    return {
      'token': tokenModal.token,
      're-fresh-token': tokenModal.refreshToken,
    };
  }
}