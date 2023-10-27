import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/models/note.dart';
import 'package:noteapp/constants/colors.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget>
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

getRandomColor(){
  Random random = Random();
  return backgroundColors[random.nextInt(backgroundColors.length)];
}

Card cardDesign(int index) {
    return Card(
                margin: EdgeInsets.only(bottom: 20),
                color: getRandomColor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: RichText(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text:'${sampleNotes[index].title} \n',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          height: 1.5
                        ),
                        children: [
                          TextSpan(
                            text: '${sampleNotes[index].content}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              height: 1.5
                            )
                          )
                        ],
                      )
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Text('${DateFormat('EEE MMM d, yyyy h:mm a').format(sampleNotes[index].modifiedTime)}',
                        style: TextStyle(
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey.shade800
                        ),
                      ),
                    ),
                    trailing: IconButton(onPressed: (){
                
                    },icon: const Icon(
                        Icons.heart_broken
                      ),
                    ),
                  ),
                ),
              );
}