import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_manager_application/domain/models/link.dart';

class FireStoreLinkService {
  final CollectionReference _linksCollection =
      FirebaseFirestore.instance.collection('links');
  Link? _selectedLink;
  void setSelectedLink(Link link) {
    _selectedLink = link;
  }

  Link? getSelectedLink() {
    return _selectedLink;
  }

  // Método para obtener todos los links
  Future<List<Link>> getLinks() async {
    QuerySnapshot querySnapshot = await _linksCollection.get();
    return querySnapshot.docs.map((doc) {
      return Link.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

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
    await _linksCollection.doc(link.id).set(link.toJson());
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
