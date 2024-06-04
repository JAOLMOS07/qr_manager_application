import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_manager_application/domain/models/content.dart';

class FireStoreContentService {
  final CollectionReference contents =
      FirebaseFirestore.instance.collection('Contents');

  // CREATE
  Future<void> addContent(Content content) {
    return contents.add({
      'title': content.title,
      'description': content.description,
      'logoUrl': content.logoUrl,
      'multimedia': content.multimedia,
      'createdOn': Timestamp.now(),
      'lastModifiedOn': Timestamp.now(),
    });
  }

  // READ
  Future<List<Content>> getContents() async {
    try {
      QuerySnapshot snapshot = await contents.get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Content(
          id: doc.id,
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          logoUrl: data['logoUrl'] ?? '',
          multimedia: List<String>.from(data['multimedia'] ?? []),
          createdOn: data['createdOn']?.toDate().toString() ?? '',
          lastModifiedOn: data['lastModifiedOn']?.toDate().toString() ?? '',
        );
      }).toList();
    } catch (e) {
      print('Error getting contents: $e');
      return [];
    }
  }
}
