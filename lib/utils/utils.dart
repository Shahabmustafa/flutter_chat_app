import 'package:flutter/material.dart';


extension Double on num{
  SizedBox get ph => SizedBox(height: toDouble(),);
  SizedBox get pw => SizedBox(width: toDouble(),);
}

