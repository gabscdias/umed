class UserItem {
  String sName;
  String sCpf;
  String sPhone;
  String sEmail;

  UserItem({this.sName, this.sCpf, this.sPhone, this.sEmail});

  UserItem.fromJson(Map<String, dynamic> json) {
    sName = json['_name'];
    sCpf = json['_cpf'];
    sPhone = json['_phone'];
    sEmail = json['_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_name'] = this.sName;
    data['_cpf'] = this.sCpf;
    data['_phone'] = this.sPhone;
    data['_email'] = this.sEmail;
    return data;
  }
}
