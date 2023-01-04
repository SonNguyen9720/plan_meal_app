class ShoppingListModel {
  int? id;
  String? date;
  String? createdAt;
  String? updatedAt;
  ShoppingList? shoppingList;

  ShoppingListModel(
      {this.id, this.date, this.createdAt, this.updatedAt, this.shoppingList});

  ShoppingListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    shoppingList = json['shoppingList'] != null
        ? ShoppingList.fromJson(json['shoppingList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (shoppingList != null) {
      data['shoppingList'] = shoppingList!.toJson();
    }
    return data;
  }
}

class ShoppingList {
  int? id;
  String? marketTime;
  String? status;
  String? type;
  String? createdAt;
  String? updatedAt;

  ShoppingList(
      {this.id,
        this.marketTime,
        this.status,
        this.type,
        this.createdAt,
        this.updatedAt});

  ShoppingList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    marketTime = json['marketTime'];
    status = json['status'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['marketTime'] = marketTime;
    data['status'] = status;
    data['type'] = type;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
