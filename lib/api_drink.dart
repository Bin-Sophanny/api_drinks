import 'dart:convert';
import 'package:drinks/model_drink.dart';
import 'package:http/http.dart' as http;

Future<List<Drink>> fetchDrink() async {
  final response = await http.get(Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/search.php?s=coffee'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body); // Decode the response

    // Ensure that the 'drinks' key is present and is a list
    if (data['drinks'] != null && data['drinks'] is List) {
      List<dynamic> drinksList = data['drinks'];  // Extract the drinks list

      // Map each drink object to a Drink instance
      return drinksList.map((drinkJson) => Drink.fromJson(drinkJson)).toList();
    } else {
      throw Exception('No drinks found');
    }
  } else {
    throw Exception('Failed to load drinks');
  }
}
