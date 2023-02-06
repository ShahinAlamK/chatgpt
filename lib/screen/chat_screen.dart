import 'package:chatgpt/model/chat_model.dart';
import 'package:chatgpt/screen/chat_message.dart';
import 'package:chatgpt/service/chatgpt_service.dart';
import 'package:chatgpt/style/colors.dart';
import 'package:chatgpt/style/size_config.dart';
import 'package:chatgpt/widget/typing_animation.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

    TextEditingController _typeMessage=TextEditingController();
    GlobalKey<FormState>key=GlobalKey<FormState>();

    List<ChatModel> messageList=[];
    bool isLoading=false;

    ScrollController scrollController = ScrollController();
    scrollMethod(){
      scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut);
    }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor:Colors.white,
      appBar:AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        title: Text("Chat-Gpt".toUpperCase()),
      ),
      body: Column(
        children: [

         Flexible(child:ListView.builder(
           controller: scrollController,
          physics:BouncingScrollPhysics(),
          itemCount:messageList.length,
          itemBuilder:(_,index){
            if(messageList.length==0){
              return Center(child: Text("Welcome To Chat-Gpt"));
            }
            return ChatMessage(
              massage:messageList[index].message.toString(),
              chatType:messageList[index].chatType!,
            );
          }
         )),
         if(isLoading)TypingLoading(),

          Container(
            height: 60,
            width:SizeConfig.width,
            decoration: BoxDecoration(
              color:Colors.white,
              boxShadow:[
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 7,
                  spreadRadius: -5
                ),
              ]
            ),
            child:Row(
              children: [

                Expanded(child:Form(
                  key:key,
                  child: TextField(
                    controller: _typeMessage,
                    decoration:InputDecoration(
                      hintText: "Typing message",
                      hintStyle:TextStyle(fontSize:SizeConfig.blockHorizontal!*5),
                      border: InputBorder.none,
                      contentPadding:EdgeInsets.symmetric(horizontal: 20)
                    ),
                  ),
                )),

                IconButton(
                  onPressed:(){
                    isLoading=true;
                       messageList.add(ChatModel(
                           message:_typeMessage.text,
                           chatType:ChatType.user
                       ));
                       setState(() {});
                       ChatGptService.ChatResponse(_typeMessage.text).then((value){
                        setState(() {
                          messageList.add(ChatModel(message:value,chatType:ChatType.gpt));
                          isLoading=false;
                        });
                        Future.delayed(Duration(milliseconds: 50)).then((value){
                          return scrollMethod();
                        });
                       });
                        _typeMessage.clear();
                        Future.delayed(Duration(milliseconds: 50)).then((value){
                          return scrollMethod();
                        });
                  },
                 icon:Icon(Icons.send)
                 ),
                SizedBox(width:20)
              ],
            ),
          ),
        ],
      ),
    );
  }
}