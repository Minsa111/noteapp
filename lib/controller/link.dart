
import 'package:get/get.dart';
import 'package:noteapp/views/home.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/views/edit.dart';
class editbutton extends StatefulWidget {
  const editbutton({super.key});

  @override
  State<editbutton> createState() => _editbuttonState();
}

class _editbuttonState extends State<editbutton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

FloatingActionButton editButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () =>Get.toNamed('/edit'),
    elevation: 5,
    backgroundColor: Colors.grey.shade800,
    child: const Icon(
      Icons.add,
      size: 38,
    ),
  );
}

  
FloatingActionButton checkButton() {
  return FloatingActionButton(
    onPressed: () {},
    elevation: 8,
    backgroundColor: Colors.transparent,
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Icon(Icons.check),
    ),
  );
}


FloatingActionButton backHome(BuildContext context) {
  return FloatingActionButton(
    onPressed: ()=>Get.back(),
    elevation: 8, // Add elevation here
    backgroundColor: Colors.transparent,
    child: Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: Colors.grey.shade800,
    ),
    child: Icon(
      Icons.arrow_back_ios_new,
      color: Colors.white,
    ),
    )
  );
}



