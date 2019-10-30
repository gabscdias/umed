class MedicalRecordsItem {
  String medicalRecordsId;
  String userId;
  String userName;
  String medicalRecordsDesc;

  MedicalRecordsItem(
      {this.medicalRecordsId,
      this.userId,
      this.userName,
      this.medicalRecordsDesc});

  MedicalRecordsItem.fromJson(Map<String, dynamic> json) {
    medicalRecordsId = json['medicalRecordsId'];
    userId = json['userId'];
    userName = json['userName'];
    medicalRecordsDesc = json['medicalRecordsDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medicalRecordsId'] = this.medicalRecordsId;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['medicalRecordsDesc'] = this.medicalRecordsDesc;
    return data;
  }
}
