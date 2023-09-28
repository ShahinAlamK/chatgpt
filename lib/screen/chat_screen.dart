import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgpt/model/chat_model.dart';
import 'package:chatgpt/screen/chat_message.dart';
import 'package:chatgpt/service/chatgpt_service.dart';
import 'package:chatgpt/style/colors.dart';
import 'package:chatgpt/style/size_config.dart';
import 'package:chatgpt/widget/typing_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  TextEditingController _typeMessage = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  List<ChatModel> messageList = [];
  bool isLoading = false;
  bool isActive = false;

  ScrollController scrollController = ScrollController();
  
  scrollMethod() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut
      );
  }

  @override
  void initState() {
    _typeMessage.addListener(() {
      final isButton = _typeMessage.text.isEmpty;
      setState(() {
        isActive = isButton;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        title: Text("Chat-Gpt".toUpperCase(),style: GoogleFonts.poppins(
          fontSize: getWidth(20),
          fontWeight: FontWeight.w700
        ),),
      ),

      body: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child:messageList.length==0?
            Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset("assets/image/chatgpt.png",
                  width:getWidth(80)),
                ),

                SizedBox(height: 10,),

                AnimatedTextKit(
                    animatedTexts:[
                  TyperAnimatedText("Welcome To Chat-GPT",
                    speed: Duration(milliseconds: 100),
                    textStyle:TextStyle(
                      fontSize:getWidth(18)
                  ),)
                ]),
              ],
            )):
            ListView.builder(
                controller: scrollController,
                physics: BouncingScrollPhysics(),
                itemCount: messageList.length,
                itemBuilder: (_, index) {
                  return ChatMessage(
                    massage: messageList[index].message.toString(),
                    chatType: messageList[index].chatType!,
                  );
                }),
          ),

          if (isLoading) TypingLoading(),

          Container(
            height: 60,
            width: SizeConfig.width,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 7, spreadRadius: -5),
            ]),

            child: Row(
              children: [
                SizedBox(width: 15),
                CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage("assets/image/placeholder.png"),
                ),
                Expanded(
                  child: Form(
                  key: key,
                  child: TextFormField(
                    controller: _typeMessage,
                    decoration: InputDecoration(
                        hintText: "Typing message",
                        hintStyle: TextStyle(
                            fontSize: SizeConfig.blockHorizontal! * 5),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20)),
                  ),
                )),
                IconButton(
                    onPressed: isActive
                        ? null
                        : () {
                            isLoading = true;
                            messageList.add(ChatModel(
                                message: _typeMessage.text,
                                chatType: ChatType.user));
                            setState(() {});

                            ChatGptService.ChatResponse(_typeMessage.text)
                                .then((value) {
                              setState(() {
                                messageList.add(ChatModel(
                                    message: value, chatType: ChatType.gpt));
                                isLoading = false;
                              });
                              Future.delayed(Duration(milliseconds: 50))
                                  .then((value) {
                                return scrollMethod();
                              });
                            });
                            _typeMessage.clear();

                            Future.delayed(Duration(milliseconds: 50))
                                .then((value) {
                              return scrollMethod();
                            });
                          },
                    icon: Icon(Icons.send)),
                SizedBox(width: 20)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
