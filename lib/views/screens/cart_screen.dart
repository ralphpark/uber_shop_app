import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uber_shop_app/provider/cart_provider.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: cartData.length,
        itemBuilder: (context, index) {
          final cartItem = cartData.values.toList()[index];
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(cartItem.productName, style: TextStyle(fontSize: 20, color: Colors.blueGrey),),
                  Text(cartItem.productSize),
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
