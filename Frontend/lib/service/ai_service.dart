import 'package:dio/dio.dart';
import 'package:frontend/constants/constants.dart';

class AiService {
  final dio = Dio(BaseOptions(baseUrl: LEGAL_HELP_BACKEND_URL));
  Future<String> enhanceIntro(String intro) async {
    final res = await dio.get("/ai/enhance_intro?intro=$intro");
    if(res.statusCode == 200){
      return res.data;
    }
    return "";
  }
}
