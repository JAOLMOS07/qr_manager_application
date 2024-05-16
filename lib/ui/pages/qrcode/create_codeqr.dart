import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_manager_application/domain/controllers/link_controller.dart';

class CreateQrCodePage extends StatelessWidget {
  final List<String> options = ['Anual', 'Mensual', 'Vitalicio'];
  final LinkController linkController = Get.find<LinkController>();
  String selectedOption = 'Anual';

  CreateQrCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generar QR Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Text(
              'Tipo de suscripción',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
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
            Expanded(
              child: Center(
                child: QrImageView(
                  data: "qrmanager.com",
                  size: 280,
                  embeddedImageStyle: QrEmbeddedImageStyle(
                    size: const Size(100, 100),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
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
