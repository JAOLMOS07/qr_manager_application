import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_manager_application/domain/controllers/content_controller.dart';
import 'package:qr_manager_application/domain/models/content.dart';

class ContentListPage extends StatelessWidget {
  final ContentController contentController = Get.find<ContentController>();
  final TextEditingController _searchController = TextEditingController();

  ContentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ContentController>(
          builder: (ContentController) => Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/fondo1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              contentController.filterContents(value);
                            },
                            style: TextStyle(
                              color: Color.fromARGB(251, 89, 123, 236),
                              fontWeight: FontWeight.w300,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(
                                color: Color.fromARGB(184, 89, 123, 236),
                              ),
                              hintText: "Buscar contenido",
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  itemCount:
                                      contentController.filteredcontents.length,
                                  itemBuilder: (context, index) {
                                    final content = contentController
                                        .filteredcontents[index];
                                    return CustomContentItem(content: content);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/content/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CustomContentItem extends StatelessWidget {
  final Content content;

  const CustomContentItem({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 5),
          leading: Container(
            width: 80,
            height: 80,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(content.logoUrl),
            ),
          ),
          title: Text(
            content.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            content.description,
            style: TextStyle(fontSize: 14),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
      ),
    );
  }
}
