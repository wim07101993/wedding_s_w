import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wedding_s_w/features/song_requests/models/song_request.dart';

extension SongRequestsFirebaseFirestoreExtensions on FirebaseFirestore {
  CollectionReference<SongRequest> get songRequests {
    return collection('songRequests').withConverter<SongRequest>(
      fromFirestore: (doc, snapshot) {
        final data = doc.data();
        return data == null
            ? SongRequest.freeInput(input: '')
            : SongRequest.fromFirebase(data);
      },
      toFirestore: (songRequest, options) => songRequest.toFirebase(),
    );
  }
}
