import 'package:image_picker/image_picker.dart';

Future<XFile?> getImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<List<XFile?>> getMultiImage() async {
  final ImagePicker picker = ImagePicker();
  final List<XFile?> images = await picker.pickMultiImage();
  return images;
}
