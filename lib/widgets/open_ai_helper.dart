import 'dart:convert';

import 'package:http/http.dart' as http;

var url = Uri.parse('https://api.openai.com/v1/completions');

toUtf8(http.Response res){
  List<int> bytes = res.body.codeUnits;
  return utf8.decode(bytes);
}