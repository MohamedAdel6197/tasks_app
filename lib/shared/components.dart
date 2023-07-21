import 'package:flutter/material.dart';

Widget taskItemList(Map dataModel) => Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          // ignore: prefer_const_constructors
          CircleAvatar(
            radius: 40.0,
            backgroundColor: Colors.blue,
            // ignore: prefer_const_constructors
            child: Text(
              "${dataModel['timeTask']}",
              // ignore: prefer_const_constructors
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${dataModel['titleTask']}",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 8.0, start: 8.0),
                child: Text(
                  "${dataModel['dateTask']}",
                  style: TextStyle(fontSize: 16.0),
                ),
              )
            ],
          ),
        ],
      ),
    );
