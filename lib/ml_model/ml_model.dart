import'dart:io';
import 'package:dio/dio.dart';
// coded by eng. Abdullah Awad
class MLLogic{
  static late Dio dio;
  String apiUrl = 'https://body1318.pythonanywhere.com/predict';
  void init(){
    dio = Dio();
  }

  Future<Map<String , dynamic>> postImage({required File imageFile})async{
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imageFile.path),
    });
    try{
      Response response = await dio.post(apiUrl , data: formData);
      // check if request done successfully
      if (response.statusCode == 200) {
        return response.data;
        // {"prediction" : 0 } for example
      } else {
        return {'error': 'Request failed with status: ${response.statusCode}'};
      }
    }catch(e){
      return {'error': 'Exception encountered: $e'};
    }
  }
}