import 'package:flutter/widgets.dart';
import 'package:kaypay/database/transaction_db.dart';
import 'package:kaypay/models/transactions.dart';

class HistoryFood_Provider with ChangeNotifier {
  List<Transactions> transactions = [];

  List<Transactions> getTransaction() {
    return transactions;
  }

  void initData() async {
    var db = TransactionDB(dbName: "transaction.db");
    transactions = await db.loadAllData();
    notifyListeners();
  }

  void addTransaction(Transactions statement) async {
    var db = TransactionDB(dbName: "transaction.db");
    //บันทึกข้อมูล
    await db.insertData(statement);
    //ดึงข้อมูลมาแสดงผล

    transactions.insert(0, statement);
    transactions = await db.loadAllData();
    //แจ้งเตือน Consumer
    notifyListeners();
  }

  Future deleteTable() async{
    var db = TransactionDB(dbName: "transaction.db");
    await db.deleteTable("expense");
    transactions.clear();
    transactions = await db.loadAllData();
    notifyListeners();
  }
}
