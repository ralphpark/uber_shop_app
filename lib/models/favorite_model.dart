class FavoriteModel {
  final String productName;
  final String productID;
  final List imageUrl;

  int quantity;
  int productQuantity;

  final double price;
  final String vendorID;
  final String productSize;

  FavoriteModel({
    required this.productName,
    required this.productID,
    required this.imageUrl,
    required this.quantity,
    required this.productQuantity,
    required this.price,
    required this.vendorID,
    required this.productSize,
  });
}
