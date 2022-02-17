import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:table_calendar/table_calendar.dart';

import 'list_provider.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late GlobalKey<FormState> _formKey;
  var taskItems;
  CalendarFormat format = CalendarFormat.month;
  List<Item> list = [];
  List<Item> listSelected = [];
  int count = 0 ;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  late Map<DateTime, List<Item>> selectedEvents;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    selectedEvents = {};
    super.initState();

    _formKey = GlobalKey();
    taskItems = Provider.of<ListProvider>(context, listen: false);
  }

  List<Item> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            eventLoader: _getEventsfromDay,
            focusedDay: selectedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,

            //Day Changed
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
              print(focusedDay);
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },

            //To style the Calendar
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Consumer<ListProvider>(
              builder: (context, itemAddNotifier, _) {
              listSelected = copylist(focusedDay,itemAddNotifier.list);
                return ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: listSelected.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Container(
                          height: 8,
                        ),
                    itemBuilder: (context, index) {
                      if (listSelected.isEmpty==false)
                      {
{                        return Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                
                                    Checkbox(
                                      checkColor: Colors.white,
                                      value:
                                         listSelected[index].task_done,
                                      onChanged: (value) {
                                        setState(() {
                                          listSelected[index].task_done =
                                              listSelected[index].task_done;
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                         listSelected[index].title,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(listSelected[index].task)
                                      ])
                                ]));
                      } 
                      }
                    
                        return const Text("there is no task ");
                      
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}

List<Item>  copylist(DateTime datetime, List<Item> list)
{
   List<Item> listSelected =[];
   int count = 0 ;
  for(int index=0 ;index<list.length;index++ )
  {
      if (list[index].datetime.day ==datetime.day && list[index].datetime.year == datetime.year && list[index].datetime.month ==datetime.month)
       {
         listSelected.add(list[index]);
         
         count ++ ;
       }
  }
  
  return listSelected;
  
}