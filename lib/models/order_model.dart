class OrderModel {
  String productName,
      customerName,
      customerEmail,
      customerAddress,
      orderDate,
      orderTime,
      moreInfo;
  int num, totalPrice;
  bool deliveredFlf = false;
  OrderModel(
    this.productName,
    this.customerName,
    this.customerEmail,
    this.customerAddress,
    this.orderDate,
    this.orderTime,
    this.moreInfo,
    this.num,
    this.totalPrice,
  );
}
