import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class ImagePickerController extends GetxController {
  final _picker = ImagePicker();
  RxList<String> galleryImages = <String>[].obs;
  String imageUrl = '';

  Future<void> pickImageFromGallery() async {
    String uniqueImageId = const Uuid().v4();
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        galleryImages.add(pickedFile.path);

        Reference referenceroot = FirebaseStorage.instance.ref();
        Reference referenceDirImage = referenceroot.child('images');
        Reference referenceimageToUpload =
            referenceDirImage.child(uniqueImageId);
        try {
          print('start downloding  : ');
          await referenceimageToUpload.putFile(File(pickedFile.path));
          imageUrl = await referenceimageToUpload.getDownloadURL();
          print('Sucesfully downloded done : ');
        } catch (e) {
          print('Error downloading the image : $e');
        }
      }
    } catch (e) {
      print('Error picking image from gallery: $e');
    }
  }

  Future<void> pickImageFromCamera() async {
    String uniqueImageId = Uuid().v4();
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        galleryImages.add(pickedFile.path);
        print("hello this is gallery images : ${galleryImages}");
        Reference referenceroot = FirebaseStorage.instance.ref();
        Reference referenceDirImage = referenceroot.child('images');
        Reference referenceimageToUpload =
            referenceDirImage.child(uniqueImageId);
        try {
          print('start downloding  : ');
          await referenceimageToUpload.putFile(File(pickedFile.path));
          imageUrl = await referenceimageToUpload.getDownloadURL();
          print('Sucesfully downloded done : ');
        } catch (e) {
          print('Error downloading the image : $e');
        }
      }
    } catch (e) {
      print('Error picking image from camera: $e');
    }
  }
}
