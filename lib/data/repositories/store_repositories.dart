import 'package:bloc_bottom_bar/data/models/product.dart';
import 'package:dio/dio.dart';

class StoreRepositories {
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: 'https://fakestoreapi.com/products',
    ),
  );

  Future<List<Product>> getProducts() async {
    final response = await _client.get('');
    return (response.data as List)
        .map((e) => Product(
              id: e['id'],
              title: e['title'],
              image: e['image'],
            ))
        .toList();
  }
}
