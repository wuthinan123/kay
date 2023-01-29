import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaypay/provider/food_provider.dart';
import 'package:kaypay/provider/historyfood_provider.dart';
import 'package:provider/provider.dart';
import 'package:kaypay/models/transactions.dart';

class AddFood extends StatefulWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  String? imagePath;
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final amount2titleController = TextEditingController();
  final peopleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'เพิ่มรายการอาหาร',
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                'THB',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              )
            ],
          ),
        ),
        body: Form(
          key: formKey,
          child: ListView(children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10.0,
                ),
                /*Card(
                child:
                InkWell(
                  onTap: (){
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ElevatedButton.icon(onPressed: (){pickMedia();},icon: const Icon(
                                  Icons.image,size: 24.0,
                                ),
                                  label: const Text('Pick Gallery'),),
                                ElevatedButton(
                                  child: const Text('BACK'),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child:
                  (imagePath != null)
                    ? Image.file(File(imagePath!))
                      : Container(
                    width: 100.0,
                    height: 100.0,
                    margin:  const EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: borderRadius,
                      child: SizedBox.fromSize(
                        size:  const Size.fromRadius(48),
                        child:  const Image(
                          fit: BoxFit.fill,image: AssetImage('assets/images/Image2.png'),),
                      ),
                    ),
                  ),
                ),
              ),*/
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'ชื่อรายการอาหาร'),
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        validator: (str) {
                          if (str == null || str.isEmpty) {
                            return 'ใส่ชื่ออาหาร';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        Expanded(
                            flex: 2,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'ราคาอาหาร',
                              ),
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              validator: (str) {
                                if (str == null || str.isEmpty) {
                                  return 'ใส่ราคาอาหาร';
                                }
                                if (double.parse(str) < 0) {
                                  return 'ไปล้างจานนะถ้าจะตังไม่มี';
                                }
                                if (double.parse(str) == 0) {
                                  return 'กินฟรี!! มีคนกินฟรี!!';
                                }
                                return null;
                              },
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'จำนวน'),
                            controller: amount2titleController,
                            keyboardType: TextInputType.number,
                            validator: (str) {
                              if (str == null || str.isEmpty) {
                                return 'ใส่จำนวนอาหาร';
                              }
                              return null;
                            },
                          ),
                        )
                      ])
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.lightBlue)),
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 200,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text(
                          'เพิ่มคน',
                          style: TextStyle(fontSize: 15.0),
                        )),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      var title = titleController.text;
                      var amount = amountController.text;
                      var amount2 = amount2titleController.text;

                      Transactions statement = Transactions(
                        title: title,
                        amount: double.parse(amount),
                        amount2: int.parse(amount2),
                      );
                      var providerh = Provider.of<HistoryFood_Provider>(context,
                        listen: false);
                      providerh.addTransaction(statement);

                      var provider = Provider.of<TransactionProvider>(context,
                          listen: false);
                      provider.addTransaction(statement);
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 24.0,
                  ),
                  label: const Text('ตกลง'),
                ),
              ],
            ),
          ]),
        ));
  }

  void pickMedia() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 100, maxWidth: 100);
    if (file != null) {
      imagePath = file.path;
      setState(() {});
    }
  }
}
