class ShoppingListDetail {
  int? id;
  String? date;
  String? groupId;
  String? userId;
  String? marketTime;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? marketer;

  ShoppingListDetail(
      {this.id,
        this.date,
        this.groupId,
        this.userId,
        this.marketTime,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.marketer});

  ShoppingListDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    groupId = json['groupId'];
    userId = json['userId'];
    marketTime = json['marketTime'];
    type = json['type'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    marketer = json['marketer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['groupId'] = groupId;
    data['userId'] = userId;
    data['marketTime'] = marketTime;
    data['type'] = type;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['marketer'] = marketer;
    return data;
  }
}
