import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eventario/models/event_view_model.dart';
import 'package:eventario/models/event.dart';
import 'package:eventario/components/colorTile.dart';

class AddEvent extends StatefulWidget {
  DateTime date;

  AddEvent({this.date});
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int lastyear = DateTime.now().year + 10;
  DateTime selectedDate = DateTime.now();
  var nameTextController = TextEditingController();
  var startTimeTextController = TextEditingController();
  var endTimeTextController = TextEditingController();
  Colors color;
  Event newEvent = Event();

  @override
  Widget build(BuildContext context) {
    var eventViewModel = Provider.of<EventViewModel>(context, listen: false);
    //todo: use form saved
    return AlertDialog(
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            Navigator.pop(context);
            newEvent.date = widget.date;
            newEvent.startTime = startTimeTextController.value.text;
            newEvent.endTime = endTimeTextController.value.text;
            eventViewModel.saveEvent(newEvent);
          },
          child: Text("SET"),),
      ],
      content: Stack(
        children: [
          Positioned(
            right: -40.0,
            top: -40.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                child: Icon(Icons.close),
                backgroundColor: Colors.red,
              ),
            ),
          ),
          Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_formatEventDate(widget.date)),
                  TextField(
                    decoration: InputDecoration(hintText: 'Event'),
                    onChanged: (value){
                      setState(() {
                        newEvent.eventName = value;
                      });
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: startTimeTextController,
                          decoration: InputDecoration(hintText: 'Start'),
                          onTap: () => _selectTime(startTimeTextController),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(' - '),
                      ),
                      Expanded(
                        child: TextField(
                          controller: endTimeTextController,
                          decoration: InputDecoration(hintText: 'End'),
                          onTap: () => _selectTime(endTimeTextController),
                        ),
                      ),
                    ],
                  ),
                  CheckboxListTile(
                    title: Text("All Day"),
                    value: newEvent.isAllDay,
                    onChanged: (value){
                      setState(() {
                        newEvent.isAllDay = value;
                      });
                    },
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      ColorTile(
                        color: Colors.red,
                        onTap: (){
                          newEvent.color = Colors.red;
                          print(newEvent.color);
                        }
                      ),
                      ColorTile(
                          color: Colors.blue,
                          onTap: (){
                            newEvent.color = Colors.blue;
                            print(newEvent.color);
                          }
                      ),
                      ColorTile(
                          color: Colors.purple,
                          onTap: (){
                            newEvent.color = Colors.purple;
                            print(newEvent.color);
                          }
                      ),
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }

  _selectTime(TextEditingController controller) async {
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );

    if (time!= null) {
      setState(() {
        print(time);
        var selectedTime = "${time.hour} : ${time.minute}";
        controller.value = TextEditingValue(
          text: selectedTime,
          selection: TextSelection.fromPosition(
            TextPosition(offset: selectedTime.length),
          ),
        );
      });
    }
  }

  _selectDate(TextEditingController controller) async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate:  DateTime(lastyear));

    if(date != null){
      setState(() {
        var selectedTime = "${date.month}/${date.day}/${date.year}";
        controller.value = TextEditingValue(
          text: selectedTime,
          selection: TextSelection.fromPosition(
            TextPosition(offset: selectedTime.length),
          ),
        );
      });
    }
  }

  _formatEventDate(DateTime date){
    return "${date.month}/${date.day}/${date.year}";
  }

}
