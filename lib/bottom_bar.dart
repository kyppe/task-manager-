import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/main.dart';
import 'package:task_manager_app/task_page.dart';

import 'componnets.dart';

import 'calendar.dart';
import 'list_provider.dart';

class BouttomBar extends StatelessWidget {
  const BouttomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: BouttomBarView());
  }
}


class BouttomBarView extends StatefulWidget {
  const BouttomBarView({Key? key}) : super(key: key);

  @override
  _BouttomBarState createState() => _BouttomBarState();
}

class _BouttomBarState extends State<BouttomBarView> {
late GlobalKey<FormState> _formKey;
  late TextEditingController _controller;
  var taskItems;

  int counter = 0;

  String time ="?";
  var comp = Componnets();
   late DateTime _myDateTime ;
     @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _formKey = GlobalKey();
    
    _controller = TextEditingController();
    taskItems = Provider.of<ListProvider>(context, listen: false);
   
  }
   @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
    
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController taskcontroller = TextEditingController();
  
  int currentTab = 1; // to keep track of active tab index
  final List<Widget> screens = [
    CalendarPage(),
     TaskPage()
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = CalendarPage();

  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.defaultDialog(
              title: 'ADD TASK',
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  comp.textInput(titlecontroller, 'task', false),
                  const SizedBox(
                    height: 30.0,
                  ),
                  comp.textInput(taskcontroller, 'what to do ', false),
                  const SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        _myDateTime = (await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2015),
                          lastDate: DateTime(2025),
                        ))!;
                        time = _myDateTime.toString();
                      },
                      
                      child: const Text(
                        'chose  date  ',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      )),
                  ElevatedButton(
                    ///////////////////////////////////////////////////////////////////
                      onPressed: () async {
                        if (titlecontroller.text.isEmpty) {
                                return;
                                  }
                 
                
                          await Provider.of<ListProvider>(context, listen: false)
                            .addItem(titlecontroller.text,taskcontroller.text,_myDateTime);
                                   
                        Navigator.pop(context);
 },
                      
                      ///////////////////////////////////////////////////////
                      child: const Text(
                        'add task',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ))
                ],
              ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 50,
          width: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 80,
                    onPressed: () {
                      setState(() {
                        currentScreen = TaskPage();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.add_task,
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                          size: 30,
                        ),
                        Text(
                          'task',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

       

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                      child: MaterialButton(
                    minWidth: 0,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            CalendarPage(); 
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today_outlined,
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'calendar',
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
