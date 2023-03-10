import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgpt/style/colors.dart';
import 'package:chatgpt/style/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


enum ChatType{user,gpt}

class ChatMessage extends StatelessWidget {
  final String massage;
  final ChatType chatType;
  const ChatMessage({super.key, required this.massage, required this.chatType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
        right: 20,
        left: 10
      ),

      child: Row(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [

          CircleAvatar(
            radius: 15,
            backgroundColor: kPrimary,
            backgroundImage:chatType==ChatType.gpt?
            AssetImage("assets/image/chatgpt.png"):
            AssetImage("assets/image/placeholder.png"),
          ),
    
          SizedBox(width: 10,),
          
          Flexible(
            child: GestureDetector(
              onTap: (){
                Clipboard.setData(ClipboardData(text:massage));
              },
              child: Container(
                margin:EdgeInsets.only(bottom: 10),
                padding:EdgeInsets.all(12),
                decoration:BoxDecoration(
                color:chatType==ChatType.user? kSecondary:kPrimary.withOpacity(.9),
                borderRadius:BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10)
                )
               ),

               child:chatType==ChatType.user?Text(massage,
                 style: TextStyle(
                     color: chatType==ChatType.user? Colors.black:kSecondary,
                     fontWeight:FontWeight.w400,
                     fontSize: SizeConfig.blockHorizontal!*4.5),)

                   :AnimatedTextKit(
                   isRepeatingAnimation: false,
                   totalRepeatCount:1,
                   animatedTexts:[
                     TyperAnimatedText(massage.trim(),textStyle:TextStyle(
                     color:kSecondary,
                     fontWeight:FontWeight.w400,
                     fontSize: SizeConfig.blockHorizontal!*4.5)),
               ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}