import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabaseWithSqfLite {
  Database? _database;

  Future<Database?> get getDataFromDataBase async {
    if (_database == null) {
      _database = await _initialDataBase();
      return _database;
    } else {
      return _database;
    }
  }

  Future _initialDataBase() async {
    String path = await getDatabasesPath();
    String dbName = join(path, 'myDb.db');
    Database myDb = await openDatabase(dbName,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return myDb;
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("OnUpgrade-------------------------------");
    //await db.execute("ALTER TABLE notes ADD COLUMN title");
  }

  Future deleteDatabaseFun() async {
    String path = await getDatabasesPath();
    String dbName = join(path, 'myDb.db');
    await deleteDatabase(dbName);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE notes (id INTEGER PRIMARY KEY , note TEXT NOT NULL , date TEXT NOT NULL , hint TEXT)');
    print("Database Created Successfully----------------------------------");
  }

  Future readData(String sql) async {
    Database? db = await getDataFromDataBase;
    List<Map> response = await db!.rawQuery(sql);
    print("Data retrived successfully from database");
    return response;
  }

  Future insertData(String sql) async {
    Database? db = await getDataFromDataBase;
    int response = await db!.rawInsert(sql);
    print("Data Inserted successfully to database");
    return response;
  }

  Future updateData(String sql) async {
    Database? db = await getDataFromDataBase;
    int response = await db!.rawUpdate(sql);
    print("Data Updated successfully to database");
    return response;
  }

  Future deleteData(String sql) async {
    Database? db = await getDataFromDataBase;
    int response = await db!.rawDelete(sql);
    print("Data Deleted successfully from database");
    return response;
  }
}
