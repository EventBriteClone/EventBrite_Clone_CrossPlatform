import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../constants.dart';
import '../../reusable_widgets/creator_custom_button.dart';

class CounterList extends StatefulWidget {
  final Map<int,String> TicketMap;
  CounterList({required this.TicketMap});
  
  @override
  _CounterListState createState() => _CounterListState();
}

class _CounterListState extends State<CounterList> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  List<int> counters = [0];
  
  String? selectedOption;
  int? numOfTickets;
  bool _isLoading = false;
  String _errorMessage = '';
 int findIdByTicketType( String ticketType) {
  Map<int, String> ticketMap=widget.TicketMap;
  for (MapEntry<int, String> entry in ticketMap.entries) {
    if (entry.value == ticketType) {
      return entry.key;
    }
  }
  return -1; // Return -1 if the ticket type is not found
} 
 void AddAttendee( String FirstName, String LastName, String EmailAddress,int numberOfTickets,String? TicketType) async {
     setState(() {
_isLoading = true;
      _errorMessage = '';
    });
    
    //try{
      //email='joe@gmail.com';
      int id = await  findIdByTicketType(TicketType!);
 print('email');    
 print(EmailAddress);
 print('first');
 print(FirstName+LastName);
 print('number');
 print(numberOfTickets);
 print('type');
 print(TicketType);
print ('id');
print(id);
//Future<void> publish(int id, bool abas, String isPrivate) async {
  final url = 'https://event-us.me:8000/eventmanagement/8244/add-attendee/';
  //final headers = {'Content-Type': 'application/json'};

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'CustomToken 65e1180796caf66355282edfae231cf52353ee8591a6efa8aa98d6ef76856a0c'


  };
  final body = 
 {
            
            "order_items":
            [
                {
                "ticket_class_id" : id,	
                "quantity": numberOfTickets
                }
            ], 
            //"promocode" : "sasfsf", // optional
            "first_name" : FirstName,
            "last_name" : LastName,
            "email" : EmailAddress
};
    
  
  final response = await post(Uri.parse(url), headers: headers, body: jsonEncode(body));



      if(response.statusCode == 201){
        
        //var data = jsonDecode(response.body.toString());
        //print("token"+data['token']);
        print('booked successfully');
       setState(() {
      _isLoading = false;
      _errorMessage = '';
    });
      
      }else {
        print('failed');
               setState(() {
      _isLoading = false;
      _errorMessage = '';
    });
      }
    // }catch(e){
    //   print('ypussef');
    //   print(e.toString());
    // }
  }

  void incrementCounter(int index) {
    setState(() {
      counters[index] += 1;
    });
  }

  void decrementCounter(int index) {
    setState(() {
      if (counters[index] > 0) {
        counters[index] -= 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        iconTheme: IconThemeData(color: Colors.black, size: 27),
        title: Text(
          'Manage attendee',
          style: TextStyle(
            fontSize: 27,
            fontFamily: 'Neue_Plak',
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.all(9.0),
                child: TextField(
                  key:const ValueKey("firstname for manage attendee"),
                  controller: firstNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Add Attendee First Name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(9.0),
                child: TextField(
                  key:const ValueKey("lastname for manage attendee"),
                  controller: lastNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Add Attendee Last Name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(9.0),
                child: TextField(
                  key:const ValueKey("email for manage attendee"),
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Add Attendee Email Address',
                  ),
                ),
              ),
              Divider(),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: counters.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Number of tickets for the attendee: ${counters[index]}'),
                    trailing: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () => decrementCounter(index),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => incrementCounter(index),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Ticket Type'),

                  DropdownButton<String>(
                    key:const ValueKey("dropdown for manage attendee"),
                    value: selectedOption,
                    hint: Text('Select an option'),
                    onChanged: (newValue) {
                      setState(() {
                        
                        selectedOption = newValue;
                      });
                    },
                    items: widget.TicketMap.values.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
              
                  padding: const EdgeInsets.all(8.0),
                  child: CreatorCustomButton(
                    key:const ValueKey("button in manage attendee page 2"),
                     onTap: _isLoading? (){ //:() {
          null;
          // Do something when the button is pressed
        
        }:(){
                   String firstName = firstNameController.text;
                String lastName = lastNameController.text;
                String email = emailController.text;
                int numberOfTickets = counters.reduce((value, element) => value + element);
                String? ticketType = selectedOption;
                AddAttendee(firstName, lastName, email, numberOfTickets, ticketType.toString());
                      
        },
      
                    
              child: _isLoading
                            ? SizedBox(
                              width: 10,
                              child: Center(
                                child: CircularProgressIndicator(strokeWidth: 2,
                                color:primaryColor,),
                              ))
                            : Center(child: Text('Add Attendee',style: TextStyle(color: primaryColor,fontSize: 20,fontWeight:FontWeight.bold),))
                  ),
                ),
              ],
                        ),
            ],
          ),
        ),
      ),
    );
  }
}


