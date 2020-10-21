import 'dart:ffi';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static String id = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int lastyear = DateTime.now().year + 10;
  DateTime selectedDate = DateTime.now();
  var startTimeTextController = TextEditingController();
  var endTimeTextController = TextEditingController();
  var dateTextController = TextEditingController();
//  DateTime startTime;
//  DateTime endTime;

  @override
  Widget build(BuildContext context) {

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
              onDateChanged: (DateTime value) {},),
          ),
          Expanded(
            child:ListView.builder( // outer ListView
              itemCount: 4,
              itemBuilder: (_, index) {
                return ListTile(
                 leading:  Column(
                   children: [
                     Text("THU"),
                     Text("21"),
                   ],
                 ),
                  title: ListView.builder( // inner ListView
                    shrinkWrap: true, // 1st add
                    physics: ClampingScrollPhysics(), // 2nd add
                    itemCount: 5,
                    itemBuilder: (_, index) => ListTile(title: Text('Meeting with Carl'), subtitle: Text("11 AM - 12 PM")),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                actions: <Widget>[
                  FlatButton(
                      onPressed: (){
                        Navigator.pop(context);
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
                            TextField(decoration: InputDecoration(hintText: 'Event')),
                            TextField(
                              controller: dateTextController,
                              decoration: InputDecoration(hintText: 'Date'),
                              onTap: () => _selectDate(dateTextController)
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
                                Expanded(
                                  child: TextField(
                                    controller: endTimeTextController,
                                    decoration: InputDecoration(hintText: 'End'),
                                    onTap: () => _selectTime(endTimeTextController),
                                  ),
                                ),

                              ],
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                title: Text("All Day"),
                                value: false,
                                onChanged: (bool value) {
                                  //todo: setvalue
                                },
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFe0f2f1)
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFe0f2f1)
                                      ),
                                    ),
                                    onTap: (){
                                      print("hey!!");
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ))
                  ],
                ),
              );
            }
          );
        },
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
}
