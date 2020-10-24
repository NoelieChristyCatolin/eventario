import 'package:eventario/models/event_view_model.dart';
import 'package:flutter/material.dart';

class Event {
  DateTime date;
  String eventName;
  String startTime;
  String endTime;
  bool isAllDay;
  MaterialColor color;

  Event({this.date,this.eventName, this.startTime, this.endTime, this.color, this.isAllDay = false});

  Map<String,dynamic> toMap(){

  }

}