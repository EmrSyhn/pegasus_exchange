import '../../model/exchange.dart';

class ExchangeRepository {
  dynamic dbHelper;
  final String exchangeTableName = "EXCHANGE";
  Future<List<Exchange>> fetchExchangeList() async {
    var db = await dbHelper.accessDatabase();
    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM $exchangeTableName");
    return List.generate(maps.length, (index) {
      var line = maps[index];

      return Exchange.fromJson(line);
    });
  }
}
