
import 'dart:convert';

import 'package:http/http.dart' as http;

const BaseUrl="https://api.openai.com/v1/completions";
const ApiKey="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";

class ChatGptService{

  static Future ChatResponse(String msg)async{
    print(msg);
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
      "temperature": 0,
      "top_p": 1,
      "frequency_penalty":0.0,
      "presence_penalty":0.0,
      "stop":['Human:',"AI:"]
    })
    );
    if(response.statusCode==200){
      final decoded=jsonDecode(response.body.toString());
      return decoded['choices'][0]['text'];
    }else{
      print("Fetching Failed");
    }
  }

  
}