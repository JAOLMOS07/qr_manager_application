import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_manager_application/domain/controllers/link_controller.dart';
import 'package:qr_manager_application/domain/models/link.dart';

class QrCodeListPage extends StatelessWidget {
  final LinkController linkController = Get.find<LinkController>();
  final TextEditingController _searchController = TextEditingController();

  QrCodeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LinkController>(
        builder: (linkController) => Stack(
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
                        linkController.filterLinks(value);
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
                        hintText: "Buscar link por contenido",
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
                            itemCount: linkController.filteredLinks.length,
                            itemBuilder: (context, index) {
                              final link = linkController.filteredLinks[index];
                              return CustomLinkItem(link: link);
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/link/create');
        },
        child: const Icon(Icons.qr_code_2_outlined),
      ),
    );
  }
}

class CustomLinkItem extends StatelessWidget {
  final Link link;

  const CustomLinkItem({
    super.key,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    final LinkController linkController = Get.find<LinkController>();
    const List<String> subscriptionTypes = ["Anual", "Mensual", "vitalicia"];

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
              radius: 20,
              backgroundImage: AssetImage(
                link.contentId != null
                    ? 'assets/imgqr.png'
                    : 'assets/imgqrEmpty.png',
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
          title: Text(
            link.contentTitle ?? 'Link sin contenido',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Suscripción: ${subscriptionTypes[link.subscriptionType]}",
            style: TextStyle(fontSize: 14),
          ),
          trailing: Icon(Icons.add_link),
          onTap: () {
            linkController.selectLink(link); // Seleccionar el enlace
            Get.toNamed('/link/assign');
          },
        ),
      ),
    );
  }
}
