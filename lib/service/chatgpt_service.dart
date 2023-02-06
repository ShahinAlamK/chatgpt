
import 'dart:convert';

import 'package:http/http.dart' as http;

const BaseUrl="https://api.openai.com/v1/completions";
const ApiKey="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";

class ChatGptService{

  static Future ChatResponse(String msg)async{
  
  try{
    Map<String,String>header={
      "Content-Type":"application/json",
      "Authorization":"Bearer $ApiKey"
    };
    final response = await http.post(Uri.parse(BaseUrl),
    headers:header,
    body:jsonEncode({
      "model": "text-davinci-003",
      "prompt": "$msg",
      "max_tokens": 2000 ,
      "temperature":0,
      "top_p": 1,
      "frequency_penalty":0.0,
      "presence_penalty":0.0,

    })
    );
    if(response.statusCode==200){
      final decoded=jsonDecode(response.body.toString());
      return decoded['choices'][0]['text'];
    }else{
      print("Fetching Failed");
    }
  }catch(error){
    print(error.toString());
  }
  }


  
}