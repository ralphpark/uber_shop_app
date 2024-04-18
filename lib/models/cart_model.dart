class CartModel{
  final String productName;
  final String productID;
  final List imageUrl;

  //장바구니에 추가된 상품의 수량을 저장하는 변수
  int quantity;
  int productQuantity;
  final double price;
  final String vendorID;
  final String productSize;

  CartModel({
    required this.productName,
    required this.productID,
    required this.imageUrl,
    required this.quantity,
    required this.price,
    required this.vendorID,
    required this.productSize,
    required this.productQuantity,
  });
}