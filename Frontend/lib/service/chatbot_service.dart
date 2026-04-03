import 'package:dio/dio.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/service/person_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatbotService {
  final dio = Dio(BaseOptions(baseUrl: LEGAL_HELP_BACKEND_URL));
  PersonData personData = PersonData();

  void saveChatId(String? chatId)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("chatId", chatId ?? "");
  }

  Future<String> getChatId()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String chatId = pref.getString("chatId")!;
    print(chatId);
    return chatId;
  }

  Future<Map?> generateChat(data) async {
    Map? person = await personData.getPersonData();
    String userId = person!["_id"];
    final res = await dio.post(
      "/chat/generate?userId=$userId",
      data: data,
    );
    if (res.statusCode == 200) {
      saveChatId(res.data["_id"]);
      return res.data;
    }
    return null;
  }

  void deleteChat(String chatId) async {
    final res = await dio.delete("/chat/delete?chatId=$chatId");
    if(res.statusCode == 200){
      print(res.data);
      // return res.data;
    }
    print(res.data);
    // return null;
  }

  Future<List> getChatbotChatList() async {
    Map? person = await personData.getPersonData();
    String userId = person!["_id"];
    print(userId);
    final res = await dio.get("/chat/get_chat_list?userId=$userId");
    if (res.statusCode == 200) {
      return res.data;
    }
    return [];
  }
}
