import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavNewValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final url =
          'https://flutter-update-c03e1.firebaseio.com/products/$id.json';
      final response =
          await http.patch(url, body: json.encode({'isFavorite': isFavorite}));
      if (response.statusCode >= 400) {
        _setFavNewValue(oldStatus);
      }
    } catch (e) {
      _setFavNewValue(oldStatus);
    }
  }
}
