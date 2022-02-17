import 'package:flutter/foundation.dart';
  
  class Item {
  String title ;
    String task ;
    bool task_done = false;
    DateTime datetime ;
  Item(this.title,this.task,this.datetime);
}

class ListProvider with ChangeNotifier {
  List<Item> list = [];

   addItem(String title,String task,DateTime datetime )  async {
     Item item = Item(title,task,datetime);
    list.add(item);
    notifyListeners();
  }

void deleteItem(int index) {
    list.removeAt(index);
    notifyListeners();
  }
}