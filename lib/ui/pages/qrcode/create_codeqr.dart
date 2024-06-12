import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:awesome_select/awesome_select.dart';
import 'package:qr_manager_application/domain/models/link.dart';
import 'package:qr_manager_application/services/link_service.dart';

class CreateQrCodePage extends StatefulWidget {
  const CreateQrCodePage({super.key});

  @override
  _CreateQrCodePageState createState() => _CreateQrCodePageState();
}

class _CreateQrCodePageState extends State<CreateQrCodePage> {
  final List<S2Choice<String>> opciones = [
    S2Choice<String>(value: 'Anual', title: 'Anual'),
    S2Choice<String>(value: 'Mensual', title: 'Mensual'),
    S2Choice<String>(value: 'Vitalicio', title: 'Vitalicio')
  ];
  final FireStoreLinkService _fireStoreLinkService = FireStoreLinkService();

  String opcionSeleccionada = 'Anual';

  Map<String, String> precios = {
    'Anual': '\$100',
    'Mensual': '\$10',
    'Vitalicio': '\$500'
  };

  Future<void> _crearEnlace() async {
    final link = Link(
      contentId: null,
      contentTitle: null,
      lastRenewalDate: DateTime.now().toString(),
      subscriptionType:
          opciones.indexWhere((element) => element.value == opcionSeleccionada),
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
        title: const Text('Generar Código QR'),
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
                      offset:
                          const Offset(0, 3), // Cambia la posición de la sombra
                    ),
                  ],
                ),
                child: QrImageView(
                  data: "https://qrmanagerdisplay.netlify.app",
                  size: 280,
                  embeddedImageStyle: const QrEmbeddedImageStyle(
                    size: Size(100, 100),
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
                selectedValue: opcionSeleccionada,
                choiceItems: opciones,
                onChange: (state) =>
                    setState(() => opcionSeleccionada = state.value),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Precio: ${precios[opcionSeleccionada]}',
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
                onPressed: _crearEnlace,
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
