class GroupMember {
  int? userToGroupId;
  int? groupId;
  int? userId;
  String? role;
  String? createdAt;
  String? updatedAt;
  User? user;

  GroupMember(
      {this.userToGroupId,
        this.groupId,
        this.userId,
        this.role,
        this.createdAt,
        this.updatedAt,
        this.user});

  GroupMember.fromJson(Map<String, dynamic> json) {
    userToGroupId = json['userToGroupId'];
    groupId = json['groupId'];
    userId = json['userId'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userToGroupId'] = userToGroupId;
    data['groupId'] = groupId;
    data['userId'] = userId;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
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

  User(
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
        this.account});

  User.fromJson(Map<String, dynamic> json) {
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
