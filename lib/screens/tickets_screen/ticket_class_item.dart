import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TicketClassItem extends StatefulWidget {
  TicketClassItem({super.key, this.className, this.price, this.totalPrice});
  final String? className;
  final double? price;
  late double? totalPrice;

  @override
  State<TicketClassItem> createState() => _TicketClassItemState();
}

class _TicketClassItemState extends State<TicketClassItem> {
  int? ticketReservations = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue.shade700,
          width: 2,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(3),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.className!,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(
                        () {
                          if (ticketReservations != 0) {
                            ticketReservations = ticketReservations! - 1;
                            widget.totalPrice =  widget.totalPrice! - widget.price!;
                          } else {
                            const snackBar = SnackBar(
                              content: Text('Tickets are already 0'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
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
                    ticketReservations.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(
                        () {
                          ticketReservations = ticketReservations! + 1;
                          widget.totalPrice =  widget.totalPrice! + widget.price!; 
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
            'Price: ${widget.price}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
