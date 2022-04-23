import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class register extends StatefulWidget {
  @override
  State<register> createState() => _registerState();
}

class Profile {
  String email = "";
  String password = "";
}

class _registerState extends State<register> {
  Profile profile = Profile();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
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
              appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 226, 112, 192),
                title: Text('Register'),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(50.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (String inValue) {
                                if (inValue.length == 0) {
                                  return "Please enter email";
                                }
                                return null;
                              },
                              onSaved: (String email) {
                                profile.email = email;
                              },
                              decoration: InputDecoration(
                                  // hintText: "none@none.com",
                                  labelText: "Email")),
                          TextFormField(
                              obscureText: true,
                              validator: (String inValue) {
                                if (inValue.length == 0) {
                                  return "Please enter passwoed";
                                }
                                return null;
                              },
                              onSaved: (String password) {
                                profile.password = password;
                              },
                              decoration: InputDecoration(
                                  // hintText: "none@none.com",
                                  labelText: "Password")),
                          SizedBox(
                            child: ElevatedButton(
                              child: Text('ลงทะเบียน'),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                      email: profile.email,
                                      password: profile.password,
                                    )
                                        .then((value) {
                                      Fluttertoast.showToast(
                                        msg: "สร้างบัญชีเรียบร้อย",
                                        gravity: ToastGravity.CENTER,
                                      );

                                      _formKey.currentState.reset();
                                      Navigator.pushNamed(context, '/login');
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    Fluttertoast.showToast(
                                      msg: e.message,
                                      gravity: ToastGravity.CENTER,
                                    );
                                  }
                                }
                              },
                            ),
                          )
                        ],
                      )),
                ),
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
