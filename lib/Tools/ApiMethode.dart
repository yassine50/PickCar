import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
class ApiMethode {
  static Future<String> RequestMethode ({ required String endPoint ,  required Map<String, dynamic> body,required String  type ,String para= "", String jwt =""} ) async {
var headers = jwt == ''?{
  'Content-Type': 'application/json',
 
} : {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer '+ jwt
};

var request = http.Request(type, Uri.parse(endPoint+"?"+para));
request.body =json.encode(body) ;
request.headers.addAll(headers);
http.StreamedResponse response = await request.send();
if (response.statusCode == 200 ||response.statusCode == 201  )
 {
  print("test");
  
  return await  response.stream.bytesToString() ; 

} 
else {
  print(response.statusCode);
   print(response.reasonPhrase);
  return "Somthing went wrong please try agin" ; 
  // print(response.reasonPhrase);
}
  }


 static Future<Map<String, dynamic>> RequestBodyWithHeader({
  required String endPoint,
  required Map<String, dynamic> body,
  required String type,
  String para = "",
  String jwt = "",
  XFile? file, // Optional file parameter
  String? fileFieldName = "file", // Field name for file parameter
  String? fileName = 'file'
}) async {
  var headers = jwt == ''
      ? {
          'Content-Type': 'application/json',
        }
      : {
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer '+ jwt,
        };

  // Check if file needs to be uploaded
  if (file != null && (type == 'POST' || type == 'PUT')) {
    var request = http.MultipartRequest(type, Uri.parse(endPoint + "?" + para));
    
    // Add body fields
    //request.fields.addAll(body.map((key, value) => MapEntry(key, value.toString())));
    
    // Add the file to the request
    request.files.add(await http.MultipartFile.fromPath(
      fileFieldName ?? 'file',
      file.path,
      filename: fileName,
      contentType: MediaType('image', 'png'),
    ));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
  
      return {
        "body": await response.stream.bytesToString(),
        "header": response.headers,
      };
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      return {};
    }
  } else {
    var request = http.Request(type, Uri.parse(endPoint + "?" + para));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return {
        "body": await response.stream.bytesToString(),
        "header": response.headers,
      };
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      return {};
    }
  }
}
}


