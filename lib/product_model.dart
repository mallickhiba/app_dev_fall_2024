class Product {
  String? title;
  String? description;
  double? price;

  Product([this.title, this.description, this.price]);

  Product.fromJson(Map<String,dynamic> json){
    title = json['title'];
    description = json['description'];
    price = json['price'];
  }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = <String,dynamic>{};
    data['title'] = title;
    data['descripton'] = description;
    data['price'] = price;
    return data;
  }
}


