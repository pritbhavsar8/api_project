class Product2
{
  int? _id;
  String? _title;
  int? _price;
  String? _description;
  List<String>? _images;
  String? _creationAt;
  String? _updatedAt;
  Category? _category;

  Product2(
      {int? id,
        String? title,
        int? price,
        String? description,
        List<String>? images,
        String? creationAt,
        String? updatedAt,
        Category? category}) {
    if (id != null) {
      this._id = id;
    }
    if (title != null) {
      this._title = title;
    }
    if (price != null) {
      this._price = price;
    }
    if (description != null) {
      this._description = description;
    }
    if (images != null) {
      this._images = images;
    }
    if (creationAt != null) {
      this._creationAt = creationAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (category != null) {
      this._category = category;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  int? get price => _price;
  set price(int? price) => _price = price;
  String? get description => _description;
  set description(String? description) => _description = description;
  List<String>? get images => _images;
  set images(List<String>? images) => _images = images;
  String? get creationAt => _creationAt;
  set creationAt(String? creationAt) => _creationAt = creationAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  Category? get category => _category;
  set category(Category? category) => _category = category;

  Product2.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _price = json['price'];
    _description = json['description'];
    _images = json['images'].cast<String>();
    _creationAt = json['creationAt'];
    _updatedAt = json['updatedAt'];
    _category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['price'] = this._price;
    data['description'] = this._description;
    data['images'] = this._images;
    data['creationAt'] = this._creationAt;
    data['updatedAt'] = this._updatedAt;
    if (this._category != null) {
      data['category'] = this._category!.toJson();
    }
    return data;
  }
}
class Category {
  int? _id;
  String? _name;
  String? _image;
  String? _creationAt;
  String? _updatedAt;

  Category(
      {int? id,
        String? name,
        String? image,
        String? creationAt,
        String? updatedAt}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (image != null) {
      this._image = image;
    }
    if (creationAt != null) {
      this._creationAt = creationAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get image => _image;
  set image(String? image) => _image = image;
  String? get creationAt => _creationAt;
  set creationAt(String? creationAt) => _creationAt = creationAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  Category.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _creationAt = json['creationAt'];
    _updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['image'] = this._image;
    data['creationAt'] = this._creationAt;
    data['updatedAt'] = this._updatedAt;
    return data;
  }
}