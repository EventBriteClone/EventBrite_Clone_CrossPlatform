import 'package:flutter/material.dart';

import '../../reusable_widgets/neu.dart';

class DependentDropdownMenu extends StatefulWidget {
  @override
  _DependentDropdownMenuState createState() => _DependentDropdownMenuState();
}

class _DependentDropdownMenuState extends State<DependentDropdownMenu> {
  String _dropdownValue = 'Public';
  bool _showCheckbox = false;
  bool _switchValue = false;
  bool _checkboxValue=false;
  bool _switchValue2 = false;
  DateTime? _selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(backgroundColor: Colors.white,
      shadowColor: Colors.grey,
      iconTheme: IconThemeData(color: Colors.black,size: 27),
        title: Text('Settings',style: TextStyle(
              fontSize: 27,fontFamily: 'Neue Plak',
              color: Color.fromRGBO(60, 0, 100, 1),//fontWeight: FontWeight.w900,
            )),),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:const EdgeInsets.only(left:15.0,top:15.0),
                child: DropdownButton<String>(
                  value: _dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      _dropdownValue = newValue!;
                      if (_dropdownValue == 'Private') {
                        _showCheckbox = true;
                      } else {
                        _showCheckbox = false;
                      }
                    });
                  },
                  items: <String>['Public', 'Private'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 5),
              _dropdownValue == 'Public'
                  ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:20),
                        child: Text('This event will be listed on eventus and in search engines'),
                      ),
                      Divider(),
                      SizedBox(height: 20,),
                    Center(
                      child: NeumorphicButton(
                      onPressed: () {},
                      child: Center(child: Text('Publish',style: TextStyle(color:Color.fromRGBO(60, 0, 100, 1),fontSize: 19,
                      fontWeight: FontWeight.w900),)),
                      ),
                    )

                    ],
                  )
                  
                  : Column(
                      children: [
                        Text('This event will not be listed on Eventus or in search engines'),
                        Divider(),
                        CheckboxListTile(
                          title: Text('Guests must receive an Eventus invitation to register'),
                          value: _checkboxValue,
                          activeColor: Color.fromRGBO(60, 0, 100, 1) ,
                          onChanged: (newValue) {
                            setState(() {
                              _checkboxValue = newValue!;
                            });
                          },
                        ),
                        Divider(),
                        SwitchListTile(
                          title: Text('Guests must enter password to register'),
                          value: _switchValue,
                          activeColor: Color.fromRGBO(60, 0, 100, 1),
                          onChanged: (newValue) {
                            setState(() {
                              _switchValue = newValue;
                            });
                          },
                          
                        ),
                        
              SizedBox(height: 10),
              _switchValue
                  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                  )
                  : SizedBox(),
                  Divider(),
                  SwitchListTile(
                  title: Text('Make the Event public after a certain date'),
                   activeColor: Color.fromRGBO(60, 0, 100, 1),
                  value: _switchValue2,
                  onChanged: (bool newValue) {
                    setState(() {
                      _switchValue2 = newValue;
                    });
                  },
                ),
                if (_switchValue2)
                  ElevatedButton(
                    style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(60, 0, 100, 1)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  ),
                    onPressed: () {
                      _selectDateTime(context);
                    },
                    child: Text(_selectedDateTime != null
                        ? 'Selected Date Time: $_selectedDateTime'
                        : 'Select Date Time'),
                  ),
                  Divider(),
                  SizedBox(height: 20,),
                  NeumorphicButton(
  onPressed: () {},
  child: Center(child: Text('Publish',style: TextStyle(color:Color.fromRGBO(60, 0, 100, 1),fontSize: 19,
                    fontWeight: FontWeight.w900),)),
)

                      ],
                    ),
            ],
          ),
        ],
      ),
    );
    
  }
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      final TimeOfDay? timePicked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (timePicked != null) {
        setState(() {
          _selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            timePicked.hour,
            timePicked.minute,
          );
        });
      }
    }
  }

}







