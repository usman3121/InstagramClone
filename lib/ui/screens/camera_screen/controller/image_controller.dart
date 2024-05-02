import 'dart:async';
import 'dart:io';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram/ui/utils/message%20toaster/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

class MediaController extends GetxController {
  final _picker = ImagePicker();
  RxList<String> galleryImages = <String>[].obs;
  RxList<String> galleryVideos = <String>[].obs;
  String imageUrl = '';
  String videoUrl = '';
  RxDouble uploadProgress = 0.0.obs;
  File? videoFile;
  String? pickedVideoPath;


  Future<void> pickVideoFromGallery() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedVideoPath = pickedFile.path;
      imageUrl = '';
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('pickedVideoPath', pickedVideoPath!);
      videoFile = File(pickedVideoPath!);
      print("Picked video path: $pickedVideoPath");
    } else {
      print('No video selected.');
    }
  }

  Future<void> uploadVideo(String path) async {
    if (path == null) {
      print('No video selected.');
      return;
    }

    String uniqueVideoId = const Uuid().v4();
    final info = await VideoCompress.compressVideo(
      path!,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: false,
      includeAudio: true,
    );
    print("Picked video pathv  on upload method: $path");
    final compressedVideoPath = info!.path;
    Reference referenceDirVideo = FirebaseStorage.instance.ref().child('videos');
    Reference referenceVideoToUpload = referenceDirVideo.child(uniqueVideoId);
    UploadTask uploadTask = referenceVideoToUpload.putFile(File(compressedVideoPath ?? ''));
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      double progress = snapshot.bytesTransferred / snapshot.totalBytes;
      print('Upload progress: $progress');
    });

    try {
      await uploadTask;
      videoUrl = await referenceVideoToUpload.getDownloadURL();

      print('video urls is : $videoUrl');

      Utils().toastMessage("Video uploaded successfully");
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }


  String calculateRemainingTime(double progress) {
    int remainingTime = ((1 - progress) * 100).round();
    String formattedTime = remainingTime.toString() + ' seconds';
    return formattedTime;
  }

  Future<File> compressFile(File imageFile,
      {int quality = 100, int percentage = 100}) async {
    var path = await FlutterNativeImage.compressImage(imageFile.absolute.path,
        quality: 100, percentage: 10);
    return path!;
  }




  Future<void> pickImageFromGallery() async {
    String uniqueImageId = const Uuid().v4();
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        galleryImages.add(pickedFile.path);
        videoUrl = '';
        File image = File(pickedFile.path);
        /* final size = image.lengthSync() / 1024;
        print('the size of the image before uploading is : $size kb');
        File compressedImage = await compressFile(image);

        final compressedSize = compressedImage.lengthSync() / 1024;
        print('the size of the image after uploading is : $compressedSize kb');*/

        Reference referenceroot = FirebaseStorage.instance.ref();
        Reference referenceDirImage = referenceroot.child('images');
        Reference referenceimageToUpload =
            referenceDirImage.child(uniqueImageId);
        try {
          /* final compressedSize = compressedImage.lengthSync() / 1024;
          print(
              'the size of the image after uploading is : $compressedSize kb');*/

          await referenceimageToUpload.putFile(File(pickedFile.path));
          imageUrl = await referenceimageToUpload.getDownloadURL();
          Utils().toastMessage("Image downloaded successfully");
        } catch (e) {
          print('Error uploading image: $e');
          Utils().toastMessage(e.toString());
        }
      }
    } catch (e) {
      print('Error  $e');
      Utils().toastMessage(e.toString());
    }
  }

  Future<void> pickImageFromCamera() async {
    String uniqueImageId = const Uuid().v4();
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      videoUrl = '';
      if (pickedFile != null) {
        galleryImages.add(pickedFile.path);
        Reference referenceroot = FirebaseStorage.instance.ref();
        Reference referenceDirImage = referenceroot.child('images');
        Reference referenceimageToUpload =
            referenceDirImage.child(uniqueImageId);
        try {
          await referenceimageToUpload.putFile(File(pickedFile.path));
          imageUrl = await referenceimageToUpload.getDownloadURL();
          Utils().toastMessage("image downloaded succefull");
        } catch (e) {
          print('Error uploading image: $e');
          Utils().toastMessage(e.toString());
        }
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }
}
