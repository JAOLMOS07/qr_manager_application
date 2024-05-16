import 'package:get/get.dart';
import 'package:qr_manager_application/domain/models/content.dart';
import 'package:qr_manager_application/services/content_service.dart';

class ContentController extends GetxController {
  final ContentService _contentService = ContentService();

  List<Content> contents = <Content>[].obs;
  List<Content> filteredcontents = <Content>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAndSetContents();
  }

  Future<void> fetchAndSetContents() async {
    contents = await _contentService.fetchContents();
    filteredcontents = contents;
    update();
  }

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
      List<String> multimedia) async {
    try {
      await _contentService.createContent(title, description, logo, multimedia);
      fetchAndSetContents();
    } catch (error) {
      print('Error creating content: $error');
    }
  }
}
