import 'package:dio/dio.dart';
import 'package:frontend/constants/constants.dart';

class AuthService{
  final dio = Dio(BaseOptions(
    baseUrl: LEGAL_HELP_BACKEND_URL,
  ));

  Future<Map?> userRegister(data)async{
    final res = await dio.post("/user/register",data: data);
    if(res.statusCode == 200){
      print(res.data);
      return res.data;
    }
    return null;
  }

  Future<Map?> userLogin(data)async{
    final res = await dio.post("/user/login",data: data);
    print(res.data);
    if(res.statusCode == 200){
      print(res.data);
      return res.data;
    }
    return res.data;
  }

  Future<Map?> lawyerRegister(data)async{
    final res = await dio.post("/lawyer/register",data: data);
    print(res.data);
    if(res.statusCode == 200){
      print(res.data);
      return res.data;
    }
    return res.data;
  }

  Future<Map?> lawyerLogin(data)async{
    final res = await dio.post("/lawyer/login",data: data);
    print(res.data);
    if(res.statusCode == 200){
      print(res.data);
      return res.data;
    }
    return res.data;
  }
}