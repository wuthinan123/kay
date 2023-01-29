import 'package:flutter/foundation.dart';
import 'package:kaypay/database/transaction_db.dart';
import 'package:kaypay/models/transactions.dart';
import 'package:kaypay/provider/historyfood_provider.dart';
import 'package:path/path.dart';

class TransactionProvider with ChangeNotifier{
  //ตัวอย่างข้อมูล
   List<Transactions> transactions = [];


   //ดึงข้อมูล
   List<Transactions> getTransaction(){
     return transactions;
   }

   void initData() async{
     var db = TransactionDB(dbName: "transaction.db");
     transactions = await db.loadAllData();
     notifyListeners();
   }

   void addTransaction(Transactions statement) async {
     //var db = TransactionDB(dbName: "transaction.db");
     //บันทึกข้อมูล
     //await db.insertData(statement);
     //ดึงข้อมูลมาแสดงผล

     transactions.insert(0, statement);
     //transactions = await db.loadAllData();
     //แจ้งเตือน Consumer
     notifyListeners();
   }

}


