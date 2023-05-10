import 'package:event_brite_app/functions/services/dashboard_requests.dart';
import 'package:event_brite_app/models/event_model.dart';
import 'package:event_brite_app/models/sold_ticket_model.dart';
import 'package:event_brite_app/reusable_widgets/custom_loading_indicator.dart';
import 'package:event_brite_app/screens/event_dashboard_details/event_dashboard_details.dart';
import 'package:event_brite_app/screens/my_orders_in_home_body/my_orders_in_home_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../../providers/token_provider.dart';
import '../../../reusable_widgets/app_bar.dart';
import '../../../reusable_widgets/event_item.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<List<EventModel>>? cretorEvents;
  @override
  // void initState() {
  //   super.initState();
  //   cretorEvents = Dashboard().getCreatorEvents();
  // }

  @override
  Widget build(BuildContext context) {
    String? token = Provider.of<TokenModel>(context).token;
    return Scaffold(
        appBar: const AppBarWidget(
          appBarText: 'Dashboard',
        ),
        body: FutureBuilder(
            future: Dashboard().getCreatorEvents(token),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<EventModel> events = snapshot.data!;
                int? listLength = events.length;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 32,
                          left: 7,
                          right: 7,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Related to your orders',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: listLength, // will be changed later
                                itemBuilder: (context, index) {
                                  //print(ID);
                                  String? stDate =
                                      events.elementAt(index).stDate;
                                  String? endDate =
                                      events.elementAt(index).endDate;
                                  String? stTime =
                                      events.elementAt(index).stTime;
                                  String? title = events.elementAt(index).title;
                                  String? venueName =
                                      events.elementAt(index).venueName;
                                  int? ID = events.elementAt(index).ID;
                                  String? imageURL =
                                      events.elementAt(index).image;
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MyOrdersInHomeBody(
                                            eventId: ID!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(22),
                                          decoration: BoxDecoration(
                                              border: Border.all(),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20))),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  title!,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                        )
                                      ],
                                    ),
                                  ); // custom widget
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const CustomLoadingIndicator();
              }
            }));
  }
}
