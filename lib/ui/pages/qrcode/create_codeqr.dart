import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:awesome_select/awesome_select.dart';
import 'package:qr_manager_application/domain/models/link.dart';
import 'package:qr_manager_application/services/link_service.dart';

class CreateQrCodePage extends StatefulWidget {
  const CreateQrCodePage({Key? key}) : super(key: key);

  @override
  _CreateQrCodePageState createState() => _CreateQrCodePageState();
}

class _CreateQrCodePageState extends State<CreateQrCodePage> {
  final List<S2Choice<String>> options = [
    S2Choice<String>(value: 'Anual', title: 'Anual'),
    S2Choice<String>(value: 'Mensual', title: 'Mensual'),
    S2Choice<String>(value: 'Vitalicio', title: 'Vitalicio')
  ];
  final FireStoreLinkService _fireStoreLinkService = FireStoreLinkService();

  String selectedOption = 'Anual';

  Map<String, String> prices = {
    'Anual': '\$100',
    'Mensual': '\$10',
    'Vitalicio': '\$500'
  };

  Future<void> _createLink() async {
    final link = Link(
      contentId: null,
      contentTitle: null,
      lastRenewalDate: DateTime.now().toString(),
      subscriptionType:
          options.indexWhere((element) => element.value == selectedOption),
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
        title: const Text('Generar QR Code'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: QrImageView(
                  data: "https://qrmanagerdisplay.netlify.app",
                  size: 280,
                  embeddedImageStyle: QrEmbeddedImageStyle(
                    size: const Size(100, 100),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tipo de suscripción',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              SmartSelect<String>.single(
                title: 'Suscripción:',
                placeholder: 'Elige un tipo de suscripción',
                selectedValue: selectedOption,
                choiceItems: options,
                onChange: (state) =>
                    setState(() => selectedOption = state.value),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Precio: ${prices[selectedOption]}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    '\$0',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 14, 51, 213),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createLink,
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
