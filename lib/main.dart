import 'package:flutter/material.dart';
import 'package:kaypay/food_menu/addfood_menu.dart';
import 'package:kaypay/food_menu/food_menu.dart';
import 'package:kaypay/provider/food_provider.dart';
import 'package:kaypay/provider/historyfood_provider.dart';
import 'package:provider/provider.dart';
import 'package:kaypay/food_menu/historyfood_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context){
            return TransactionProvider();
          }),
          ChangeNotifierProvider(create: (context){
            return HistoryFood_Provider();
          })
        ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'kaypay',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Kay&Pay',
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  'THB',
                  style: TextStyle(fontSize: 15.0),
                )
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddFood()),
                    );
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          backgroundColor: Colors.blue,
          body: const TabBarView(
            children: [
              FoodMenu(),
              HistoryFood()
            ],
          ),
          bottomNavigationBar: const TabBar(tabs: [
            Tab(
              text: "รายการอาหาร",
            ),
            Tab(
              text: "ประวัติรายการ",
            )
          ]),
        ));
  }
}

