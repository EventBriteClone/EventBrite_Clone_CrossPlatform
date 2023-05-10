import 'package:event_brite_app/functions/services/dashboard_requests.dart';
import 'package:event_brite_app/models/sold_ticket_model.dart';
import 'package:event_brite_app/reusable_widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<List<SoldTicketModel>>? soldTicketsInfo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    soldTicketsInfo = Dashboard().getSoldTicketClasses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FutureBuilder(
      future: soldTicketsInfo,
      builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Container(color: Colors.red,);
      } else {
        return const CustomLoadingIndicator();
      }
    }));
  }
}
