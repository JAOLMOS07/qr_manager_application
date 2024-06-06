import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_manager_application/domain/models/content.dart';
import 'package:qr_manager_application/services/auth_service.dart';

class FireStoreContentService {
  final AuthService _authService = AuthService();
  final CollectionReference _contentsCollection =
      FirebaseFirestore.instance.collection('contents');

  // CREATE
  Future<void> addContent(Content content) async {
    User? currentUser = await _authService.getCurrentUser();
    if (currentUser != null) {
      await _contentsCollection.doc(content.id).set({
        ...content.toJson(),
        'userUID': currentUser.uid,
      });
    } else {
      throw Exception("No user currently logged in");
    }
  }

  // READ
  Future<List<Content>> getContents() async {
    try {
      User? currentUser = await _authService.getCurrentUser();
      if (currentUser != null) {
        QuerySnapshot snapshot = await _contentsCollection
            .where('userUID', isEqualTo: currentUser.uid)
            .get();
        return snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Content(
            id: doc.id,
            title: data['title'] ?? '',
            description: data['description'] ?? '',
            logoUrl: data['logoUrl'] ?? '',
            multimedia: List<String>.from(data['multimedia'] ?? []),
            createdOn: data['createdOn']?.toString() ?? '',
            lastModifiedOn: data['lastModifiedOn']?.toString() ?? '',
            networks: Map<String, String>.from(data['networks'] ?? {}),
          );
        }).toList();
      } else {
        throw Exception("No user currently logged in");
      }
    } catch (e) {
      print('Error getting contents: $e');
      return [];
    }
  }
}

// Extensión para convertir un Content a un Map (JSON)
extension ContentExtension on Content {
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'logoUrl': logoUrl,
      'multimedia': multimedia,
      'createdOn': createdOn,
      'lastModifiedOn': lastModifiedOn,
      'networks': networks,
    };
  }
}
