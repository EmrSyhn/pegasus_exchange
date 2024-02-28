class Exchange {
  String? fromCur;
  String? toCur;
  double? excRate;
  int? exchangeId;
  String? currInfo;
  Exchange({
    this.fromCur,
    this.toCur,
    this.excRate,
    this.exchangeId,
    this.currInfo,
  });

  Exchange.fromJson(Map<String, dynamic> json) {
    fromCur = json['FROM_CUR'];
    toCur = json['TO_CUR'];
    excRate = double.parse(json['EXC_RATE'].toString());
    exchangeId = int.parse(json['EXCHANGE_ID'].toString());
    currInfo = json['CURR_INFO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FROM_CUR'] = fromCur;
    data['TO_CUR'] = toCur;
    data['EXC_RATE'] = excRate;
    data['EXCHANGE_ID'] = exchangeId;
    data['CURR_INFO'] = currInfo;

    return data;
  }
}

Exchange fecthExchange(Map<String, dynamic> line) {
  return Exchange(
    fromCur: line['FROM_CUR'],
    toCur: line['TO_CUR'],
    excRate: line['EXC_RATE'],
    exchangeId: line['EXCHANGE_ID'],
    currInfo: line['CURR_INFO'],
  );
}
