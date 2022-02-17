import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';

import 'componnets.dart';
import 'list_provider.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late TextEditingController _controller;
    TextEditingController titlecontroller = TextEditingController();
  TextEditingController taskcontroller = TextEditingController();
  var comp = Componnets();
  var taskItems;
  int counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = TextEditingController();
    taskItems = Provider.of<ListProvider>(context, listen: false);
   
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text(' Tasks '),
      ),
      
      body: Container(

        child: Column(
          children: <Widget>[
            Expanded(
              child: Consumer<ListProvider>(
                builder: (context, itemAddNotifier, _) {
                  itemAddNotifier.list.sort((a,b)=> a.datetime.compareTo(b.datetime));
                  return 
               
                  ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: itemAddNotifier.list.length,
                    separatorBuilder: (BuildContext context, int index) => Container(height: 8,),
                    itemBuilder: (context, index) {

                      return Slidable(
                    actionPane:  const SlidableScrollActionPane(),
                     actions:   [
                          IconSlideAction(
                         
                            caption: 'delete',
                            color: Colors.red,
                            icon: Icons.delete,
                          onTap: (){
                            Provider.of<ListProvider>(context, listen: false)
                            .deleteItem(index);
                          },
                         
                          )
                    ],
                    secondaryActions: [
                      IconSlideAction(
                         
                            caption: 'Edite',
                            color: Colors.green,
                            icon: Icons.edit,
                          onTap: (){
                               titlecontroller.text = itemAddNotifier.list[index].title;
                          taskcontroller.text =itemAddNotifier.list[index].task; 
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
                        itemAddNotifier.list[index].datetime = (await showDatePicker(
                          context: context,
                          initialDate: itemAddNotifier.list[index].datetime,
                          firstDate: DateTime(2015),
                          lastDate: DateTime(2025),
                        ))!;
                  
                      }, child: const Text("edite your date " ,style: TextStyle(color: Colors.white, fontSize: 18.0),),),
                   ElevatedButton(
                      onPressed: ()
                      {
                         if (titlecontroller.text.isEmpty) {
                                return;
                                  }
                          itemAddNotifier.list[index].title=titlecontroller.text ;
                          itemAddNotifier.list[index].task=taskcontroller.text ;
                          setState(() {});
                         Navigator.pop(context);

                      },child: const Text("submit " ,style: TextStyle(color: Colors.white, fontSize: 18.0),),)
                                
                ]
              )
                           );
                      
                  }
                      )
                    ],
                   child: 
              
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                          checkColor: Colors.white,
                           value: itemAddNotifier.list[index].task_done
                          ,onChanged: (value){
                            setState(() {
                              itemAddNotifier.list[index].task_done =!itemAddNotifier.list[index].task_done;
                            });
                          },
                          activeColor: Colors.green,

                              ),
                              Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                children :[
                                  
                          Text (
                          itemAddNotifier.list[index].title 
                          ,
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                        
                       ),
                        ),
                        Text(itemAddNotifier.list[index].task)
                          ]
                        )
                          ] 
                      )
                    ),);
                  }, 
                );
                
              
                  
                  
                  
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 