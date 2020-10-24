import 'package:eventario/models/event_view_model.dart';
import 'package:flutter/material.dart';
import 'add_event.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  static String id = 'home';
  int lastyear = DateTime.now().year + 10;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
//    var eventViewModel = Provider.of<EventViewModel>(context, listen: false);
    var eventViewModelListener = Provider.of<EventViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Eventario"),
      ),
      body: Column(
        children: [
          Container(
            child: CalendarDatePicker(
              initialDate: selectedDate,
              firstDate: DateTime.now(),
              lastDate:  DateTime(lastyear),
              onDateChanged: (DateTime value) {
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                     return AddEvent(date: value,);
                    }
                );
              },),
          ),
          Expanded(
            child: ListView.builder( // outer ListView
              itemCount: eventViewModelListener.filterEvents.length,
              itemBuilder: (_, index) {
                var day = eventViewModelListener.filterEvents[index].date;
                var events = eventViewModelListener.filterEvents[index].events;
                return ListTile(
                 leading: Column(
                   children: [
                     Text("${_convertWeekdayToString(day.weekday)}"),
                     Text(
                       "${day.day}",
                       style: TextStyle(fontSize: 19),
                     ),
                   ],
                 ),
                  title: ListView.builder( // inner ListView
                    shrinkWrap: true, // 1st add
                    physics: ClampingScrollPhysics(), // 2nd add
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(width: 1, color: events[index].color),
                          ),
                          child: ListTile(
                              title: Text(
                                events[index].eventName,
                                style: TextStyle(color:  events[index].color),
                              ),
                              subtitle: Text(
                                events[index].isAllDay ? "All Day" : "${events[index].startTime} - ${events[index].endTime}",
                                style: TextStyle(color:  events[index].color),
                              ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  _convertWeekdayToString(int weekday){
    switch(weekday){
      case 1:
        return 'MON';
      case 2:
        return 'TUE';
      case 3:
        return 'WED';
      case 4:
        return 'THU';
      case 5:
        return 'FRI';
      case 6:
        return 'SAT';
      case 7:
        return 'SUN';
    }


  }

}
