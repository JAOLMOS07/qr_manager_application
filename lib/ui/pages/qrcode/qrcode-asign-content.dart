import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_manager_application/domain/controllers/content_controller.dart';
import 'package:qr_manager_application/domain/controllers/link_controller.dart';
import 'package:qr_manager_application/domain/models/content.dart';

class ViewQrCodePage extends StatelessWidget {
  final LinkController linkController = Get.find<LinkController>();
  final ContentController contentController = Get.find<ContentController>();

  @override
  Widget build(BuildContext context) {
    if (linkController.selectedLink != null) {
      String qrData = "qradmin.com/${linkController.selectedLink!.id}";

      Content? selectedContent = contentController.contents.firstWhereOrNull(
        (content) => content.id == linkController.selectedLink!.contentId,
      );

      if (selectedContent == null && contentController.contents.isNotEmpty) {
        selectedContent = contentController.contents.first;
      }

      return Scaffold(
        appBar: AppBar(
          title: Text(
              'Código QR: ${linkController.selectedLink!.contentTitle ?? "Vacío"}'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: QrImageView(
                data: qrData,
                size: 280,
                embeddedImageStyle: const QrEmbeddedImageStyle(
                  size: Size(100, 100),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Código QR',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              qrData,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: qrData));
                Get.snackbar(
                  'Enlace copiado',
                  'El enlace se copió al portapapeles',
                );
              },
              child: Text('Copiar Enlace'),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Text(
                  'Contenido: ${selectedContent?.title ?? "No se encontró contenido"}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Seleccionar Contenido',
                      content: DropdownButton<Content>(
                        value: selectedContent,
                        onChanged: (Content? newContent) {
                          if (newContent != null) {
                            linkController.assignContent(
                                linkController.selectedLink!, newContent);
                          }
                          Get.back();
                          Get.back();
                        },
                        items: contentController.contents
                            .map<DropdownMenuItem<Content>>(
                              (Content content) => DropdownMenuItem<Content>(
                                value: content,
                                child: Text(content.title),
                              ),
                            )
                            .toList(),
                      ),
                    );
                    Get.find<LinkController>()
                        .update(); // Actualiza la interfaz de usuario
                  },
                  child: Text('Cambiar Contenido'),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      Get.back();
      return SizedBox.shrink();
    }
  }
}
