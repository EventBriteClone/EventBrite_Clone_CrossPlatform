import 'package:event_brite_app/functions/services/dashboard_requests.dart';
import 'package:event_brite_app/models/order_items_get_model.dart';
import 'package:event_brite_app/reusable_widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../providers/token_provider.dart';

class MyOrdersInHomeBody extends StatefulWidget {
  const MyOrdersInHomeBody({super.key, required this.eventId});
  final int eventId;

  @override
  State<MyOrdersInHomeBody> createState() => _MyOrdersInHomeBodyState();
}

class _MyOrdersInHomeBodyState extends State<MyOrdersInHomeBody> {
  @override
  Widget build(BuildContext context) {
    String? token = Provider.of<TokenModel>(context).token;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Dashboard().getMyorders(widget.eventId, token),
          builder: (context, snapshot) {
            List<OrderItemsGetModel>? data = snapshot.data;
            if (snapshot.hasData) {
              return Center(
                child: Text(
                  data.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              return CustomLoadingIndicator();
            }
          },
        ),
      ),
    );
  }
}
