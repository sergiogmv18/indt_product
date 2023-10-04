import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

class Request{


/*
  * https get
  * @author SGV
  * @version 1.0 - 20231004 - initial release
  * @param <String> url 
  * @param <int> maxLimitInSeconds - maximum waiting time for a request (standard is 30 seconds)
  * @return  <Map<String, dynamic>>
  */
   Future httpGet({required String url, int maxLimitInSeconds = 30}) async {
    Map<String, dynamic>  result = {
      'success': false,
      'error': 303,
    };
    try {
      var response =  await http.get(Uri.parse(url)).timeout(Duration(seconds: maxLimitInSeconds));
      if(response.statusCode == 200){
        result['payload'] = response.body;
        result['success'] = true;
        result.remove('error');
      }
    } on SocketException {
      result = {
        'success': false,
        'error': 104,
      };
  }on TimeoutException{
    result = {
      'success': false,
      'error': 408,
    };
  }

  return result;

  }
}