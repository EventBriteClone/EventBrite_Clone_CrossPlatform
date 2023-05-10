import 'package:event_brite_app/constants.dart';
import 'package:event_brite_app/models/order_model.dart';
import 'package:event_brite_app/models/returned_order_model/returned_order_model.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: Tickets().postOrderRequest(widget.orderItems),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic>? order = snapshot.data;
                List? ticketsList = order!['tickets'];
                print(order);
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: ticketsList!.length,
                          itemBuilder: (context, index) {
                            String? ticketClassId = ticketsList
                                .elementAt(0)['ticket_class_id']
                                .toString();
                            String? ticketClassQuatity =
                                ticketsList.elementAt(0)['quantity'].toString();
                            String? orderId =
                                ticketsList.elementAt(0)['order_id'].toString();
                            String? fullPrice = order['full_price'].toString();
                            String? amountOff = order['amount_off'].toString();
                            String? fee = order['fee'].toString();
                            String? total = order['total'].toString();
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 14),
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Ticket Class-Id: $ticketClassId',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Quatity: $ticketClassQuatity",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Order-Id: $orderId',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Full price: \$ $fullPrice',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Amount off:\$ $amountOff',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Total: \$ $total',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                );
              }
              return const CustomLoadingIndicator();
            }),
      ),
    );
  }
}
