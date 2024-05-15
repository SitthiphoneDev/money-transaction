import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_db/main.dart';
import 'package:provider_db/models/transactions.dart';
import 'package:provider_db/provider/transaction_provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final keyform = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ບັນທຶກຂໍ້ມູນ",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Form(
        key: keyform,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "ຊື່ລາຍການ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return "ກະລຸນາປ້ອນລາຍການ";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: "ຈຳນວນເງິນ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return "ກະລຸນາປ້ອນຈຳນວນເງິນ";
                  }

                  if (double.parse(str) <= 0) {
                    return "ກະລຸນາໃສ່ຕົວເລກໃຫຍ່ກວ່າສູນ";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (keyform.currentState!.validate()) {
                      var title = titleController.text;
                      var amount = amountController.text;

                      var provider = Provider.of<TransactionProviders>(context,
                          listen: false);

                      Transactions statement = Transactions(
                          title: title,
                          amount: double.parse(amount),
                          date: DateTime.now());

                      provider.addTransaction(statement);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyApp()));
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Colors.purple,
                    ),
                  ),
                  child: const Text(
                    "ບັນທຶກຂໍ້ມູນ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
