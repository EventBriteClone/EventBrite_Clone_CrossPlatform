import 'package:event_brite_app/functions/services/dashboard_requests.dart';
import 'package:event_brite_app/models/event_dashboard_details.dart';
import 'package:event_brite_app/reusable_widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../providers/token_provider.dart';

class EventDashboardDetailsScreen extends StatefulWidget {
  const EventDashboardDetailsScreen({super.key, required this.ID});
  final int ID;

  @override
  State<EventDashboardDetailsScreen> createState() =>
      _EventDashboardDetailsScreenState();
}

class _EventDashboardDetailsScreenState
    extends State<EventDashboardDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    String? token = Provider.of<TokenModel>(context).token;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: Dashboard().getEventDashboardDetails(widget.ID,token),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<EventDashboardDetails>? dataListed = snapshot.data;
                EventDashboardDetails data = dataListed!.elementAt(0);
                int? quatitySold = data.quantitySold;
                int? capacity = data.capacity;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Quatity Sold: ${quatitySold.toString()}",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Capacity: ${capacity.toString()}",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                );
              }
              return const CustomLoadingIndicator();
            }),
      ),
    );
  }
}
