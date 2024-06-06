import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_manager_application/domain/models/content.dart';
import 'package:qr_manager_application/services/firestore.dart';
import 'package:qr_manager_application/services/content_service.dart';
import 'package:qr_manager_application/services/select_image.dart';

class AddContentPage extends StatefulWidget {
  const AddContentPage({super.key});

  @override
  _AddContentPageState createState() => _AddContentPageState();
}

class _AddContentPageState extends State<AddContentPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  XFile? imageLogo;
  List<XFile> imagesMultimedia = [];
  final FireStoreService fireStoreService = FireStoreService();
  final FireStoreContentService fireStoreContentService =
      FireStoreContentService();
  bool _isLoading = false;

  // Lista de redes sociales seleccionadas
  List<String> selectedNetworks = [];
  Map<String, TextEditingController> networkControllers = {};

  Future<void> selectImages() async {
    final List<XFile?> pickedImages = await getMultiImage();
    setState(() {
      imagesMultimedia = pickedImages.whereType<XFile>().toList();
    });
  }

  Future<Uint8List> fileToUint8List(XFile file) async {
    return await file.readAsBytes();
  }

  Future<void> createContent() async {
    setState(() {
      _isLoading = true;
    });

    final String title = titleController.text;
    final String description = descriptionController.text;

    try {
      // Subir la imagen del logo y obtener la URL
      String? logoUrl;
      if (imageLogo != null) {
        Uint8List logoData = await fileToUint8List(imageLogo!);
        logoUrl = await fireStoreService.uploadImage(
          logoData,
          'logos/${DateTime.now().millisecondsSinceEpoch}_${imageLogo!.name}',
        );
      }

      // Subir las imágenes multimedia y obtener sus URLs
      List<String> multimediaUrls = [];
      for (var image in imagesMultimedia) {
        Uint8List imageData = await fileToUint8List(image);
        String? url = await fireStoreService.uploadImage(
          imageData,
          'multimedia/${DateTime.now().millisecondsSinceEpoch}_${image.name}',
        );
        if (url != null) {
          multimediaUrls.add(url);
        }
      }

      // Crear el contenido con las URLs obtenidas
      Map<String, String> networks = {};
      for (var network in selectedNetworks) {
        networks[network] = networkControllers[network]!.text;
      }

      final content = Content(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        logoUrl: logoUrl ?? '',
        multimedia: multimediaUrls,
        createdOn: Timestamp.now().toString(),
        lastModifiedOn: Timestamp.now().toString(),
        networks: networks,
      );

      // Guardar el contenido en Firestore
      await fireStoreContentService.addContent(content);

      // Limpiar los campos después de enviar el formulario
      titleController.clear();
      descriptionController.clear();
      for (var controller in networkControllers.values) {
        controller.clear();
      }
      setState(() {
        imageLogo = null;
        imagesMultimedia.clear();
        selectedNetworks.clear();
        _isLoading = false;
      });

      // Mostrar mensaje de satisfacción
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Contenido creado con éxito'),
        ),
      );
    } catch (e) {
      // Manejo de errores (puedes mostrar un diálogo o snackbar con el error)
      print('Error creating content: $e');
      setState(() {
        _isLoading = false;
      });

      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al crear el contenido: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear contenido'),
      ),
      body: _isLoading
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Agregar red social',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: ['Facebook', 'Instagram', 'YouTube', 'WhatsApp']
                          .map((network) => DropdownMenuItem(
                                value: network,
                                child: Text(network),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null &&
                            !selectedNetworks.contains(value)) {
                          setState(() {
                            selectedNetworks.add(value);
                            networkControllers[value] = TextEditingController();
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: selectedNetworks.map((network) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            controller: networkControllers[network],
                            decoration: InputDecoration(
                              labelText: '$network URL',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    selectedNetworks.remove(network);
                                    networkControllers.remove(network);
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    imageLogo != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: Image.network(
                                imageLogo!.path,
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              height: 150,
                              width: 150,
                              color: Colors.grey[300],
                              child: Icon(
                                Icons.image,
                                size: 50,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        final image = await getImage();
                        setState(() {
                          imageLogo = image;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Subir imagen del logo',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: selectImages,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Subir imágenes multimedia',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: imagesMultimedia.map((file) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            file.path,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: createContent,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Crear Contenido',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
