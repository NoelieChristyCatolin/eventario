import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static String id = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    int lastyear = DateTime.now().year + 10;
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
                    itemBuilder: (_, index) => Card(child: Text('Item $index')),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime.now(), lastDate:  DateTime.now().add(Duration()));
        },
      ),
    );
  }

}
