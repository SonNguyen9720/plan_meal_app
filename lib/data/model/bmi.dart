class BMI {
  double? currentBMI;
  String? type;

  BMI({this.currentBMI, this.type});

  BMI.fromJson(Map<String, dynamic> json) {
    currentBMI = json['currentBMI'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentBMI'] = currentBMI;
    data['type'] = type;
    return data;
  }
}