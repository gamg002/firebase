import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/data1.dart';

class addpage extends StatefulWidget {
  const addpage({Key key}) : super(key: key);

  @override
  State<addpage> createState() => _addpageState();
}

class _addpageState extends State<addpage> {
  GlobalKey<FormState> form = new GlobalKey<FormState>();
  Data1 myData = Data1();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _Datacollection =
      FirebaseFirestore.instance.collection("Data1");
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Error'),
              ),
              body: Center(child: Text("${snapshot.error}")),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: form,
                      child: Column(
                        children: [
                          TextFormField(
                              validator: (String val) {
                                if (val.length == 0) {
                                  return 'กรุณากรอก "ชื่อ" ของคุณด้วย';
                                }
                                return null;
                              },
                              onSaved: (String fname) {
                                myData.fname = fname;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.blue,
                                  ),
                                  hintText: 'ชื่อ',
                                  hintStyle: TextStyle(color: Colors.blue))),
                          TextFormField(
                              validator: (String val) {
                                if (val.length == 0) {
                                  return 'กรุณากรอก "สกุล" ของคุณด้วย';
                                }
                                return null;
                              },
                              onSaved: (String lname) {
                                myData.lname = lname;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.blue,
                                  ),
                                  hintText: 'สกุล',
                                  hintStyle: TextStyle(color: Colors.blue))),
                          TextFormField(
                              validator: (String val) {
                                if (val.length == 0) {
                                  return 'กรุณากรอกเบอร์โทรศัพท์';
                                }
                                return null;
                              },
                              onSaved: (String tel) {
                                myData.tel = tel;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.add_call,
                                    color: Colors.blue,
                                  ),
                                  hintText: 'โทรศัพท์',
                                  hintStyle: TextStyle(color: Colors.blue))),
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (form.currentState.validate()) {
                                  form.currentState.save();
                                  await _Datacollection.add({
                                    "fname": myData.fname,
                                    "lname": myData.lname,
                                    "tel": myData.tel
                                  });
                                  form.currentState.reset();
                                }
                              },
                              child: Text('บันทึกข้อมูล'),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
