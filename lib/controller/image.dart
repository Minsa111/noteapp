import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  final List<String> uploadedImages = <String>[].obs; // Initialize as an observable list

  Future<void> pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imagePath = pickedFile.path;
      addImage(imagePath);
    }
  }

  Future<void> takePicture() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final imagePath = pickedFile.path;
      addImage(imagePath);
    }
  }

  void addImage(String imagePath) {
    uploadedImages.add(imagePath);
  }  
  void removeImage(String imagePath) {
    uploadedImages.remove(imagePath);
  }
}

