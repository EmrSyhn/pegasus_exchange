import '../../model/preorder_model.dart';

/*
PREORDER DB STATUS
T: Teslim edildi
E: İkram yok
M: Misafir yok
H: Hasarlı
*/

class PreorderDaoRepository {
  dynamic dbhelper;

  final String tableName = "PREORDER";
  final String searchKey = "";
  final String arrivalTimeKey = "";
  final int crewId = 0;
  final int flightInfoId = 1013;

  Future<List<Preorder>> fetchPreorderList() async {
    var db = await dbhelper.accessDatabase();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM $tableName WHERE FLIGHT_INFO_ID = $flightInfoId ");
    return List.generate(maps.length, (index) {
      var line = maps[index];
      return Preorder.fromJson(line);
    });
  }

  Future<void> updatePreorderList(List<Preorder> preorderList) async {
    var db = await dbhelper.accessDatabase();
    for (var seatStatus in preorderList) {
      await db.update(
        tableName,
        {'STATUS': seatStatus.status},
        where: 'PREORDER_ID = ?',
        whereArgs: [seatStatus.preorderId],
      );
    }
  }
}
