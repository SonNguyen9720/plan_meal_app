class UserInfo {
  int? id;
  int? height;
  int? weight;
  String? healthGoal;
  int? desiredWeight;
  String? activityIntensity;
  String? createdAt;
  String? updatedAt;
  bool? active;
  String? role;
  Account? account;
  Group? group;

  UserInfo(
      {this.id,
        this.height,
        this.weight,
        this.healthGoal,
        this.desiredWeight,
        this.activityIntensity,
        this.createdAt,
        this.updatedAt,
        this.active,
        this.role,
        this.account,
        this.group});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    height = json['height'];
    weight = json['weight'];
    healthGoal = json['healthGoal'];
    desiredWeight = json['desiredWeight'];
    activityIntensity = json['activityIntensity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    active = json['active'];
    role = json['role'];
    account =
    json['account'] != null ? Account.fromJson(json['account']) : null;
    group = json['group'] != null ? Group.fromJson(json['group']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['height'] = height;
    data['weight'] = weight;
    data['healthGoal'] = healthGoal;
    data['desiredWeight'] = desiredWeight;
    data['activityIntensity'] = activityIntensity;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['active'] = active;
    data['role'] = role;
    if (account != null) {
      data['account'] = account!.toJson();
    }
    if (group != null) {
      data['group'] = group!.toJson();
    }
    return data;
  }
}

class Account {
  int? id;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? dob;
  String? sex;
  String? imageUrl;
  String? role;
  String? createdAt;
  String? updatedAt;

  Account(
      {this.id,
        this.email,
        this.password,
        this.firstName,
        this.lastName,
        this.dob,
        this.sex,
        this.imageUrl,
        this.role,
        this.createdAt,
        this.updatedAt});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    dob = json['dob'];
    sex = json['sex'];
    imageUrl = json['imageUrl'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['password'] = password;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['dob'] = dob;
    data['sex'] = sex;
    data['imageUrl'] = imageUrl;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Group {
  int? id;
  String? name;
  String? password;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  Group(
      {this.id,
        this.name,
        this.password,
        this.imageUrl,
        this.createdAt,
        this.updatedAt});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    password = json['password'];
    imageUrl = json['imageUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['password'] = password;
    data['imageUrl'] = imageUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
