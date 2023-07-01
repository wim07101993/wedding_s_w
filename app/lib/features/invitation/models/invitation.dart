import 'package:wedding_s_w/shared/json_extensions.dart';

abstract class Invitation {
  factory Invitation.party({
    required String user,
  }) = _PartyInvitation;

  factory Invitation.dinner({
    required String user,
  }) = _DinnerInvitation;

  factory Invitation.fromFirebase(Map<String, dynamic> json) {
    final type = json[typeFieldName];
    if (type == _PartyInvitation.type) {
      return _PartyInvitation.fromJson(json);
    } else if (type == _DinnerInvitation.type) {
      return _DinnerInvitation.fromJson(json);
    } else {
      throw Exception('unknown invitation type $type');
    }
  }

  String get user;

  static const String typeFieldName = 'type';
  static const String userFieldName = 'user';
}

class _PartyInvitation implements Invitation {
  const _PartyInvitation({
    required this.user,
  });

  factory _PartyInvitation.fromJson(Map<String, dynamic> json) {
    return _PartyInvitation(
      user: json.get(Invitation.userFieldName),
    );
  }

  @override
  final String user;

  static const String type = 'party';
}

class _DinnerInvitation implements Invitation {
  const _DinnerInvitation({
    required this.user,
  });

  factory _DinnerInvitation.fromJson(Map<String, dynamic> json) {
    return _DinnerInvitation(
      user: json.get(Invitation.userFieldName),
    );
  }

  @override
  final String user;

  static const String type = 'dinner';
}
