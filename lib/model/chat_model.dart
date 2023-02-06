import 'package:chatgpt/screen/chat_message.dart';

class ChatModel{
  String ? message;
  ChatType ? chatType;

  ChatModel({required this.message,required this.chatType}); 
}


List<ChatModel> chatList=[
  ChatModel(
    message: "Hello ChatGpt",
    chatType: ChatType.user
    ),

      ChatModel(
    message: "Hi Shahin Alam Kiron",
    chatType: ChatType.gpt
    ),

      ChatModel(
    message: "How are you chatgpt?",
    chatType: ChatType.user
    ),

      ChatModel(
    message: "I'm fine and you??",
    chatType: ChatType.gpt
    ),
];