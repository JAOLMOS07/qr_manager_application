import 'package:get/get.dart';
import 'package:qr_manager_application/domain/models/content.dart';
import 'package:qr_manager_application/domain/models/link.dart';

class LinkController extends GetxController {
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

  Future<void> fetchLinks() async {}

  Future<void> createLink(int subscriptionType) async {}

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

  Future<void> assignContent(Link link, Content content) async {}
}
