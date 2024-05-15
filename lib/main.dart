import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_db/pages/from_screen.dart';
import 'package:provider_db/pages/home_screen.dart';
import 'package:provider_db/provider/transaction_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProviders();
        })
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: TabBarView(
          children: [HomeScreen(), FormScreen()],
        ),
        bottomNavigationBar: TabBar(tabs: [
          Tab(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ]),
      ),
    );
  }
}
