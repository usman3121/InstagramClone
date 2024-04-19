import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram/ui/components/utils.dart';
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
          await referenceimageToUpload.putFile(File(pickedFile.path));
          imageUrl = await referenceimageToUpload.getDownloadURL();
        } catch (e) {
          Utils().toastMessage(e.toString());
        }
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }

  Future<void> pickImageFromCamera() async {
    String uniqueImageId = const Uuid().v4();
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        galleryImages.add(pickedFile.path);
        Reference referenceroot = FirebaseStorage.instance.ref();
        Reference referenceDirImage = referenceroot.child('images');
        Reference referenceimageToUpload =
            referenceDirImage.child(uniqueImageId);
        try {
          await referenceimageToUpload.putFile(File(pickedFile.path));
          imageUrl = await referenceimageToUpload.getDownloadURL();
        } catch (e) {
          Utils().toastMessage(e.toString());
        }
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }
}
