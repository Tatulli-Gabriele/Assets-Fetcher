import 'dart:html';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => RunApp();

// Example coinapi.io API Key
const String apiKey = '0XX00000-000X-000X-X00X-0000X0X0X0X0';
const String baseUrlString = 'https://rest.coinapi.io/v1/assets';
Uri baseUrl = Uri.parse(baseUrlString);
Element? todoList;

Iterable<String> calculateAsset(String response) sync* {
  var asset = List<dynamic>.from(jsonDecode(response));
  for(int i = 0; i<asset.length; i++)
  {
    if(asset[i]['price_usd'] != null)
    {
      yield 'Name: ${asset[i]['name']} | Price: ${asset[i]['price_usd']}';
    }
  }
}

void addTodoItem(String item) {
  var listElement = LIElement();
  listElement.text = item;
  todoList?.children.add(listElement);
}

void RunApp() async {
  var response = await http.get(
    baseUrl, headers: {
    'X-CoinAPI-Key': '$apiKey',
  });
  
  todoList = querySelector('#todolist');
  calculateAsset(response.body)
    .forEach(addTodoItem);
}