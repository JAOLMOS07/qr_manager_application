import 'package:get/get.dart';
import 'package:qr_manager_application/domain/models/content.dart';
import 'package:qr_manager_application/domain/models/link.dart';
import 'package:qr_manager_application/services/link_service.dart';

class LinkController extends GetxController {
  final LinkService _linkService = LinkService();

  List<Link> links = <Link>[].obs;
  List<Link> filteredLinks = <Link>[].obs;
  Link? selectedLink; // Enlace seleccionado
  dynamic linkSelected;
  @override
  void onInit() {
    super.onInit();
    fetchLinks();
  }

  void selectLink(Link link) {
    selectedLink = link;
    update();
  }

  Future<void> fetchLinks() async {
    links = await _linkService.fetchLinks();
    filteredLinks = links;
    update();
  }

  Future<void> createLink(int subscriptionType) async {
    try {
      await _linkService.createLink(subscriptionType);
      fetchLinks(); // Actualiza la lista de enlaces después de crear uno nuevo
    } catch (e) {
      print('Error creating link: $e');
    }
  }

  void filterLinks(String searchText) {
    if (searchText.isEmpty) {
      // Mostrar todos los enlaces si el campo de búsqueda está vacío
      filteredLinks = links;
    } else {
      // Filtrar los enlaces basados en el texto de búsqueda
      filteredLinks = links
          .where((link) =>
              link.contentTitle
                  ?.toLowerCase()
                  .contains(searchText.toLowerCase()) ??
              false)
          .toList();
    }
    update(); // Actualizar la interfaz de usuario con los enlaces filtrados
  }

  Future<void> assignContent(Link link, Content content) async {
    try {
      await _linkService.assignContent(link, content);
      fetchLinks();
    } catch (e) {
      print('Error creating link: $e');
    }
  }
}
