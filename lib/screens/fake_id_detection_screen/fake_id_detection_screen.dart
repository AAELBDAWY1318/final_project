import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class FakeIdDetection extends StatefulWidget {
  const FakeIdDetection({super.key});

  @override
  State<FakeIdDetection> createState() => _FakeIdDetectionState();
}

class _FakeIdDetectionState extends State<FakeIdDetection> {
  File? _imageFile;
  String _prediction = '';

  // Function to select an image from gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // Function to upload image and get prediction from Flask backend
  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    // API endpoint URL
    final url = 'http://127.0.0.1:5000/predict';

    try {
      // Create Dio instance
      Dio dio = Dio();

      // Create FormData
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(_imageFile!.path, filename: 'image.jpg'),
      });

      // Send POST request
      var response = await dio.post(
        url,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      // Handle response
      if (response.statusCode == 200) {
        // Decode and display the prediction from Flask server
        var jsonResponse = json.decode(response.data); // Decode JSON response
        var prediction = jsonResponse['prediction'];
        setState(() {
          _prediction = 'Prediction: $prediction';
        });
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Classification App'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _imageFile == null
                  ? Text('No image selected.')
                  : Image.file(_imageFile!),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                child: Text('Select Image'),
              ),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.camera),
                child: Text('Take Photo'),
              ),
              ElevatedButton(
                onPressed: _uploadImage,
                child: Text('Classify Image'),
              ),
              Text(_prediction),
            ],
          ),
        ),
      ),
    );
  }
}
