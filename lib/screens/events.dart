import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organizer/components/side_menu.dart';
import 'package:organizer/tabs/draft_events.dart';
import 'package:organizer/tabs/live_events.dart';
import 'package:organizer/tabs/past_events.dart';
import 'package:rive/rive.dart';

import 'add_event.dart';

//our event page (main page):
/*
    1. it has the scaffold which has app bar
      our app bar has: title : Events
      it also has a search icon on the top
      and has this options (3 lines) on the left   //to be done later

      //we will need a body that has column widget consisting of 2 parts
    2. it has a row widget above that includes past live and draft events    ==> this will be gesture detectors and then we would need listtitles for each of the 3 
       when each is pressed it opens anew widget that has the events

       //floating action points:
    3. we have an csv export icon at the bottom left
    4. we have a + icon to add a new event at bottom right
*/

//it is stateful widget as it will be interactive

//for rive:
//const riveFile = 'assets/loading.riv';

class EventPage extends StatefulWidget {
  //we will remove the const keyword from here as it will change
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  //my variables:
  //int selectedGestureDetector = -1;
  // Artboard? _artboard;
  // RiveAnimationController? _animationController;
  // @override
  // void initState() {
  //   _loadRiveFile();
  //   super.initState();
  // }

//functions":
  exportToCsv() {}

  // void _loadRiveFile() async {
  //   final bytes = await rootBundle.load(riveFile);
  //   RiveFile rFile = RiveFile.import(bytes);
  // }

  //start of build widget:
  @override
  Widget build(BuildContext context) {
    //since we need a tab bar we will wrap pur scaffold with it
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        //our app bar:  it contains title and 2 icons

        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(Icons.menu),
          //   onPressed: () {
          //     //will open side menu    //this will be done in another file
          //     SideMenu();
          //   },
          // ),
          title: Text(
            'Events',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ), //our title
          backgroundColor: Color.fromARGB(255, 13, 5, 37),
          actions: [
            IconButton(
              onPressed: () {}, //navigate to search page
              icon: Icon(Icons.search),
            )
          ],
        ),
        //drawer:  for the sidemenu
        drawer: SideMenu(),
        //our body:

        body: Column(
          children: [
            TabBar(tabs: [
              Tab(
                child: Text(
                  'Live',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(
                        236, 77, 77, 77), // set the text color here
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Past',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(
                        236, 77, 77, 77), // set the text color here
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Draft',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(
                        236, 77, 77, 77), // set the text color here
                  ),
                ),
              )
            ]),

            //we need a tab bar view for the content of our 3 tabs:
            Expanded(
              child: TabBarView(children: [
                //1st tab:
                LiveEventsTab(),

                //2nd tab:
                PastEventsTab(),

                //3rd tab:
                DraftEventsTab(),
              ]),
            )
          ],
        ),

        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    //a function to export to csv

                    // exportToCsv();
                  },
                  tooltip: 'Export to CSV',
                  child: Icon(Icons.file_download),
                  backgroundColor: Color.fromARGB(233, 255, 153, 0)),
              FloatingActionButton(
                heroTag: 'eventPage',
                onPressed: () {
                  // goo to basic info page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddEvents()),
                  );
                },
                child: Icon(Icons.add),
                backgroundColor: Color.fromARGB(233, 255, 153, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
