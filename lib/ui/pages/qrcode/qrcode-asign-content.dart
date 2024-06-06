import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:awesome_select/awesome_select.dart';
import 'package:qr_manager_application/services/content_service.dart';
import 'package:qr_manager_application/domain/models/content.dart';
import 'package:qr_manager_application/domain/models/link.dart';
import 'package:qr_manager_application/services/link_service.dart';

class ViewQrCodePage extends StatefulWidget {
  @override
  _ViewQrCodePageState createState() => _ViewQrCodePageState();
}

class _ViewQrCodePageState extends State<ViewQrCodePage> {
  Link linkSelected = Get.arguments;
  String selectedValue = 'flu';
  List<S2Choice<String>> options = [];
  final FireStoreContentService contentService = FireStoreContentService();
  late List<Content> contents;

  final FireStoreLinkService linkService = FireStoreLinkService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeSelectedValue();
    _fetchContents();
  }

  void _initializeSelectedValue() {
    if (linkSelected.contentId != null) {
      selectedValue = linkSelected.contentId!;
    }
  }

  Future<void> _fetchContents() async {
    contents = await contentService.getContents();
    setState(() {
      options = contents.map((content) {
        return S2Choice<String>(value: content.id, title: content.title);
      }).toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String qrData =
        "https://qrmanagerdisplay.netlify.app/qr/${linkSelected.id}";

    return Scaffold(
      appBar: AppBar(
        title: Text('Código QR: ${linkSelected.contentTitle ?? "Vacío"}'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(linkSelected.contentLogoUrl ?? ""),
                    fit: BoxFit.cover,
                  ),
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
                child: Container(
                  padding: const EdgeInsets.all(10.0),
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
                    data: qrData,
                    size: 280,
                    embeddedImageStyle: const QrEmbeddedImageStyle(
                      size: Size(100, 100),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Código QR',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  qrData,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
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
              _isLoading
                  ? CircularProgressIndicator()
                  : SmartSelect<String>.single(
                      title: 'Contenido',
                      placeholder: "Asigna un contenido",
                      selectedValue: selectedValue,
                      choiceItems: options,
                      onChange: (state) => {
                        setState(() => selectedValue = state.value),
                        linkSelected.contentId = state.value,
                        linkSelected.contentTitle = state.title,
                        linkSelected.contentLogoUrl = contents
                            .firstWhere((content) => content.id == state.value)
                            .logoUrl,
                        linkService.updateLink(linkSelected)
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
