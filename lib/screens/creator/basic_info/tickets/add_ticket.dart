import 'package:event_brite_app/components/tabs/promo_codes.dart';
import 'package:event_brite_app/models/basic_info_form.dart';
import 'package:event_brite_app/screens/creator/basic_info/tickets/tickets_info_input.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../components/inside_side_menu.dart';

import '../../../../components/tabs/admissions.dart';
import '../../../../functions/services/get_tickets.dart';
import '../../../../models/tickets_model.dart';
import '../../../../providers/creator/basic_info_provider.dart';
import '../../../../reusable_widgets/NoComponentWidget.dart';
import '../../../../reusable_widgets/app_bar.dart';
import '../../../../reusable_widgets/image_widget.dart';

class Tickets extends StatefulWidget {
  const Tickets({Key? key});

  @override
  State<Tickets> createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  // TicketsModel ticketdata;

  //bool? noTickets = true;

  //0 free 1 paid
  int _selectedIndex = 0;
  bool _isBottomNavBarVisible = false;
  bool _isFloatingButtonPressed = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTickets(par: 0)),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTickets(par: 1)),
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
             child: buildDrawer(context),
            ),
        appBar: const AppBarWidget(
          appBarText: 'Tickets',
        ),
        body: FutureBuilder<List<TicketsModel>>(
          //future: AllTicketsServices().getAllTickets(context),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error fetching draft events'));
            }
            final ticketList = snapshot.data ?? [];
            final noTickets = ticketList.isEmpty;
            return noTickets
                ? const NoComponentWidget(
                    displayText:
                        'You don\'t have any tickest yet. Start\n adding now.',
                    icon: Icons.confirmation_num_outlined)
                : DefaultTabController(
                    length: 2,
                    child: Column(children: const [
                      TabBar(
                        tabs: [
                          Tab(
                            child: Text(
                              'Admissions',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(
                                    236, 77, 77, 77), // set the text color here
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Promo codes',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(
                                    236, 77, 77, 77), // set the text color here
                              ),
                            ),
                          ),
                        ],
                      ),
                      //we need a tab bar view for the content of our 3 tabs:
                      Expanded(
                        child: TabBarView(children: [
                          //1st tab:
                          AdmissionsTab(),

                          //2nd tab:
                          PromoCodesTab(),
                        ]),
                      ),
                    ]),
                  );
          },
        ),
        bottomNavigationBar: _isBottomNavBarVisible
            ? BottomNavigationBar(
                backgroundColor: const Color.fromARGB(255, 210, 78, 42),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.money_off_outlined,
                      color: Colors.white,
                    ),
                    label: 'Free',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.attach_money_outlined,
                      color: Colors.white,
                    ),
                    label: 'Paid',
                  ),
                ],
                currentIndex: _selectedIndex,
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.white,
                selectedFontSize: 18,
                unselectedFontSize: 18,
                onTap: _onItemTapped,
              )
            : null,
        floatingActionButton: _isFloatingButtonPressed
            ? FloatingActionButton(
                onPressed: () {
                  //open up a nav bar below to choose paid or free
                  setState(() {
                    _isBottomNavBarVisible = true;
                    _isFloatingButtonPressed = false;
                  });
                },
                backgroundColor: const Color.fromARGB(255, 210, 78, 42),
                child: const Icon(Icons.add),
              )
            : null);
  }
}




/*

Widget build(BuildContext context) {
    return FutureBuilder<List<EventModel>>(
      future: AllDraftEventsServices().getAllDraftEvents(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching draft events'));
        }
        final eventDraftsList = snapshot.data ?? [];
        final noDrafts = eventDraftsList.isEmpty;
        //print(noDrafts); //false
        return noDrafts!
            ? const NoComponentWidget(
                displayText: 'You don\'t have any draft events',
                icon: Icons.calendar_today)
            : Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView.builder(
                  itemCount: eventDraftsList.length,
                  itemBuilder: (context, index) {
                    final EventModel event = eventDraftsList[index];
                    print(eventDraftsList[index]);
                    // print(event.category);
                    return DraftComponent(event: event);
                  },
                ),
              );
      },
    );
  }

  what I need from u b2a el7agat de:
  1. update field "Status" in an event given event id 
  2. update a given event   ====> its fields b2a "y3ne kaza update request le kol field of events"
  3. get all tickets for a given event (all their details)
  4. update a ticket details for a given event (all their details)  "nfs elkalam kaza update request le kol field of tickets"
  5. el format bta3 el time fl tickets "yb2a zy el format lama gena ne3ml create event"
  6. how do i get the eventid? 3shan lama agy a use it f request
*/