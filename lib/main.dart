import 'package:flutter/material.dart';
import 'package:umed_v2/app/screens/login/login-widget.dart';
import 'package:umed_v2/app/screens/home/home-widget.dart';
import 'package:umed_v2/app/screens/medicalRecords/medicalRecords-widget.dart';
import 'package:umed_v2/app/screens/patients/patients-widget.dart';
import 'package:umed_v2/app/screens/newpatient/newpatient-widget.dart';

void main() {
  runApp(MaterialApp(
    title: "UMed",
    home: LoginScreen(),
    routes: {
      'login': (context) => LoginScreen(),
      'home': (context) => HomeScreen(),
      'medicalrecords': (context) => MedicalRecords(),
      'patients': (context) => PatientsScreen(),
      'newpatient': (context) => NewPatientScreen(),
    },
  ));
}
