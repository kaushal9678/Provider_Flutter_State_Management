import 'package:flutter/material.dart';
import './product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_expections.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    /*   Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ), */
  ];
  var showFavorites = false;
  List<Product> get items {
    /*   if (showFavorites) {
      return _items.where((productItem) => productItem.isFavorite).toList();
    } */
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((productItem) => productItem.isFavorite).toList();
  }

  /* void showFavoritesOnly() {
    showFavorites = true;
    notifyListeners();
  }

  void showAll() {
    showFavorites = false;
    notifyListeners();
  }
 */
  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    const url = 'https://flutter-update-c03e1.firebaseio.com/products.json';
    try {
      final result = await http.get(url);
      final extractedData = json.decode(result.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            price: prodData['price'],
            isFavorite: prodData['isFavorite']));
      });
      _items = loadedProducts;
      notifyListeners();
      print(result);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    print(product);
    print(product.description);
    print(product.imageUrl);
    // _items.add(value);
    const url = 'https://flutter-update-c03e1.firebaseio.com/products.json';
/**Short way  and most preferrable*/
    try {
      final result = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite
          }));
      var response = json.decode(result.body);
      final newProduct = Product(
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
          id: response['name']);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }

/**2nd way The below commented code is implemented using Future like Promises in javascript */
    /*   return http
        .post(url,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'price': product.price,
              'imageUrl': product.imageUrl,
              'isFavorite': product.isFavorite
            }))
        .then((res) {
      // print(res);
      var response = json.decode(res.body);
      //  print(response);
      final newProduct = Product(
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
          id: response['name']);
      _items.add(newProduct);
      notifyListeners();
    }).catchError((error) {
      throw error;
    }); */
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final proIndex = _items.indexWhere((prod) => prod.id == id);
    if (proIndex >= 0) {
      final url =
          'https://flutter-update-c03e1.firebaseio.com/products/$id.json';
      try {
        http.patch(url,
            body: json.encode({
              'title': newProduct.title,
              'description': newProduct.description,
              'imageUrl': newProduct.imageUrl,
              'price': newProduct.price
            }));
      } catch (error) {
        throw error;
      }
      _items[proIndex] = newProduct;
      notifyListeners();
    } else {}
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://flutter-update-c03e1.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);

    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
