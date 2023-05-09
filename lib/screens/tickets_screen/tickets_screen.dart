// ignore_for_file: must_be_immutable

import 'package:event_brite_app/constants.dart';
import 'package:event_brite_app/functions/services/tickets_requests.dart';
import 'package:event_brite_app/models/ticket_model.dart';
import 'package:event_brite_app/reusable_widgets/custom_loading_indicator.dart';
import 'package:event_brite_app/screens/order_summary/order_summary_screen.dart';
import 'package:flutter/material.dart';

class TicketsScreen extends StatefulWidget {
  TicketsScreen({
    super.key,
    this.eventId,
    required this.eventName,
  });
  final int? eventId;
  final String? className = 'Anything';
  final double? price = 100;
  late double? totalPrice = 0.00;
  final String eventName;
  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  final myController = TextEditingController();
  Future<List<TicketModel>>? ticketList;
  @override
  void initState() {
    super.initState();
    ticketList = Tickets().getTicketClasses();
  }

  late double? totalPrice = 0.00;
  bool? promocodeCheckLocalVariable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Center(
          child: Text(
            widget.eventName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              size: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: ticketList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<TicketModel>? tickets = snapshot.data;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: tickets?.length,
                          itemBuilder: (context, index) {
                            String? ticketClassName =
                                tickets!.elementAt(index).name;
                            double? ticketPrice =
                                tickets.elementAt(index).price;
                            int? ticketClassId = tickets.elementAt(index).id;
                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue.shade700,
                                      width: 2,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(3),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            ticketClassName!,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  setState(
                                                    () {
                                                      if (tickets
                                                              .elementAt(index)
                                                              .ticketReservations !=
                                                          0) {
                                                        tickets
                                                            .elementAt(index)
                                                            .ticketReservations = tickets
                                                                .elementAt(
                                                                    index)
                                                                .ticketReservations! -
                                                            1;
                                                        widget.totalPrice =
                                                            widget.totalPrice! -
                                                                ticketPrice!;
                                                      } else {
                                                        const snackBar =
                                                            SnackBar(
                                                          content: Text(
                                                              'Tickets are already 0'),
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);
                                                      }
                                                    },
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.remove,
                                                  size: 20,
                                                ),
                                              ),
                                              Text(
                                                tickets
                                                    .elementAt(index)
                                                    .ticketReservations
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(
                                                    () {
                                                      tickets
                                                          .elementAt(index)
                                                          .ticketReservations = tickets
                                                              .elementAt(index)
                                                              .ticketReservations! +
                                                          1;
                                                      widget.totalPrice =
                                                          widget.totalPrice! +
                                                              ticketPrice!;
                                                    },
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.add,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Text(
                                        'Price: $ticketPrice',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                              ],
                            );
                          }),
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextField(
                          controller: myController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1),
                            ),
                            hintText: 'Enter code',
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            if (myController.text.isEmpty) {
                              const snackBar = SnackBar(
                                content: Text('Please enter a promocode'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              bool promocodeCheck = await Tickets()
                                  .checkPromocode(myController.text);
                              if (promocodeCheck == true) {
                                promocodeCheckLocalVariable = true;
                                const snackBar = SnackBar(
                                  content: Text('Promocode will be applied!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                promocodeCheckLocalVariable = false;
                                const snackBar = SnackBar(
                                  content: Text('Invalid Promocode'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                              print(promocodeCheck);
                            }
                          },
                          child: const Text(
                            'Apply',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total price:',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${widget.totalPrice}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0, backgroundColor: secondaryColor),
                          onPressed: () {
                            //Map<String, dynamic> body = {};
                            List<Map<String, dynamic>> orderItems = [];
                            for (int i = 0; i < tickets!.length; i++) {
                              if (tickets.elementAt(i).ticketReservations !=
                                  0) {
                                Map<String, dynamic> orderFromEachClass = {
                                  "ticket_class_id": tickets.elementAt(i).id,
                                  "quantity":
                                      tickets.elementAt(i).ticketReservations,
                                };
                                orderItems.add(orderFromEachClass);
                              } else if (orderItems.isEmpty) {
                                /// pass
                                /// ignored order
                              }
                            }
                            //body = {"order_items": orderItems};
                            // if (promocodeCheckLocalVariable == true) {
                            //   String promoCodeMap = myController.text;
                            //   //.addAll(promoCodeMap);
                            // } else {
                            //   Map<String, dynamic> promoCodeMap = {
                            //     'promocode': null
                            //   };
                            //   //body.addAll(promoCodeMap);
                            // }
                            print(orderItems);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return OrderSummaryScreen(
                                    orderItems: orderItems,
                                    promocode: myController.text,
                                  );
                                },
                              ),
                            );
                          },
                          child: const Center(
                            child: Text(
                              'Checkout',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    )
                  ],
                ),
              ),
            );
          }
          return const CustomLoadingIndicator();
        },
      ),
    );
  }
}
