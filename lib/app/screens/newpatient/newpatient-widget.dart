import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:umed_v2/app/shared/widgets/sidedraw-widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:umed_v2/app/shared/models/user-model.dart';

class ScreenArguments {
  final String userId;

  ScreenArguments(this.userId);
}

class NewPatientScreen extends StatefulWidget {
  @override
  _NewPatientScreenPageState createState() => _NewPatientScreenPageState();
}

class _NewPatientScreenPageState extends State<NewPatientScreen> {
  static const routeName = '/extractArguments';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = new GlobalKey<FormState>();

  String _name;
  String _cpf;
  String _phone;
  String _type = 'P';
  String _email;
  String _password = '123456';

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  void createUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    var _firebaseUser;

    if (validateAndSave()) {
      try {
        final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
                email: _email, password: '123456'))
            .user;
        _firebaseUser = user;
        print('Registered user: ${user.uid}');

        if (user.uid != null) {
          Firestore.instance.collection('usuarios').document(user.uid).setData({
            'id': user.uid,
            'name': _name,
            'cpf': _cpf,
            'phone': _phone,
            'type': _type
          });
        }

        Navigator.pushNamed(context, 'patients');
      } catch (e) {
        print('Erro ao tentar salvar novo usuário. ${e}');
      }
    }
  }

  void getUser() async {
    var fireStore = Firestore.instance;
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    QuerySnapshot qn;
    if (args.userId.isNotEmpty) {
      qn = await (fireStore
          .collection("usuarios")
          .where("id", isEqualTo: args.userId)
          .getDocuments());
    }

    _name = qn.documents[0].data['name'];
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
      drawer: SideDraw(),
      backgroundColor: Colors.websafe,
      appBar: AppBar(
        title: Text("Novo Paciente"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.websafe,
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: 250.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        // Foto de perfil
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xff7c94b6),
                                      image: new DecorationImage(
                                        image: new ExactAssetImage(
                                            'assets/profilepic.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 90.0, right: 100.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 25.0,
                                      child: new Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )),
                          ]),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                left: 25.0,
                                right: 25.0,
                              ),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Informações Pessoais',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[],
                                  )
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Nome',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: "",
                                      ),
                                      validator: (value) => value.isEmpty
                                          ? 'Nome can\'t be empty'
                                          : null,
                                      onSaved: (value) => _name = value,
                                      initialValue: _name,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'CPF',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextFormField(
                                      decoration:
                                          const InputDecoration(hintText: ""),
                                      validator: (value) => value.isEmpty
                                          ? 'CPF can\'t be empty'
                                          : null,
                                      onSaved: (value) => _cpf = value,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Email',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextFormField(
                                      decoration:
                                          const InputDecoration(hintText: ""),
                                      validator: (value) => value.isEmpty
                                          ? 'Email can\'t be empty'
                                          : null,
                                      onSaved: (value) => _email = value,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Telefone',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextFormField(
                                      decoration:
                                          const InputDecoration(hintText: ""),
                                      validator: (value) => value.isEmpty
                                          ? 'Phone can\'t be empty'
                                          : null,
                                      onSaved: (value) => _phone = value,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25.0,
                                right: 25.0,
                                top: 25.0,
                                bottom: 25.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new RaisedButton(
                                      splashColor: Colors.red[200],
                                      color: Colors.websafeRed,
                                      padding: EdgeInsets.all(12.0),
                                      shape: StadiumBorder(),
                                      child: new Text('Salvar',
                                          style: new TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white)),
                                      onPressed: () {
                                        createUser();
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
