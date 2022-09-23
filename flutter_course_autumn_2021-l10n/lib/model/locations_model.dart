class LocationsModel {
  int? id;
  String? government;
  String? street;

  LocationsModel({this.id, this.government, this.street});

  LocationsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    government = json['government'];
    street = json['street'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['government'] = this.government;
    data['street'] = this.street;
    return data;
  }
}
