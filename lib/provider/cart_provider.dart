
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uber_shop_app/models/cart_model.dart';

final cartProvider = StateNotifierProvider<CartNotifier, Map<String,CartModel>>((ref) => CartNotifier({}));

class CartNotifier extends StateNotifier<Map<String,CartModel>> {
  CartNotifier(Map<String,CartModel> state) : super(state);

  void addProductToCart(
    String productName,
    String productID,
    List imageUrl,
    int quantity,
    int productQuantity,
    double price,
    String vendorID,
    String productSize,){
    if(state.containsKey(productID)) {
      state = {
        ...state,
        productID: CartModel(
          productName: state[productID]!.productName,
          productID: state[productID]!.productID,
          imageUrl: state[productID]!.imageUrl,
          quantity: state[productID]!.quantity + 1,
          productQuantity: state[productID]!.productQuantity,
          price: state[productID]!.price,
          vendorID: state[productID]!.vendorID,
          productSize: state[productID]!.productSize,
        ),
      };
    }else{
      state = {
        ...state,
        productID: CartModel(
          productName: productName,
          productID: productID,
          imageUrl: imageUrl,
          quantity: quantity,
          productQuantity: productQuantity,
          price: price,
          vendorID: vendorID,
          productSize: productSize,
        ),
      };
    }
  }
  Map<String, CartModel> get getCartItems => state;
}