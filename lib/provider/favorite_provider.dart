import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uber_shop_app/models/favorite_model.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, Map<String, FavoriteModel>>(
        (ref) => FavoriteNotifier({}));

class FavoriteNotifier extends StateNotifier<Map<String, FavoriteModel>> {
  FavoriteNotifier(Map<String, FavoriteModel> state) : super(state);

  void addProductToFavorite(
    String productName,
    String productID,
    List imageUrl,
    int quantity,
    int productQuantity,
    double price,
    String vendorID,
    String productSize,
  ) {
    state[productID] = FavoriteModel(
      productName: productName,
      productID: productID,
      imageUrl: imageUrl,
      quantity: quantity,
      productQuantity: productQuantity,
      price: price,
      vendorID: vendorID,
      productSize: productSize,
    );
  }
}
