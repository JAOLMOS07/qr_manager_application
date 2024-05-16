import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_manager_application/domain/controllers/link_controller.dart';

class CreateQrCodePage extends StatelessWidget {
  final List<String> options = ['Option 1', 'Option 2', 'Option 3'];
  final LinkController linkController = Get.find<
      LinkController>(); // Obtener instancia del controlador de enlaces
  String selectedOption = 'Option 1';

  CreateQrCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create QR Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: QrImageView(
                data: "qrmanager.com",
                size: 280,
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: const Size(100, 100),
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedOption,
              onChanged: (String? value) {
                if (value != null) {
                  selectedOption = value;
                }
              },
              items: options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Llamar al método createLink del controlador de enlaces
                linkController.createLink(options.indexOf(selectedOption));
                Get.back();
              },
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
