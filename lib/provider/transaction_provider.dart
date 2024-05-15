import 'package:flutter/foundation.dart';
import 'package:provider_db/database/transaction_db.dart';
import 'package:provider_db/models/transactions.dart';

class TransactionProviders with ChangeNotifier {
  List<Transactions> transactions = [];

  List<Transactions> getTransaction() {
    return transactions;
  }

  Future<TransactionDB> initData() async {
    var db = TransactionDB(dbName: "transactions.db");
    transactions = await db.loadAlldata();
    notifyListeners();
    return db;
  }

  void addTransaction(Transactions statement) async {
    var db = TransactionDB(dbName: "transactions.db");
    await db.insertData(statement);

    //select data
    transactions = await db.loadAlldata();
    notifyListeners();
  }
}
