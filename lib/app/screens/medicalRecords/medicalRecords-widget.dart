import 'package:flutter/material.dart';
import 'package:umed_v2/app/shared/widgets/sidedraw-widget.dart';
import 'medicalRecords-bloc.dart';

class MedicalRecords extends StatefulWidget {
  @override
  _MedicalRecordsPageState createState() => _MedicalRecordsPageState();
}

class _MedicalRecordsPageState extends State<MedicalRecords> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideDraw(),
        backgroundColor: Colors.websafe,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.websafe,
        ),
        body: new Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Últimos prontuários",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'sans-serif-light'),
            ),
            Container(
              height: 500,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: createCards() + createCards() + createCards(),
                    ),
                  )
                ],
              ),
            ),
          ],
        )));
  }
}

List<Widget> createCards() {
  getAllMedicalRecords();

  return [
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  itemExtent: 275,
                  children: <Widget>[
                    Container(
                      child: InkWell(
                        onTap: () {
                          // function gets executed on a tap
                        },
                        child: Card(
                          elevation: 5.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 170,
                              width: 260,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 60.0, left: 4, top: 2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Jorge Aparecido",
                                      style: TextStyle(
                                          fontSize: 16,
                                          height: 0.9,
                                          letterSpacing: 1.2,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "Status: ",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5)),
                                    Text(
                                      "Estavel mas ainda setindo algumas dores.",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/doctor_icon.png'),
                                  alignment: Alignment.bottomRight,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          margin: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                    Container(
                      child: InkWell(
                        onTap: () {
                          // function gets executed on a tap
                        },
                        child: Card(
                          elevation: 5.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 170,
                              width: 260,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 60.0, left: 4, top: 2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Jorge Aparecido",
                                      style: TextStyle(
                                          fontSize: 16,
                                          height: 0.9,
                                          letterSpacing: 1.2,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "Status: ",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5)),
                                    Text(
                                      "Estavel mas ainda setindo algumas dores.",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/doctor_icon.png'),
                                  alignment: Alignment.bottomRight,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          margin: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ),
  ];
}
