import 'package:event_brite_app/constants.dart';
import 'package:event_brite_app/models/order_model.dart';
import 'package:event_brite_app/models/returned_order_model/returned_order_model.dart';
import 'package:event_brite_app/models/ticket_model.dart';
import 'package:event_brite_app/reusable_widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:provider/provider.dart';

import '../../functions/services/tickets_requests.dart';
import '../../providers/token_provider.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen(
      {super.key,
      required this.orderItems,
      this.promocode,
      required this.eventId});
  final List<Map<String, dynamic>> orderItems;
  final dynamic promocode;
  final int eventId;

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    String? token = Provider.of<TokenModel>(context).token;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: Tickets().postOrderRequest(
                widget.orderItems, widget.promocode, widget.eventId, token),
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
                              height: MediaQuery.of(context).size.height * 0.28,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 8),
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
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Quatity: $ticketClassQuatity",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Order-Id: $orderId',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.005,
                                      ),
                                      Text(
                                        'Full price: \$ $fullPrice',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.005,
                                      ),
                                      Text(
                                        'Amount off:\$ $amountOff',
                                        style: const TextStyle(
                                            fontSize: 16,
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
                                      Text.rich(
                                        TextSpan(
                                          text: 'Total: ',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            background: Paint()
                                              ..color = Colors.yellow,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '\$ $total',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                background: Paint()
                                                  ..color = Colors.yellow,
                                              ),
                                            ),
                                          ],
                                        ),
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
