
import 'dart:convert';

import 'package:http/http.dart' as http;

const BaseUrl="https://api.openai.com/v1/completions";
//const ApiKey="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";
//const ApiKey="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";
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
      "temperature":1,
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