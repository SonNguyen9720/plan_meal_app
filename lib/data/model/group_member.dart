class GroupMember {
  int? userToGroupId;
  int? groupId;
  int? userId;
  String? role;
  User? user;

  GroupMember(
      {this.userToGroupId, this.groupId, this.userId, this.role, this.user});

  GroupMember.fromJson(Map<String, dynamic> json) {
    userToGroupId = json['userToGroupId'];
    groupId = json['groupId'];
    userId = json['userId'];
    role = json['role'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userToGroupId'] = userToGroupId;
    data['groupId'] = groupId;
    data['userId'] = userId;
    data['role'] = role;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? sex;
  int? height;
  int? weight;
  String? imageUrl;
  String? healthGoal;
  String? groupId;
  int? desiredWeight;
  String? activityIntensity;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.sex,
        this.height,
        this.weight,
        this.imageUrl,
        this.healthGoal,
        this.groupId,
        this.desiredWeight,
        this.activityIntensity,
        this.email,
        this.password,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    sex = json['sex'];
    height = json['height'];
    weight = json['weight'];
    imageUrl = json['imageUrl'];
    healthGoal = json['healthGoal'];
    groupId = json['groupId'];
    desiredWeight = json['desiredWeight'];
    activityIntensity = json['activityIntensity'];
    email = json['email'];
    password = json['password'];
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
    data['imageUrl'] = imageUrl;
    data['healthGoal'] = healthGoal;
    data['groupId'] = groupId;
    data['desiredWeight'] = desiredWeight;
    data['activityIntensity'] = activityIntensity;
    data['email'] = email;
    data['password'] = password;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
