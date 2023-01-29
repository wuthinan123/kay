import 'package:flutter/material.dart';
import 'package:kaypay/models/transactions.dart';
import 'package:kaypay/provider/historyfood_provider.dart';

import 'package:provider/provider.dart';

class HistoryFood extends StatefulWidget {
  const HistoryFood({Key? key}) : super(key: key);

  @override
  State<HistoryFood> createState() => _HistoryFoodState();
}

class _HistoryFoodState extends State<HistoryFood> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HistoryFood_Provider>(context, listen: false).initData();
  }


  @override
  Widget build(BuildContext context) {
    final todoP = Provider.of<HistoryFood_Provider>(context,listen:false);
    return Scaffold(
      backgroundColor: Colors.white24,
      body : Consumer(
        builder: (context, HistoryFood_Provider provider, child) {
          var count = provider.transactions.length;
          if (count <= 0) {
            return const Center(
              child: Text(
                "ไม่มีประวัติ",
                style: TextStyle(fontSize: 30.0),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.white24,
              body: ListView.builder(
                itemCount: count,
                itemBuilder: (context, int index) {
                  Transactions data = provider.transactions[index];
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Card(
                          elevation: 5,
                          margin: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              const Expanded(
                                  flex: 2,
                                  child: Icon(
                                    Icons.emoji_food_beverage,
                                    size: 20,
                                  )),
                              Expanded(
                                  flex: 7,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(data.title.toString()),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                const Text('ราคา '),
                                                Text(data.amount.toString()),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                const Text('จำนวน '),
                                                Text(data.amount2.toString()),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: IconButton(
                                      onPressed: () async {
                                        await todoP.deleteTable();
                                      },
                                      icon: const Icon(Icons.maximize_sharp)))
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
