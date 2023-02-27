import 'package:flutter/material.dart';

class AddBusiness extends StatefulWidget {
  const AddBusiness({super.key});

  @override
  State<AddBusiness> createState() => _AddBusinessState();
}

class _AddBusinessState extends State<AddBusiness> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Positioned(
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage:NetworkImage('https://via.placeholder.com/150'),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 70.0,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(5),
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Divider(height: 50.0, thickness: 1.0, ),

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter business name',
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter the description',
                      ),
                    ),
                    SizedBox(height: 250.0,),
                    ElevatedButton.icon(
                      onPressed: () { },
                      icon: Icon(Icons.arrow_forward),
                      label: Text("Continue"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}