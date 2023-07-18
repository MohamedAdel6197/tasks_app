import 'package:flutter/material.dart';

class SheetView extends StatelessWidget {
  const SheetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(15.0),
            )),
        // ignore: prefer_const_constructors
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Task Title",
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Task Date",
                  prefixIcon: Icon(Icons.calendar_month_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Task Time",
                  prefixIcon: Icon(Icons.timelapse_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
