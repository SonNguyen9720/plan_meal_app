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
  Marketer? marketer;

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
    marketer = json['marketer'] != null
        ? Marketer.fromJson(json['marketer'])
        : null;
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
    if (marketer != null) {
      data['marketer'] = marketer!.toJson();
    }
    return data;
  }
}

class Marketer {
  int? id;
  String? firstName;
  String? lastName;
  String? dob;
  String? sex;
  int? height;
  int? weight;
  int? age;
  String? imageUrl;
  String? healthGoal;
  String? groupId;
  int? desiredWeight;
  String? activityIntensity;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;
  bool? active;

  Marketer(
      {this.id,
        this.firstName,
        this.lastName,
        this.dob,
        this.sex,
        this.height,
        this.weight,
        this.age,
        this.imageUrl,
        this.healthGoal,
        this.groupId,
        this.desiredWeight,
        this.activityIntensity,
        this.email,
        this.password,
        this.createdAt,
        this.updatedAt,
        this.active});

  Marketer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    dob = json['dob'];
    sex = json['sex'];
    height = json['height'];
    weight = json['weight'];
    age = json['age'];
    imageUrl = json['imageUrl'];
    healthGoal = json['healthGoal'];
    groupId = json['groupId'];
    desiredWeight = json['desiredWeight'];
    activityIntensity = json['activityIntensity'];
    email = json['email'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['dob'] = dob;
    data['sex'] = sex;
    data['height'] = height;
    data['weight'] = weight;
    data['age'] = age;
    data['imageUrl'] = imageUrl;
    data['healthGoal'] = healthGoal;
    data['groupId'] = groupId;
    data['desiredWeight'] = desiredWeight;
    data['activityIntensity'] = activityIntensity;
    data['email'] = email;
    data['password'] = password;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['active'] = active;
    return data;
  }
}
