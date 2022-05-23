import 'package:flutter/cupertino.dart';

class SubCategories {
  String id;
  String name;
  String? parentCategoryId;
  String logo;

  SubCategories({
    required this.id,
    required this.name,
    required this.parentCategoryId,
    required this.logo,
  });

  factory SubCategories.fromJson(Map<String, dynamic> json) {
    debugPrint(json.toString());
    return SubCategories(
        id: json['_id'],
        name: json['name'],
        logo: json['icon'] ?? '',
        parentCategoryId: json['parentCategoryId']);
  }
}

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['_id'] = id;
  //   data['name'] = name;
  //   data['parentCategoryId'] = parentCategoryId;
  //   return data;
  // }

// Step 1: On navigate pass json data
// Step 2: Filter json data (details of an item)
// Step 3: Filer json data (condition: display name id category= parent Id)
// Step 4: Put it as a part in a screen.
// Step 5: add image with json