import 'package:eventario/models/day.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'event.dart';

class EventViewModel extends ChangeNotifier {
  List<Event> _eventList = [];

  int get count {
    return _eventList.length;
  }

  List<Event> get list {
    return _eventList;
  }

  void saveEvent(Event event) {
    Event newEvent = event;
    _eventList.add(newEvent);
    print(newEvent.date);
    print(newEvent.date);
    print(newEvent.startTime);
    print(newEvent.endTime);
    print(newEvent.isAllDay);
    print(newEvent.color);
    notifyListeners();
  }

  List<Day> get filterEvents{
    List<Day> newEventList = [];
    var groupedEvents = groupBy(_eventList, (obj) => (obj as Event).date);
    groupedEvents.forEach((key, value) {
      newEventList.add(Day(date: key, events: value));
    });
    newEventList.sort((a,b)=> a.date.compareTo(b.date));
    return newEventList;
  }

}