import 'dart:io';

import 'package:event_brite_app/components/end_date_only.dart';
import 'package:event_brite_app/components/tabs/promo_codes.dart';
import 'package:event_brite_app/constants.dart';
import 'package:event_brite_app/functions/services/create_promo_code.dart';
import 'package:event_brite_app/models/promocode_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../functions/utils/back_button_to_tickets.dart';
import '../../providers/creator/date_selection_provider.dart';
import '../../providers/creator/promocode_provider.dart';
import '../../reusable_widgets/drop_down_list_widget.dart';
import '../../reusable_widgets/text_form_field.dart';
import '../../screens/creator/basic_info/tickets/add_ticket.dart';
import '../single_date.dart';
import '../start_date_only.dart';

///This is a custom widget [CreatePromoCodeComponnet] that is responsible for creating a promocode
///It has a [bool] input which is [csv] that detrmines whether the user pressed create code or upload csv file
///This widget uses [Consumer] of [PromoCodeProviderModel] in order to save and retrieve promocode data in the [PromoCodeModel] among other widgets
///we have a [Form] containg [TextFormFieldWidget] of the code name, discount amount, and limited amount
///It also consists of [DropDownListWidget] for choosing whether a promocode is limited or not as well as choosing the disocunt amount type
///We also have 4 [Checkbox] that represents when the promocode will start and end
///Accoridng to the user choice , if he decided to schedule a date [StartSelectionWidget] and [EndSelectionWidget] will appear accodingly
///we also use [CreatePromoCodeService] to [createPromoCode] and save it to the backend when user presses on save button
///In case the user chooses a csv file upload we have implemented [pickCsvFile] to save it into our model

class CreatePromoCodeComponnet extends StatefulWidget {
  final bool? csv;
  const CreatePromoCodeComponnet({super.key, this.csv});

  @override
  State<CreatePromoCodeComponnet> createState() =>
      _CreatePromoCodeComponnetState();
}

class _CreatePromoCodeComponnetState extends State<CreatePromoCodeComponnet> {
  /// A GlobalKey [_formKey] that can be used to access the FormState for this form.
  final _formKey = GlobalKey<FormState>();

