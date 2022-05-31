import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:uno/uno.dart';

const url = 'https://jsonplaceholder.typicode.com/todos';
void main() async {
  final uno = Uno();
  final response = await uno(url: url, method: 'get');
  print(response.data[0]);
}

void dioPackage() async {
  final response = await Dio().get(url);
  print(response.data);
}

void httpPackage() async {
  final response = await http.get(Uri.parse(url));
  final body = response.body;
  print(body);
}

void httpClient() async {
  final client = HttpClient();

  // request
  final request = await client.openUrl('get', Uri.parse(url));
  request.headers.set('content-type', 'application/json');

  // response
  final response = await request.close();
  final list = <String>[];

  await for (var data in response) {
    final string = utf8.decode(data);
    list.add(string);
  }
  final body = list.join();
  print(list);
}
