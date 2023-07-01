import 'package:behaviour/behaviour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wedding_s_w/features/invitation/firebase_firestore_extensions.dart';
import 'package:wedding_s_w/features/invitation/models/invitation.dart';

class GetUserInvitation extends Behaviour<String, Invitation?> {
  GetUserInvitation({
    super.monitor,
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  @override
  Future<Invitation?> action(String input, BehaviourTrack? track) {
    return firestore.invitations
        .where(Invitation.userFieldName, isEqualTo: input.toLowerCase())
        .get()
        .then((value) => value.docs.firstOrNull?.data());
  }
}
