import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int textFieldCount = 0;
  int numbersOfTicketsCount = 0;

  void addTextField() {
    setState(() {
      textFieldCount += 1;
    });
  }

  void addTicketType() {
    setState(() {
      numbersOfTicketsCount += 1;
    });
  }

  void removeTicketType() {
    setState(() {
      numbersOfTicketsCount -= 1;
    });
  }

  void removeTextField() {
    if (textFieldCount > 0) {
      setState(() {
        textFieldCount -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Page')),
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        child: Column(
          children: [
                    Text('Number of attendee for ticket type $numbersOfTicketsCount: $textFieldCount'),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: addTicketType,
                  child: Text('Add Ticket type'),
                ),
                ElevatedButton(
                  onPressed: removeTicketType,
                  child: Text('Remove ticket type'),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Disable scrolling for this ListView
              itemCount: numbersOfTicketsCount,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: addTextField,
                          child: Text('Add attendee'),
                        ),
                        ElevatedButton(
                          onPressed: removeTextField,
                          child: Text('Remove attendee'),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(), // Disable scrolling for this ListView
                      itemCount: textFieldCount,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'FirstName ${index + 1}',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'LastName ${index + 1}',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email Address ${index + 1}',
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              
                            ],
                          ),
                        );
                      },
                    ),
                  
                  SizedBox(height: 20,)
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
