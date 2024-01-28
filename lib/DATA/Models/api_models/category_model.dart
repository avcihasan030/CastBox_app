class Category {
  String href;
  List<CategoryIcon> icons;
  String id;
  String name;

  Category({
    required this.href,
    required this.icons,
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      href: json['href'],
      icons: List<CategoryIcon>.from(
          json['icons'].map((x) => CategoryIcon.fromJson(x))),
      id: json['id'],
      name: json['name'],
    );
  }
}

class CategoryIcon {
  int? height;
  String? url;
  int? width;

  CategoryIcon({
    this.height,
    this.url,
    this.width,
  });

  factory CategoryIcon.fromJson(Map<String, dynamic> json) {
    return CategoryIcon(
      height: json['height'],
      url: json['url'],
      width: json['width'],
    );
  }
}

class Categories {
  String href;
  int limit;
  String? next;
  int offset;
  dynamic previous;
  int total;
  List<Category> items;

  Categories({
    required this.href,
    required this.limit,
    required this.next,
    required this.offset,
    required this.previous,
    required this.total,
    required this.items,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      href: json['href'],
      limit: json['limit'],
      next: json['next'],
      offset: json['offset'],
      previous: json['previous'],
      total: json['total'],
      items: List<Category>.from(
          json['items'].map((x) => Category.fromJson(x))),
    );
  }
}
