import 'package:get/get.dart';
import 'package:qr_manager_application/domain/models/content.dart';
import 'package:qr_manager_application/services/content_service.dart';

class ContentController extends GetxController {
  List<Content> contents = <Content>[].obs;
  List<Content> filteredcontents = <Content>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAndSetContents();
  }

  Future<void> fetchAndSetContents() async {}

  void filterContents(String searchText) {
    if (searchText.isEmpty) {
      filteredcontents = contents;
    } else {
      filteredcontents = contents
          .where((content) =>
              (content.title.toLowerCase().contains(searchText.toLowerCase())))
          .toList();
    }
    update();
  }

  void createContent(String title, String description, String logo,
      List<String> multimedia) async {}
}
