import 'package:dio/dio.dart';
import 'package:frontend/constants/constants.dart';

class LawyerService{
  final dio = Dio(BaseOptions(
    baseUrl: LEGAL_HELP_BACKEND_URL
  ));
  
  Future<List> getLawyersList() async{
    final res = await dio.get("/lawyer/list");
    print(res);
    if(res.statusCode == 200){
      print(res.data);
      return res.data;
    }
    return [];
  }

  Future<Map?> uploadLawyerPic(imagePath) async{
    FormData formData = FormData.fromMap({
      "image" : await MultipartFile.fromFile(imagePath)
    });
    final res = await dio.post("/lawyer/upload",data: formData);
    print(res.statusMessage);
    if(res.statusCode == 200){
      return res.data;
    }
    return null;
  }
}