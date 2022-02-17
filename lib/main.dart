import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/list_provider.dart';

import 'bottom_bar.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();

  runApp(GetMaterialApp(
    
   home: ChangeNotifierProvider<ListProvider>(
          create: (context) => ListProvider(), child: BouttomBar()),debugShowCheckedModeBanner: false,
  ));
}
