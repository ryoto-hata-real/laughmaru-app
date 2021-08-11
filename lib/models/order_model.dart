class OrderModel {
  String productName = '';
  String orderDate = '';
  String customerName = '';
  String customerEmail = '';
  String customerPostal = '';
  String customerAddress = '';
  String customerTel = '';
  String deliDate = '';
  String deliTime = '';
  String other = '';
  int num, totalPrice;
  bool deliveredFlf = false;
  OrderModel(
    this.productName,
    this.customerName,
    this.customerEmail,
    this.customerAddress,
    this.orderDate,
    this.deliDate,
    this.deliTime,
    this.other,
    this.num,
    this.totalPrice,
  );
  String createOrderBody() {
    String body = """商品名：$productName  注文日：$orderDate
    個数：$num
    合計金額：$totalPrice
    ご注文者氏名：$customerName
    メールアドレス：$customerEmail
    電話番号：$customerTel
    住所：
    　郵便番号：$customerPostal
    　お住まい：$customerAddress
    配達希望日：$deliDate
    時間指定：$deliTime
    その他の要望：$other
    """;
    return body;
  }

  String createOrderSubject() {
    String subject = "$customerName 様 : $productName × $num";
    return subject;
  }
}
