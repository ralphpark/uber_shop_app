import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber_shop_app/views/screens/widget/product_model.dart';

class WomenProductWidget extends StatelessWidget {
  const WomenProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream =
    FirebaseFirestore.instance.collection('products').where('category', isEqualTo: 'women').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        if(snapshot.data!.docs.isEmpty){
          return Center(
            child: Text(
              'No Men products',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
          );
        }

        return Container(
          height: 100,
          child: PageView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
                return ProductModels(productData: productData);
              }),
        );
      },
    );
  }
}

