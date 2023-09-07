import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Todo : In this example if some how data class is not created by plugin then we can hit api like this
class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  var data;

  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                      itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          children: [
                            ReusableRow(title: "Name : ", value: data[index]["name"].toString()),
                            ReusableRow(title: "Username : ", value: data[index]["username"].toString()),
                            ReusableRow(title: "Email : ", value: data[index]["email"].toString()),
                            ReusableRow(title: "Address : ", value: data[index]["address"]["street"].toString()),
                            ReusableRow(title: "Geo : ", value: data[index]["address"]["geo"]["lat"].toString()),
                          ],
                        ),
                      ),
                    );
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  ReusableRow({super.key, required this.title, required this.value});

  String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(value)],
      ),
    );
  }
}