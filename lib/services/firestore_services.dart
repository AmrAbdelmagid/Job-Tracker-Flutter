import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  FirestoreServices._();
  static final instance = FirestoreServices._();

  Future<void> setData(
    String path,
    Map<String, dynamic> data,
  ) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data);
  }

  Stream<List<T?>> collectionStream<T>({
    required String path,
    required T? Function(Map<String, dynamic> data) builder,
  }) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map(
          (snapshot) {
            final Map<String, dynamic>? data = snapshot.data();
            if (data != null) {
              return builder(data);
            } else {
              return null;
            }
          },
        ).toList());
  }
}
