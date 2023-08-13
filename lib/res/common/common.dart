import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Common {
  static Future<File?> pickFileFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile == null) {
      // User canceled the picker
      return null;
    }

    return File(pickedFile.path);
  }

  static Future<String> convertFileToWebpUrl(File file) async {
    // Get the bytes of the file
    Uint8List bytes = await file.readAsBytes();

    // Compress the image as webp format
    List<int> compressedBytes = await FlutterImageCompress.compressWithList(
      bytes,
      format: CompressFormat.webp,
      quality: 80,
    );

    // Create a new File with the compressed bytes
    File compressedFile =
        await File('${file.path}.webp').writeAsBytes(compressedBytes);

    // Get the URL of the compressed file
    String webpUrl = compressedFile.uri.toString();

    return webpUrl;
  }

  /*
    * Multiple image picker 
  */
  static Future<List<File>> pickImages() async {
    List<File> images = [];

    // Use the ImagePicker package to get multiple images from the gallery
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    // Convert PickedFile objects to File objects and add to the list
    for (var pickedFile in pickedFiles) {
      File image = File(pickedFile.path);
      images.add(image);
    }

    return images;
  }

  /*
    * Convert URl image to File object 
  */

  static Future<File> urlToFile(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    final fileName = imageUrl.split('/').last;
    final directory = await getTemporaryDirectory();
    final imageFile = File('${directory.path}/$fileName');
    await imageFile.writeAsBytes(bytes);
    return imageFile;
  }

  /*
    * Convert WebP image to PNG 
  */
  static Future<File> convertWebpToPng(String webpImagePath) async {
    final File webpFile = File(webpImagePath);
    final webpData = await webpFile.readAsBytes();

    final List<int> pngData = await FlutterImageCompress.compressWithList(
      webpData,
      format: CompressFormat.png,
    );

    final File pngFile = File('${webpFile.path}.png');
    return await pngFile.writeAsBytes(pngData);
  }

  /*
    * Toast message 
  */
  static void showToast(
    String message, {
    Color? backgroundColor,
    Color? textColor,
    double? fontSize,
  }) {
    Fluttertoast.showToast(
      msg: message.replaceAll("Exception:", ""),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor ?? Colors.black,
      textColor: Colors.white,
      fontSize: fontSize ?? 16.0,
    );
  }
}
