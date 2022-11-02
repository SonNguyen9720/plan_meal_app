class GroupUser {
  int? userToGroupId;
  int? groupId;
  int? userId;
  String? role;
  Group? group;

  GroupUser(
      {this.userToGroupId, this.groupId, this.userId, this.role, this.group});

  GroupUser.fromJson(Map<String, dynamic> json) {
    userToGroupId = json['userToGroupId'];
    groupId = json['groupId'];
    userId = json['userId'];
    role = json['role'];
    group = json['group'] != null ? Group.fromJson(json['group']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userToGroupId'] = userToGroupId;
    data['groupId'] = groupId;
    data['userId'] = userId;
    data['role'] = role;
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