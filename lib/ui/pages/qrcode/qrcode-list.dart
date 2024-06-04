import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_manager_application/domain/models/link.dart';
import 'package:qr_manager_application/services/link_service.dart';

class LinkListPage extends StatefulWidget {
  const LinkListPage({super.key});

  @override
  _LinkListPageState createState() => _LinkListPageState();
}

class _LinkListPageState extends State<LinkListPage> {
  final TextEditingController _searchController = TextEditingController();
  final FireStoreLinkService fireStoreLinkService = FireStoreLinkService();
  List<Link> _links = [];
  List<Link> _allLinks = [];
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchLinks();
  }

  Future<void> _fetchLinks() async {
    setState(() {
      _isLoading = true;
    });
    _allLinks = await fireStoreLinkService.getLinks();
    _links = List.from(_allLinks);
    setState(() {
      _isLoading = false;
    });
  }

  void _filterLinks(String query) {
    if (query.isEmpty) {
      setState(() {
        _links = List.from(_allLinks);
      });
    } else {
      setState(() {
        _links = _allLinks.where((link) {
          return (link.contentTitle ?? '')
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              link.lastRenewalDate.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                      _filterLinks(value);
                    },
                    style: const TextStyle(
                      color: Color.fromARGB(251, 89, 123, 236),
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      filled: true,
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(184, 89, 123, 236),
                      ),
                      hintText: "Buscar link",
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                itemCount: _links.length,
                                itemBuilder: (context, index) {
                                  return CustomLinkItem(
                                    link: _links[index],
                                    onLinkAssigned: _fetchLinks,
                                  );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.toNamed('/link/create');
          _fetchLinks(); // Refrescar la lista de links después de volver de la página de creación
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CustomLinkItem extends StatelessWidget {
  final Link link;
  final VoidCallback onLinkAssigned;

  CustomLinkItem({
    super.key,
    required this.link,
    required this.onLinkAssigned,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
          leading: const SizedBox(
            width: 80,
            height: 80,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors
                  .blue, // Puede ser cualquier color o imagen según el link
              child: const Icon(Icons.link, color: Colors.white),
            ),
          ),
          title: Text(
            link.contentTitle ?? 'Sin título',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Última renovación: ${link.lastRenewalDate}',
            style: const TextStyle(fontSize: 14),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () async {
            await Get.toNamed('/link/assign', arguments: link);
            onLinkAssigned(); // Llamar a la función de refrescar la lista
          },
        ),
      ),
    );
  }
}
