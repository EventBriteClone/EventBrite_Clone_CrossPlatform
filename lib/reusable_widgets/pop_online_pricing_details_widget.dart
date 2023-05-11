import 'package:event_brite_app/functions/utils/ticketpricing.dart';
import 'package:flutter/material.dart';

/// This [OnlinePriceInfoPopUpWidget] takes as input [ticketPrice] and displays how the online pricing works for the ticket in a [Container] displayed at [Center] of the screen as a pop up
/// It uses [calculateTicketPriceAfterFees] , [calculateServiceFee] & [calculateProcessingFee] methods for calculating neccessary fees for the price and displaying final price

class OnlinePriceInfoPopUpWidget extends StatelessWidget {
  OnlinePriceInfoPopUpWidget({super.key, required this.ticketPrice});

  final String? ticketPrice;

  @override
  Key? get key => super.key;

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: key,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width * 1,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/ticketspriceinfo.png',
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Ticket Price',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 64, 63, 63),
                                      fontFamily: 'Neue Plak Regular',
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '\$${ticketPrice}',
                                  style: const TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 16,
                                      color: Color.fromARGB(223, 64, 63, 63),
                                      fontFamily: 'Neue Plak Regular',
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Service fee',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 64, 63, 63),
                                      fontFamily: 'Neue Plak Regular',
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  '\$${calculateServiceFee(double.parse(ticketPrice ?? '0.00')).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 64, 63, 63),
                                      fontFamily: 'Neue Plak Regular',
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                '3.70% + \$1.79 per ticket',
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 12,
                                    color: Color.fromARGB(212, 144, 144, 144),
                                    fontFamily: 'Neue Plak Regular',
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Processing fee',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 64, 63, 63),
                                      fontFamily: 'Neue Plak Regular',
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  '\$${calculateProcessingFee(double.parse(ticketPrice ?? '0.00')).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 64, 63, 63),
                                      fontFamily: 'Neue Plak Regular',
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                '2.90% per order',
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 12,
                                    color: Color.fromARGB(212, 144, 144, 144),
                                    fontFamily: 'Neue Plak Regular',
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            const Divider(
                              height: 20,
                              color: Color.fromARGB(54, 144, 144, 144),
                              thickness: 1,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Cost to buyer',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 144, 144, 144),
                                      fontFamily: 'Neue Plak Regular',
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '\$${calculateTicketPriceAfterFees(double.parse(ticketPrice ?? '0.00')).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 144, 144, 144),
                                      fontFamily: 'Neue Plak Regular',
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),

                            //divider:
                            const Divider(
                              color: Color.fromARGB(54, 144, 144, 144),
                              thickness: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(84, 224, 222, 249)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromARGB(255, 95, 110, 241),
                                      ),
                                      child: const Icon(
                                        Icons.attach_money,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text(
                                      'Your payout: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromARGB(206, 90, 90, 90),
                                        decoration: TextDecoration.none,
                                        fontSize: 16,
                                        fontFamily: "segoe ui",
                                      ),
                                    ),
                                    Text(
                                      '\$${ticketPrice}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromARGB(206, 90, 90, 90),
                                        decoration: TextDecoration.none,
                                        fontSize: 16,
                                        fontFamily: "segoe ui",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 100.0, top: 10),
                              child: SizedBox(
                                width: 80,
                                height: 25,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromARGB(161, 0, 0, 0),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      //we need to just close the pop up
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'Done',
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          color: Color.fromARGB(161, 0, 0, 0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
