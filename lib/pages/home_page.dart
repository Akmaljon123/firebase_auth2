import 'dart:developer';

import 'package:firebase_auth2/my_app/setup.dart';
import 'package:firebase_auth2/services/path_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  Future<void> getData() async {
    isLoading = true;
    setState(() {});
    await PathService.getData();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 28),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),

            isLoading
                ? const CircularProgressIndicator()
                : Text(
                userList[0].name
            ),


            TextButton(
              onPressed: () => throw Exception("Bu G10 uchun test"),
              child: const Text("Throw Test Exception"),
            ),

            const SizedBox(height: 10),

            MaterialButton(
              onPressed: (){
                showAboutDialog(
                    context: context,
                  children: [
                    SingleChildScrollView(
                      child: ListView.builder(
                          itemBuilder: (context, index){
                            return GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: const Text("Back"),
                            );
                          }
                      ),
                    )
                  ]
                );
              },
              minWidth: 80,
              height: 50,
              shape: const StadiumBorder(),
              child: const Text("Throw Exception"),
            ),

            const SizedBox(height: 10),

            MaterialButton(
              onPressed: (){

                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Container(
                          height: MediaQuery.of(context).size.height*1.1,
                          width: double.infinity,
                          color: Colors.red,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  String? str;
                                  log(str!.length.toString());
                                },
                                child: const Text('Trigger Null Pointer Exception'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                );
              },
              minWidth: 80,
              height: 50,
              shape: const StadiumBorder(),
              child: const Text("Throw Container Exception"),
            )
          ],
        ),
      ),
    );
  }
}
