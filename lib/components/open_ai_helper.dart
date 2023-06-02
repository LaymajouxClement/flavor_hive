import 'dart:convert';

import 'package:http/http.dart' as http;

String apiKey = "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";
var url = Uri.parse('https://api.openai.com/v1/completions');

toUtf8(http.Response res){
  List<int> bytes = res.body.codeUnits;
  return utf8.decode(bytes);
}