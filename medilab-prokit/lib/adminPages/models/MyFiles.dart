import '../../main.dart';
import '../constants.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final String? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Doctors",
    numOfFiles: sharedPref.getString("doctorsNum"),
    svgSrc: "assets/icons/Documents.svg",
    totalStorage: "",
    color: primaryColor,
    percentage: "35",
  ),
  CloudStorageInfo(
    title: "Patients",
    numOfFiles: sharedPref.getString("patientsNum"),
    svgSrc: "assets/icons/google_drive.svg",
    totalStorage: "",
    color: Color(0xFFFFA113),
    percentage: "100",
  ),
  CloudStorageInfo(
    title: "Services",
    numOfFiles: sharedPref.getString("servicesNum"),
    svgSrc: "assets/icons/one_drive.svg",
    totalStorage: "",
    color: Color(0xFFA4CDFF),
    percentage: "10",
  ),
  CloudStorageInfo(
    title: "Documents",
    numOfFiles: "",
    svgSrc: "assets/icons/drop_box.svg",
    totalStorage: "",
    color: Color(0xFF007EE5),
    percentage: "78",
  ),
];
