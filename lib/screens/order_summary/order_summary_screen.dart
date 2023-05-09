import 'package:event_brite_app/models/order_model.dart';
import 'package:event_brite_app/models/ticket_model.dart';
import 'package:event_brite_app/reusable_widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';

import '../../functions/services/tickets_requests.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen(
      {super.key, required this.orderItems, this.promocode});
  final List<Map<String, dynamic>> orderItems;
  final dynamic promocode;

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  Future<List<TicketModel>>? orderList;
  @override
  void initState() {
    super.initState();
    //print(widget.promocode);
    orderList = Tickets().postOrderRequest(widget.orderItems);
    //print(orderList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: orderList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List? order = snapshot.data;
              print(order);
              return Container(
                color: Colors.green,
              );
            }
            return Container(
              color: Colors.red,
            );
          }),
    );
  }
}
