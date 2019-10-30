import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oktoast/oktoast.dart';

class ScreenArgumentsUser {
  final QuerySnapshot user;

  ScreenArgumentsUser(this.user);
}

class LoginScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  Future<FirebaseUser> validateAndSubmit(var context) async {
    FirebaseUser currentUser;
    QuerySnapshot qn;

    if (validateAndSave()) {
      try {
        final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
                email: _email, password: _password))
            .user;
        print('Signed i: ${user.uid}');

        qn = await (Firestore.instance
            .collection("usuarios")
            .where("id", isEqualTo: user.uid)
            .getDocuments());

        Navigator.pushNamed(context, "home",
            arguments: ScreenArgumentsUser(qn));
      } catch (e) {
        print('Error: ${e}');
      }
    }

    return currentUser;
  }

  void getCurrentUser() async {
    FirebaseUser user = await (FirebaseAuth.instance.currentUser());
    QuerySnapshot qn;
    var fireStore = Firestore.instance;

    if (user != null) {
      try {
        qn = await (fireStore
            .collection("usuarios")
            .where("id", isEqualTo: user.uid)
            .getDocuments());
      } catch (e) {
        print("Erro ao recuperar usuário logado.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.websafe,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 200.0,
              child: ClipPath(),
            ),
            Positioned(
              child: Center(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 130.0,
                        height: 130.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/logo.png"))),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          'UMed',
                          style: TextStyle(
                              color: Colors.websafeRed,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0),
                        ),
                      ),
                      new Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Container(
                                width: 300.0,
                                child: TextFormField(
                                  validator: (value) => value.isEmpty
                                      ? 'Email can\'t be empty'
                                      : null,
                                  onSaved: (value) => _email = value,
                                  decoration: InputDecoration(
                                      labelText: 'E-mail',
                                      hintText: 'Entre com seu e-mail',
                                      hintStyle: TextStyle(
                                          color: Colors.websafeGreyPrimary),
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: Colors.websafeGreyPrimary,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0))),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 15.0, bottom: 25.0),
                              child: Container(
                                width: 300.0,
                                child: TextFormField(
                                  validator: (value) => value.isEmpty
                                      ? 'Password can\'t be empty'
                                      : null,
                                  onSaved: (value) => _password = value,
                                  decoration: InputDecoration(
                                      labelText: 'Senha',
                                      hintText: 'Entre com sua senha',
                                      hintStyle: TextStyle(
                                          color: Colors.websafeGreyPrimary),
                                      prefixIcon: Icon(
                                        Icons.security,
                                        color: Colors.websafeGreyPrimary,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0))),
                                  obscureText: true,
                                ),
                              ),
                            ),
                            Container(
                              width: 300.0,
                              child: RaisedButton(
                                splashColor: Colors.red[200],
                                color: Colors.websafeRed,
                                padding: EdgeInsets.all(12.0),
                                shape: StadiumBorder(),
                                onPressed: () {
                                  validateAndSubmit(context);
                                },
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
