import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../tickets_info/Create_promo_code_component.dart';

///This widget is [PromoCodesTab] which just displays some [Text] and [Image]
///It has 2  [ElevatedButton] for either creating code or uploading csv

class PromoCodesTab extends StatelessWidget {
  const PromoCodesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "assets/images/promocodes.png",
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 1,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 1,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const Text(
                        "Attract more attendees with promo codes",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            fontFamily: "Neue Plak Text Bold"),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "With promo codes, you can offer reduced prices with discount codes or reveal hidden tickets to attendees with access codes. \n  \n You can create codes or upload a CSV to import ones you’ve already made",
                        style: TextStyle(
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(204, 33, 33, 33),
                            fontSize: 18,
                            fontFamily: "Neue Plak Text Bold"),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        top: MediaQuery.of(context).size.height * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 60,
                              child: ElevatedButton(
                                key: ValueKey("createpromocode"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CreatePromoCodeComponnet(
                                              csv: false,
                                            )),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 210, 78, 42),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Text(
                                  'Create promo code',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              height: 60,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromARGB(161, 0, 0, 0),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: ElevatedButton(
                                  key: ValueKey("uploadcsv"),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreatePromoCodeComponnet(
                                                csv: true,
                                              )),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: const Text(
                                    'Upload csv',
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 20,
                                        color: Color.fromARGB(161, 0, 0, 0)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