  String discountTypee = discountType[0];
  bool startnow = false;
  bool startscheduled = false;
  bool endnow = false;
  bool endscheduled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<PromoCodeProviderModel>(
          builder: (BuildContext context, model, Widget? child) {
        //mfrod n8yrha le old model
        int ticketLimit = ticketLimitList.indexOf(model.ticketLimit);
        return Stack(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                backButtonToTickets(context),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, bottom: 8, right: 8),
                    //beginning of our form
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //code name/ csv de btt8yr 3la 7asb
                          if (widget.csv == false)
                            TextFormFieldWidget(
                              key: ValueKey("codename"),
                              TitleController: model.codeNameController,
                              //initialValue: _eventTitle,
                              hint: 'Enter a short, distinct name.',
                              maxLength: 50,
                              isSuffixRequired: true,
                              label: 'Code Name ',
                            ),

                          if (widget.csv == true)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Upload up to 500 codes from a .csv or .txt file. \nSeparate codes with commas, or list them on separate lines. \nSpaces, apostrophes, and special characters (except: -_ , @ . ) are not allowed.',
                                    style: TextStyle(
                                        fontSize: 18, fontFamily: 'Neue Plak'),
                                  ),
                                ),
                                GestureDetector(
                                  key: ValueKey("uploadcsv"),
                                  onTap: () {
                                    // Handle onTap event here
                                    print("upload csv pressed");
                                    _handleUploadCsvButtonTap();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(158, 238, 238, 238),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        // Image widget
                                        Image.asset(
                                          'assets/images/csv.png',
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        // Text widget
                                        const Expanded(
                                          child: Text(
                                            'Import codes',
                                            style: TextStyle(
                                                fontFamily:
                                                    'Neue Plak Extended SemiBold',
                                                fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            ),

                          DropDownListWidget(
                            key: ValueKey("ticketlimit"),
                            items: ticketLimitList,
                            selectedValue: ticketLimit != -1
                                ? ticketLimitList[ticketLimit]
                                : ticketLimitList[0],
                            hinttext: '',
                            onChanged: (value) {
                              setState(() {
                                //update new value

                                model.ticketLimit = value;
                              });
                            },
                          ),

                          if (model.ticketLimit == ticketLimitList[1])
                            Column(
                              children: [
                                TextFormFieldWidget(
                                  key: ValueKey("limitamount"),
                                  TitleController: model.limitAmountController,
                                  //initialValue: _eventTitle,
                                  hint: 'Enter a short, distinct name.',
                                  maxLength: 20,
                                  isSuffixRequired: true,
                                  label: 'Tickets Amount ',
                                ),
                                const Text(
                                  'Total number of tickets that can be purchased with this code',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),

                          SizedBox(
                            height: 30,
                          ),

                          ListTile(
                            // ignore: prefer_const_constructors
                            title: const Text(
                                'Reveal hidden tickets during checkout',
                                style: TextStyle(
                                    fontSize: 16, fontFamily: "Poppins")),
                            leading: Checkbox(
                              activeColor:
                                  const Color.fromARGB(255, 210, 78, 42),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              value: model.revealHidden,
                              // model.absorbFees,
                              onChanged: (bool? value) {
                                setState(() {
                                  model.revealHidden = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Discount Amount',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Neue Plak Extended Bold',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),

                          DropDownListWidget(
                            key: ValueKey("discounttypee"),
                            items: discountType,
                            selectedValue: discountTypee,
                            // discountType != -1
                            //     ? discountType[discountType]
                            //     : discountType[0],
                            hinttext: '',
                            onChanged: (value) {
                              setState(() {
                                //update new value

                                discountTypee = value;
                              });
                            },
                          ),

                          if (discountTypee == discountType[1]) //money
                            TextFormFieldWidget(
                              key: ValueKey("disocuntamountprice"),
                              TitleController:
                                  model.discountAmountPriceController,
                              //initialValue: _eventTitle,
                              hint: '',
                              maxLength: 20,
                              isSuffixRequired: false,
                              label: '',
                              isPrefixIconrequired: true,
                              prefixIcon: Icon(Icons.attach_money),
                            ),

                          if (discountTypee == discountType[0]) //percentage
                            TextFormFieldWidget(
                              key: ValueKey("disamountperc"),
                              TitleController:
                                  model.discountAmountPercController,
                              //initialValue: _eventTitle,
                              hint: '',
                              maxLength: 20,
                              isSuffixRequired: false,
                              label: '',
                              isPrefixIconrequired: true,
                              prefixIcon: Icon(Icons.percent),
                            ),

                          const SizedBox(
                            height: 30,
                          ),

                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Promo Code Starts',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Neue Plak Extended Bold',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),

                          ListTile(
                            // ignore: prefer_const_constructors
                            title: const Text('Now ',
                                style: TextStyle(
                                    fontSize: 18, fontFamily: "Poppins")),
                            leading: Checkbox(
                              activeColor:
                                  const Color.fromARGB(255, 210, 78, 42),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              value: model.startsNow,
                              // model.absorbFees,
                              onChanged: (bool? value) {
                                setState(() {
                                  model.startsNow = value!;
                                  model.startScheduled = !value;
                                  if (value == true) {
                                    startnow = true;
                                    startscheduled = false;
                                  } else {
                                    startnow = false;
                                    startscheduled = true;
                                  }
                                });
                              },
                            ),
                          ),

                          ListTile(
                            // ignore: prefer_const_constructors
                            title: const Text('Scheduled time',
                                style: TextStyle(
                                    fontSize: 18, fontFamily: "Poppins")),
                            leading: Checkbox(
                              activeColor:
                                  const Color.fromARGB(255, 210, 78, 42),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              value: !model.startsNow,
                              // model.absorbFees,
                              onChanged: (bool? value) {
                                setState(() {
                                  model.startScheduled = value!;
                                  model.startsNow = !value;
                                  if (value == true) {
                                    startscheduled = true;
                                    startnow = false;
                                  }
                                });
                              },
                            ),
                          ),

                          if (startnow == false && startscheduled == true)
                            const StartSelectionWidget(
                              startDay: 'Start Date',
                              time: 'Start Time',
                            ),
                          const SizedBox(
                            height: 30,
                          ),

                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Promo Code Ends',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Neue Plak Extended Bold',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),

                          ListTile(
                            // ignore: prefer_const_constructors
                            title: const Text('When ticket sales end ',
                                style: TextStyle(
                                    fontSize: 18, fontFamily: "Poppins")),
                            leading: Checkbox(
                              activeColor:
                                  const Color.fromARGB(255, 210, 78, 42),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              value: model.endsNow,
                              // model.absorbFees,
                              onChanged: (bool? value) {
                                setState(() {
                                  model.endsNow = value!;
                                  model.endsSheduled = !value;
                                  if (value == true) {
                                    endnow = true;
                                    endscheduled = false;
                                  } else {
                                    endnow = false;
                                    endscheduled = true;
                                  }
                                });
                              },
                            ),
                          ),

                          ListTile(
                            // ignore: prefer_const_constructors
                            title: const Text('Scheduled time',
                                style: TextStyle(
                                    fontSize: 18, fontFamily: "Poppins")),
                            leading: Checkbox(
                              activeColor:
                                  const Color.fromARGB(255, 210, 78, 42),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              value: model.endsSheduled,
                              // model.absorbFees,
                              onChanged: (bool? value) {
                                setState(() {
                                  model.endsSheduled = value!;
                                  model.endsNow = !value;
                                  if (value == true) {
                                    endscheduled = true;
                                    endnow = false;
                                  } else {
                                    endscheduled = false;
                                    endnow = true;
                                  }
                                });
                              },
                            ),
                          ),

                          if (endnow == false && endscheduled == true)
                            const EndSelectionWidget(
                                startDay: 'End Date', time: 'End Time'),

                          const SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(161, 0, 0, 0),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        key: ValueKey("promocodetab"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PromoCodesTab()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 22,
                              color: Color.fromARGB(161, 0, 0, 0)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        // _formKey.currentState?.save();

                        // if (_formKey.currentState!.validate()) {
                        //   final dateSelectionState =
                        //       Provider.of<DateSelectionModel>(context,
                        //           listen: false);

                        //   Provider.of<PromoCodeProviderModel>(context,
                        //           listen: false)
                        //       .saveData(
                        //     model.codeNameController.text,
                        //     model.discountAmountPercController.text,
                        //     model.discountAmountPriceController.text,
                        //     model.limitAmountController.text,
                        //     dateSelectionState.dateControllerStart,
                        //     dateSelectionState.dateControllerEnd,
                        //     dateSelectionState.timeControllerStart,
                        //     dateSelectionState.timeControllerEnd,
                        //     model.revealHidden,
                        //     model.endsSheduled,
                        //     model.startScheduled,
                        //     model.endsNow,
                        //     model.startsNow,
                        //     model.ticketLimit,
                        //     model.csvFile,
                        //   );

                        //   PromoCodeModel _formdata = model.formData;

                        //   print(_formdata.codeName);
                        //   print(_formdata.limitedOrUn);
                        //   print(_formdata.limitAmount);
                        //   print(_formdata.revealHidden);
                        //   print(_formdata.discountPrice);
                        //   print(_formdata.discountAmount);
                        //   print(_formdata.starts);
                        //   print(_formdata.ends);
                        //   print(_formdata.codeStart);
                        //   print(_formdata.codeEnd);
                        //   print(_formdata.startTime);
                        //   print(_formdata.endTime);

                        //   CreatePromoCodeService().createPromoCode(
                        //       codeName: _formdata.codeName,
                        //       limitedOrUn: _formdata.limitedOrUn,
                        //       limitAmount: _formdata.limitAmount,
                        //       revealHidden: _formdata.revealHidden,
                        //       discountPrice: _formdata.discountPrice,
                        //       discountAmount: _formdata.discountAmount,
                        //       starts: _formdata.starts,
                        //       ends: _formdata.ends,
                        //       codeStart: _formdata.codeStart,
                        //       codeEnd: _formdata.codeEnd,
                        //       startTime: _formdata.startTime,
                        //       endTime: _formdata.endTime,
                        //       quantityAvailable: _formdata.quantityAvailable,
                        //       csvFile: _formdata.csvFile);

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const Tickets()),
                        // );
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 210, 78, 42),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 22,
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
        );
      }),
    );
  }

  Future<File?> pickCsvFile() async {
    // final picker = FilePicker.platform;
    // final result = await picker.pickFiles(
    //   type: FileType.custom,
    //   // allowedExtensions: ['csv'],
    // );

    // if (result == null || result.files.isEmpty) {
    //   return null;
    // }
    // final csvFile = XFile(result.files.single.path!);

    // Show file picker dialog
    final pickedFile = await FilePicker.platform.pickFiles();

    if (pickedFile != null) {
      // Create File object from picked file path
      File csvFile = File(pickedFile.files.single.path!);
      return csvFile;

      //  return result.files.single;
    }
    return null;
  }

  void _handleUploadCsvButtonTap() async {
    final csvFile = await pickCsvFile();

    print("csv picked");

    final file = Provider.of<PromoCodeProviderModel>(context, listen: false);

    if (csvFile != null) {
      setState(() {
        file.csvFile = File(csvFile.path);
        file.filePath = csvFile.path;
      });
    }
  }
}
