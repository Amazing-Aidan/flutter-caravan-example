class Visitors {
  int familyid;
  int groupsize;
  int caravan;

  Visitors({this.familyid, this.groupsize, this.caravan});

  Visitors.fromJson(Map<String, dynamic> json) {
    familyid = json['familyid'];
    groupsize = json['groupsize'];
    caravan = json['caravan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['familyid'] = this.familyid;
    data['groupsize'] = this.groupsize;
    data['caravan'] = this.caravan;
    return data;
  }
}

