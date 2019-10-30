import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:umed_v2/app/screens/newpatient/newpatient-widget.dart';
import 'package:umed_v2/app/shared/widgets/sidedraw-widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientsScreen extends StatefulWidget {
  @override
  _PatientsScreenPageState createState() => _PatientsScreenPageState();
}

class _PatientsScreenPageState extends State<PatientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDraw(),
      backgroundColor: Colors.websafe,
      appBar: AppBar(
        title: Text("Pacientes"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.websafe,
        actions: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.search,
              size: 30.0,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'newpatient');
            },
            child: Icon(
              Icons.add,
              size: 30.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListPatients(),
    );
  }
}

class ListPatients extends StatefulWidget {
  @override
  _ListPatientsState createState() => _ListPatientsState();
}

class _ListPatientsState extends State<ListPatients> {
  Future getPatients() async {
    var fireStore = Firestore.instance;

    QuerySnapshot qn = await (fireStore
        .collection("usuarios")
        .where("type", isEqualTo: "P")
        .getDocuments());
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getPatients(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Carregando..."),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "newpatient",
                              arguments: ScreenArguments(
                                  snapshot.data[index].data['id']));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data[index].data['name'],
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'CPF: ' + snapshot.data[index].data['cpf'],
                                style: TextStyle(fontSize: 13.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Telefone: ' +
                                    snapshot.data[index].data['phone'],
                                style: TextStyle(fontSize: 13.0),
                              ),
                            ),
                          ],
                        ),
                      )),
                    );
                  });
            }
          }),
    );
  }
}
