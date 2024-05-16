import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_manager_application/domain/controllers/content_controller.dart';
import 'package:qr_manager_application/domain/controllers/link_controller.dart';
import 'package:qr_manager_application/ui/app.dart';

void main() {
  runApp(const App());
  Get.put(ContentController());
  Get.put(LinkController());
}
