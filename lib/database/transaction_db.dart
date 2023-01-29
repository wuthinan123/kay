import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../models/transactions.dart';

class TransactionDB {
  //บริการข้อมูล

  String? dbName; //เก็บชื่อ

  TransactionDB({this.dbName});

  Future<Database> openDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  Future<int> insertData(Transactions statement) async {
    //ฐานข้อมูล
    //transaction.db => expense
    var db = await openDatabase();
    var store = intMapStoreFactory.store("expense");

    //json
    var keyID = store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "amount2": statement.amount2
    });
    db.close();
    return keyID;
  }

  //ดึงข้อมูล
  Future<List<Transactions>> loadAllData() async{
    var db = await openDatabase();
    var store = intMapStoreFactory.store("expense");
    var snapshot = await store.find(db,finder: Finder(sortOrders: [SortOrder(Field.key,false)]));
    List<Transactions> transactionList = List<Transactions>.from(<List<Transactions>>[]);
    for(dynamic record in snapshot){
      transactionList.add(
        Transactions(
          title: record["title"],
          amount: record["amount"],
          amount2: record["amount2"]
        )
      );
    }
    return transactionList;
  }

  Future deleteTable(String tableName)async{
    final db = await openDatabase();
    var store = intMapStoreFactory.store(tableName);
    await store.delete(db);
    return true;
  }


}
