class Preorder {
  int? preorderId;
  int? flightInfoId;
  String? name;
  String? lastName;
  String? seatNo;
  String? pnrNo;
  String? ssrCode;
  int? boPreorderId;
  String? status;
  // DateTime? editDate; => original version
  String? editDate;
  int? editCrewGroupId;
  int? count;
  int? productId;
  Preorder(
      {this.preorderId,
      this.flightInfoId,
      this.name,
      this.lastName,
      this.seatNo,
      this.pnrNo,
      this.ssrCode,
      this.boPreorderId,
      this.status,
      this.editDate,
      this.editCrewGroupId,
      this.count,
      this.productId});

  Preorder.fromJson(Map<String, dynamic> json) {
    preorderId = int.parse(json['PREORDER_ID'].toString());
    flightInfoId = int.parse(json['FLIGHT_INFO_ID'].toString());
    name = json['NAME'];
    lastName = json['LAST_NAME'];
    seatNo = json['SEAT_NO'];
    pnrNo = json['PNR_NO'];
    ssrCode = json['SSR_CODE'];
    boPreorderId = int.parse(json['BO_PREORDER_ID'].toString());
    status = json['STATUS'];
    editDate = json['EDIT_DATE'].toString();
    editCrewGroupId = json['EDIT_CREW_GROUP_ID'];
    count = json['COUNT'];
    productId = json['PRODUCT_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PREORDER_ID'] = preorderId;
    data['FLIGHT_INFO_ID'] = flightInfoId;
    data['NAME'] = name;
    data['LAST_NAME'] = lastName;
    data['SEAT_NO'] = seatNo;
    data['PNR_NO'] = pnrNo;
    data['SSR_CODE'] = ssrCode;
    data['BO_PREORDER_ID'] = boPreorderId;
    data['STATUS'] = status;
    data['EDIT_DATE'] = editDate;
    data['EDIT_CREW_GROUP_ID'] = editCrewGroupId;
    data['COUNT'] = count;
    data['PRODUCT_ID'] = productId;

    return data;
  }
}

// Preorder fecthPreorder(Map<String, dynamic> line) {
//   return Preorder(
//     preorderId: line['PREORDER_ID'],
//     flightInfoId: line['FLIGHT_INFO_ID'],
//     name: line['NAME'],
//     lastName: line['LAST_NAME'],
//     seatNo: line['SEAT_NO'],
//     pnrNo: line['PNR_NO'],
//     ssrCode: line['SSR_CODE'],
//     boPreorderId: line['BO_PREORDER_ID'],
//     status: line['STATUS'],
//     editDate: line['EDIT_DATE'],
//     editCrewGroupId: line['EDIT_CREW_GROUP_ID'],
//     count: line['COUNT'],
//     productId: line['PRODUCT_ID'],
//   );
// }
