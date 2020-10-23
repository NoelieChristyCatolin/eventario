import 'package:flutter/material.dart';
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
        print(newEvent.eventName);
        print(newEvent.startTime);
        print(newEvent.endTime);
        print(newEvent.isAllDay);
        print(newEvent.color);
        notifyListeners();
  }


}