class Product {
  dynamic productId;
  String productName;
  String manufactureName;
  String model;
  String size;
  dynamic price;
  String description;
  dynamic inStock;
  String picture1;
  String picture2;
  String picture3;

  Product(
      {this.productId,
      this.productName,
      this.manufactureName,
      this.model,
      this.size,
      this.price,
      this.description,
      this.inStock,
      this.picture1,
      this.picture2,
      this.picture3});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['productId'] = productId;
    map['productName'] = productName;
    map['manufactureName'] = manufactureName;
    map['model'] = model;
    map['size'] = size;
    map['price'] = price;
    map['description'] = description;
    map['inStock'] = inStock;
    map['picture1'] = picture1;
    map['picture2'] = picture2;
    map['picture3'] = picture3;

    return map;
  }

  Product.fromMapObject(Map<String, dynamic> map) {
    this.productId = map['productId'];
    this.productName = map['productName'];
    this.manufactureName = map['manufactureName'];
    this.model = map['model'];
    this.size = map['size'];
    this.price = map['price'];
    this.description = map['description'];
    this.inStock = map['inStock'];
    this.picture1 = map['picture1'];
    this.picture2 = map['picture2'];
    this.picture3 = map['picture3'];
  }
  void printAll() {
    print("id: " + productId.toString());
    print("name: " + productName);
    print("brand: $manufactureName");
    print("model: " + model);
    print("size: " + size);
    print("price: Rs." + price.toString());
    print("Description: " + description);
    print("stock: " + inStock.toString());
  }
}
