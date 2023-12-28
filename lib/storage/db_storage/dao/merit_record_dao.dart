import 'package:flutter_practice/pages/muyu/models/muyu_merit_record.dart';
import 'package:sqflite/sqflite.dart';

class MeritRecordDao {
  final Database database;

  MeritRecordDao(this.database);

  static String tableName = 'merit_record';
  static String tableSql = """
CREATE TABLE $tableName (
id VARCHAR(64) PRIMARY KEY,
value INTEGER, 
image TEXT,
audio TEXT,
timestamp INTEGER
)""";

  static Future<void> createTable(Database db) async {
    return db.execute(tableSql);
  }

  Future<int> insert(MuYuMeritRecord record) {
    return database.insert(
      tableName,
      record.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<MuYuMeritRecord>> query() async {
    List<Map<String, Object?>> data = await database.query(
      tableName,
    );
    return data
        .map((e) => MuYuMeritRecord(
              e['id'].toString(),
              e['timestamp'] as int,
              e['value'] as int,
              e['image'].toString(),
              e['audio'].toString(),
            ))
        .toList();
  }
}
