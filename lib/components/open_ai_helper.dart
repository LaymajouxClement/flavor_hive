import 'dart:convert';

import 'package:http/http.dart' as http;

String apiKey = "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";

var url = Uri.parse('https://api.openai.com/v1/completions');

toUtf8(http.Response res){
  List<int> bytes = res.body.codeUnits;
  return utf8.decode(bytes);
}