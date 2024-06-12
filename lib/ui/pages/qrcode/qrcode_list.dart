import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
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

  Future<void> _deleteLink(Link link) async {
    setState(() {
      _isLoading = true;
    });
    await fireStoreLinkService.deleteLink(link.id);
    await _fetchLinks();
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

  void _confirmDelete(BuildContext context, Link link) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: "¿Estás seguro?",
      text: '¿Quieres eliminar este enlace?',
      confirmBtnText: 'Sí',
      cancelBtnText: 'No',
      showConfirmBtn: true,
      showCancelBtn: true,
      confirmBtnColor: Colors.green,
      onConfirmBtnTap: () async {
        Get.back(); // Cerrar el diálogo de confirmación
        await _deleteLink(link);
      },
      onCancelBtnTap: () {
        Get.back(); // Cerrar el diálogo de confirmación
        _fetchLinks(); // Refrescar la lista de enlaces
      },
    );
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
                      hintText: "Buscar enlace",
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
                                  return Dismissible(
                                    key: Key(_links[index].id),
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      color: Colors.red,
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    confirmDismiss: (direction) async {
                                      _confirmDelete(context, _links[index]);
                                      return false; // Previene la eliminación automática
                                    },
                                    child: CustomLinkItem(
                                      link: _links[index],
                                      onLinkAssigned: _fetchLinks,
                                    ),
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
          _fetchLinks(); // Refrescar la lista de enlaces después de volver de la página de creación
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
        height: 90,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
          leading: SizedBox(
            width: 80,
            height: 80,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(link.contentLogoUrl ??
                  "https://firebasestorage.googleapis.com/v0/b/qr-manager-3dabf.appspot.com/o/white.png?alt=media&token=5d2d9dad-d2c7-4707-8c5f-3f698d1da352"), // Puede ser cualquier color o imagen según el enlace
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(129, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset:
                          const Offset(0, 3), // Cambia la posición de la sombra
                    ),
                  ],
                ),
                child: Icon(
                  link.contentId != null
                      ? Icons.qr_code_2_outlined
                      : Icons.link,
                  color: link.contentId != null
                      ? const Color.fromARGB(255, 88, 88, 88)
                      : const Color.fromARGB(205, 35, 35, 35),
                  size: 30,
                ),
              ),
            ),
          ),
          title: Text(
            link.contentTitle ?? 'Asignar contenido',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            link.lastRenewalDate,
            style: const TextStyle(fontSize: 10),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Icon(link.contentId != null
              ? Icons.arrow_forward_ios_rounded
              : Icons.link),
          onTap: () async {
            await Get.toNamed('/link/assign', arguments: link);
            onLinkAssigned();
          },
        ),
      ),
    );
  }
}
