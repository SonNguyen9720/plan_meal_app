class UserInfo {
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
  int? desiredWeight;
  String? activityIntensity;
  String? email;
  String? createdAt;
  String? updatedAt;
  bool? active;
  Group? group;

  UserInfo(
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
        this.desiredWeight,
        this.activityIntensity,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.active,
        this.group});

  UserInfo.fromJson(Map<String, dynamic> json) {
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
    desiredWeight = json['desiredWeight'];
    activityIntensity = json['activityIntensity'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    active = json['active'];
    group = json['group'] != null ? Group.fromJson(json['group']) : null;
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
    data['desiredWeight'] = desiredWeight;
    data['activityIntensity'] = activityIntensity;
    data['email'] = email;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['active'] = active;
    if (group != null) {
      data['group'] = group!.toJson();
    }
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
