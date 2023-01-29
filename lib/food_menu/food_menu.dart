import 'package:flutter/material.dart';
import 'package:kaypay/models/transactions.dart';
import 'package:provider/provider.dart';
import 'package:kaypay/provider/food_provider.dart';

class FoodMenu extends StatefulWidget {
  const FoodMenu({Key? key}) : super(key: key);

  @override
  State<FoodMenu> createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
  /*@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TransactionProvider>(context,listen: false).initData();
  }*/
  final textColorContainer = Container(color: const Color(0xffff62fa));
  final pinkColorContainer = Container(color: const Color(0xffffe3fe));
  final bottomAppBarContainer = Container(color: const Color(0xfff5f5f5));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
          builder: (context, TransactionProvider provider, child) {
            var count = provider.transactions.length;
            if (count <= 0) {
              return const Center(
                child: Text(
                  "ไม่มีรายการอาหาร",
                  style: TextStyle(fontSize: 30.0),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: count,
                itemBuilder: (context, int index) {
                  Transactions data = provider.transactions[index];
                  return Column(
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
                                    onPressed: () {
                                    },
                                    icon: const Icon(Icons.maximize_sharp)))
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ));
  }
}
