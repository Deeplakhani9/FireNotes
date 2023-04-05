import 'package:cloud_firestore/cloud_firestore.dart';

class StoreHelper {
  StoreHelper._();
  static final StoreHelper storeHelper = StoreHelper._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  CollectionReference? collectionReference;
  connectCollection() {
    collectionReference = fireStore.collection('notes');
  }

  Future<void> addNote({
    required String title,
    required String subtitle,
  }) async {
    connectCollection();
    String nId = DateTime.now().millisecondsSinceEpoch.toString();
    await collectionReference!
        .doc(nId)
        .set({
          'id': nId,
          'title': title,
          'subtitle': subtitle,
        })
        .then(
          (value) => print("note is add...."),
        )
        .catchError((error) => print("$error"));
  }

  Stream<QuerySnapshot<Object?>> getNotes() {
    connectCollection();

    return collectionReference!.snapshots();
  }

  editNote({required String id, required Map<Object, Object> data}) {
    connectCollection();

    collectionReference!
        .doc(id)
        .update(data)
        .then((value) => print("Notes Edit..."))
        .catchError((error) => print(error));
  }

  removeNotes({required String id}) {
    connectCollection();

    collectionReference!
        .doc(id)
        .delete()
        .then((value) => print("notes delete.."))
        .catchError((error) {
      print(error);
    });
  }
}
