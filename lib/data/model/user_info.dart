class UserInfo {
  int? id;
  String? firstName;
  String? lastName;
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
  String? createdAt;
  String? updatedAt;

  UserInfo(
      {this.id,
        this.firstName,
        this.lastName,
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
        this.createdAt,
        this.updatedAt});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
