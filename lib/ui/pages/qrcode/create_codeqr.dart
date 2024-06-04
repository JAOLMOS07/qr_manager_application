import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_manager_application/domain/models/link.dart';
import 'package:qr_manager_application/services/link_service.dart';

class CreateQrCodePage extends StatefulWidget {
  const CreateQrCodePage({Key? key}) : super(key: key);

  @override
  _CreateQrCodePageState createState() => _CreateQrCodePageState();
}

class _CreateQrCodePageState extends State<CreateQrCodePage> {
  final List<String> options = ['Anual', 'Mensual', 'Vitalicio'];
  final FireStoreLinkService _fireStoreLinkService = FireStoreLinkService();

  String selectedOption = 'Anual';
  Future<void> _createLink() async {
    final link = Link(
      contentId: null,
      contentTitle: null,
      lastRenewalDate: DateTime.now().toString(),
      subscriptionType: options.indexOf(selectedOption),
      active: true,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdOn: DateTime.now(),
      lastModifiedOn: DateTime.now(),
    );

    await _fireStoreLinkService.addLink(link);
    Get.back();
  }

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
                  setState(() {
                    selectedOption = value;
                  });
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
              onPressed: _createLink,
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
