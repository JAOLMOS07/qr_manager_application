import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_manager_application/domain/models/link.dart';
import 'package:qr_manager_application/services/auth_service.dart';

class FireStoreLinkService {
  final AuthService _authService = AuthService();
  final CollectionReference _linksCollection =
      FirebaseFirestore.instance.collection('links');

  // Método para obtener todos los links del usuario actual
  Future<List<Link>> getLinks() async {
    try {
      User? currentUser = await _authService.getCurrentUser();
      if (currentUser != null) {
        QuerySnapshot querySnapshot = await _linksCollection
            .where('userUID', isEqualTo: currentUser.uid)
            .get();
        return querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Link.fromJson(data);
        }).toList();
      } else {
        throw Exception("No user currently logged in");
      }
    } catch (e) {
      return [];
    }
  }

  // Método para obtener un link por ID
  Future<Link?> getLinkById(String linkId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _linksCollection.doc(linkId).get();
      if (documentSnapshot.exists) {
        return Link.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching link by id: $e');
      return null;
    }
  }

  // Método para agregar un nuevo link
  Future<void> addLink(Link link) async {
    User? currentUser = await _authService.getCurrentUser();
    if (currentUser != null) {
      await _linksCollection.doc(link.id).set({
        ...link.toJson(),
        'userUID': currentUser.uid,
      });
    } else {
      throw Exception("No user currently logged in");
    }
  }

  // Método para actualizar un link existente
  Future<void> updateLink(Link link) async {
    await _linksCollection.doc(link.id).update(link.toJson());
  }

  // Método para eliminar un link
  Future<void> deleteLink(String id) async {
    await _linksCollection.doc(id).delete();
  }
}

// Extensión para convertir un Link a un Map (JSON)
extension LinkExtension on Link {
  Map<String, dynamic> toJson() {
    return {
      'contentId': contentId,
      'contentTitle': contentTitle,
      'contentLogoUrl': contentLogoUrl,
      'lastRenewalDate': lastRenewalDate,
      'subscriptionType': subscriptionType,
      'active': active,
      'id': id,
      'deletedOn': deletedOn?.toIso8601String(),
      'createdOn': createdOn.toIso8601String(),
      'lastModifiedOn': lastModifiedOn.toIso8601String(),
    };
  }
}
