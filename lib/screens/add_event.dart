import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eventario/models/event_view_model.dart';
import 'package:eventario/models/event.dart';
import 'package:eventario/components/colorTile.dart';

class AddEvent extends StatefulWidget {
  final DateTime date;

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
  Event _newEvent = Event();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var eventViewModel = Provider.of<EventViewModel>(context, listen: false);
    return AlertDialog(
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();

              _newEvent.date = widget.date;
              eventViewModel.saveEvent(_newEvent);
              Navigator.pop(context);
            }
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
            key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_formatEventDate(widget.date)),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Event Name'),
                    validator: _isNotNull,
                    onSaved: (value){
                        _newEvent.eventName = value;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: startTimeTextController,
                          decoration: InputDecoration(labelText: 'Start Time'),
                          onTap: () => _selectTime(startTimeTextController),
                          validator: _isNotNull,
                          onSaved: (value){
                            _newEvent.startTime = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(' - '),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: endTimeTextController,
                          decoration: InputDecoration(labelText: 'End Time'),
                          onTap: () => _selectTime(endTimeTextController),
                          validator: _isNotNull,
                          onSaved: (value){
                            _newEvent.endTime = value;
                          }
                        ),
                      ),
                    ],
                  ),
                  CheckboxListTile(
                    title: Text("All Day"),
                    value: _newEvent.isAllDay,
                    onChanged: (value){
                      setState(() {
                        _newEvent.isAllDay = value;
                      });
                    },
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      ColorTile(
                        color: Colors.red,
                        onTap: (){
                          _newEvent.color = Colors.red;
                        }
                      ),
                      ColorTile(
                          color: Colors.blue,
                          onTap: (){
                            _newEvent.color = Colors.blue;
                          }
                      ),
                      ColorTile(
                          color: Colors.purple,
                          onTap: (){
                            _newEvent.color = Colors.purple;
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

  _formatEventDate(DateTime date){
    return "${date.month}/${date.day}/${date.year}";
  }

  String _isNotNull(String value) {
    print("value.length ${value.length} ");
    if (value.length == 0) {
      print("zero");
      return 'Field Required';
    }
    print("value");
    return null;
  }
}
