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

  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.delete();
  }

  Stream<List<T?>> collectionStream<T>({
    required String path,
    required T? Function(Map<String, dynamic> data, String documentId) builder,
  }) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map(
          (snapshot) {
            final Map<String, dynamic>? data = snapshot.data();
            if (data != null) {
              return builder(data, snapshot.id);
            } else {
              return null;
            }
          },
        ).toList());
  }
}
