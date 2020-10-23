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
            child:ListView.builder( // outer ListView
              itemCount: eventViewModelListener.count,
              itemBuilder: (_, index) {
                var event = eventViewModelListener.list[index];
                return ListTile(
                 leading:  Column(
                   children: [
                     Text("${event.date.weekday}"),
                     Text("${event.date.day}"),
                   ],
                 ),
                  title: ListView.builder( // inner ListView
                    shrinkWrap: true, // 1st add
                    physics: ClampingScrollPhysics(), // 2nd add
                    itemCount: eventViewModelListener.count,
                    itemBuilder: (_, index) => ListTile(title: Text(event.eventName), subtitle: Text("${event.startTime} - ${event.endTime}")),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

}
