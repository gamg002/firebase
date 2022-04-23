import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/home.dart';
import 'package:flutter_application_2/register.dart';
import 'package:fluttertoast/fluttertoast.dart';

class login extends StatefulWidget {
  const login({Key key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class LoginData {
  String user = "";
  String pass = "";
}

class _loginState extends State<login> {
  LoginData _loginData = new LoginData();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                  title: Text('LOGIN'),
                ),
                body: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.all(50.0),
                      child: Form(
                          key: this._formKey,
                          child: Column(children: [
                            Image.network(
                              "https://cdn-icons-png.flaticon.com/512/3039/3039367.png",
                              height: 200,
                              width: 150,
                            ),
                            TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                validator: (String inValue) {
                                  if (inValue.length == 0) {
                                    return "Please enter email";
                                  }
                                  return null;
                                },
                                onSaved: (String inValue) {
                                  this._loginData.user = inValue;
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    // hintText: "none@none.com",
                                    labelText: "Email")),
                            TextFormField(
                                obscureText: true,
                                validator: (String inValue) {
                                  if (inValue.length == 0) {
                                    return "Please enter Password";
                                  }
                                  return null;
                                },
                                onSaved: (String inValue) {
                                  this._loginData.pass = inValue;
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock),
                                    labelText: "Password")),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    child: Text("Log In!"),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        try {
                                          await FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: _loginData.user,
                                                  password: _loginData.pass)
                                              .then((value) {
                                            _formKey.currentState.reset();
                                            MaterialPageRoute route =
                                                MaterialPageRoute(
                                              builder: (context) => home(),
                                            );
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                route,
                                                (route) => false);
                                          });
                                        } on FirebaseAuthException catch (e) {
                                          Fluttertoast.showToast(
                                            msg: e.message,
                                            gravity: ToastGravity.BOTTOM,
                                          );
                                        }
                                      }
                                    }),
                                SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton(
                                    child: Text("Register"),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/register');
                                    }),
                              ],
                            ),
                          ]))),
                ));
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
