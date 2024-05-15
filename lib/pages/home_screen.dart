import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider_db/models/transactions.dart';
import 'package:provider_db/provider/transaction_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProviders>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ລາຍການ",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              exit(0);
            },
            icon: const Icon(
              Icons.exit_to_app_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, TransactionProviders provider, child) {
          var count = provider.transactions.length;
          if (count == 0) {
            return const Scaffold(
              body: Center(
                child: Text(
                  "ບໍ່ພົບຂໍ້ມູນ",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: count,
            itemBuilder: (context, int index) {
              Transactions data = provider.transactions[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  title: Text(data.title),
                  subtitle:
                      Text(DateFormat("dd/mm/yyyy Hh:mm").format(data.date)),
                  leading: CircleAvatar(
                    radius: 40,
                    child: FittedBox(
                      child: Text(data.amount.toString()),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
