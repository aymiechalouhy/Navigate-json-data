class SubCategories {
  String id;
  String name;
  String parentCategoryId;

  SubCategories(
      {required this.id,
       required this.name,
       required this.parentCategoryId,
      });

    factory SubCategories.fromJson (Map<String, dynamic> json)  {
    return SubCategories(
        id: json['_id'],
        name: json['name'],
        parentCategoryId: json['parentCategoryId']);
  }
    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['parentCategoryId'] = this.parentCategoryId;
    return data;
  }
}
