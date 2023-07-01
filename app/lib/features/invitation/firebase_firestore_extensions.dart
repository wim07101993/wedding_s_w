import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wedding_s_w/features/invitation/models/invitation.dart';

extension InvitationFirebaseFirestoreExtensions on FirebaseFirestore {
  CollectionReference<Invitation> get invitations =>
      collection('invitations').withConverter(
        fromFirestore: (doc, snapshot) {
          final data = doc.data();
          if (data == null) {
            throw Exception('document found without data: ${doc.id}');
          }
          return Invitation.fromFirebase(data);
        },
        toFirestore: (invitation, options) {
          throw Exception('cannot write invitations');
        },
      );
}
