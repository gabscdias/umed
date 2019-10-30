import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:umed_v2/app/screens/login/login-widget.dart';

class SideDraw extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static String userId = "";
  static String userName = "";
  static bool setvisibility = true;

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

        userName = qn.documents[0].data["name"];
        userId = qn.documents[0].data["id"];

        if (qn.documents[0].data["type"] == "P" ||
            qn.documents[0].data["type"] == "A") setvisibility = true;
      } catch (e) {
        print("Erro ao recuperar usuário logado.");
      }
    }
  }

  Future logout(var context) async {
    var result = FirebaseAuth.instance.signOut();
    userName = "";
    userId = "";
    Navigator.pushNamed(context, 'login');
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ScreenArgumentsUser args = ModalRoute.of(context).settings.arguments;
    getCurrentUser();
    if (userId != "") {
      if (userName == "" || userName == null) {
        userName = args.user.documents[0].data['name'];
      }

      return Drawer(
        child: Container(
          color: Colors.websafeGrey,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              new Container(
                child: new DrawerHeader(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'profile');
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xff7c94b6),
                            image: DecorationImage(
                              image: ExactAssetImage(''),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          userName,
                          style: TextStyle(
                              color: Colors.websafeGreyPrimary,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  size: 30,
                  color: Colors.websafeGreyPrimary,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(color: Colors.websafeGreyPrimary),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'home');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.websafeGreyPrimary,
                ),
                title: Text(
                  "Perfil",
                  style: TextStyle(color: Colors.websafeGreyPrimary),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'profile');
                },
              ),
              Visibility(
                visible: setvisibility,
                child: ListTile(
                  leading: Icon(
                    Icons.contacts,
                    size: 30,
                    color: Colors.websafeGreyPrimary,
                  ),
                  title: Text(
                    "Pacientes",
                    style: TextStyle(color: Colors.websafeGreyPrimary),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'patients');
                  },
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.library_books,
                  size: 30,
                  color: Colors.websafeGreyPrimary,
                ),
                title: Text(
                  "Prontuários",
                  style: TextStyle(color: Colors.websafeGreyPrimary),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'medicalrecords');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.backspace,
                  size: 30,
                  color: Colors.websafeGreyPrimary,
                ),
                title: Text(
                  "Sair",
                  style: TextStyle(color: Colors.websafeGreyPrimary),
                ),
                onTap: () {
                  logout(context);
                },
              ),
            ],
          ),
        ),
      );
    } else
      return Text("Não encontrado!");
  }
}
