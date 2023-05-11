import 'package:event_brite_app/providers/creator/ticket_provider.dart';
import 'package:event_brite_app/providers/creator/updated_ticket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../components/single_date.dart';
import '../../../../constants.dart';
import '../../../../functions/services/create_ticket.dart';
import '../../../../functions/services/update_ticket.dart';
import '../../../../functions/utils/back_button_to_events.dart';
import '../../../../functions/utils/back_button_to_tickets.dart';
import '../../../../functions/utils/ticketpricing.dart';
import '../../../../models/tickets_model.dart';
import '../../../../providers/creator/date_selection_provider.dart';
import '../../../../providers/creator/date_selection_updated.dart';
import '../../../../providers/token_provider.dart';
import '../../../../reusable_widgets/drop_down_list_widget.dart';
import '../../../../reusable_widgets/pop_offline_pricing_details_widget.dart';
import '../../../../reusable_widgets/pop_online_pricing_details_widget.dart';
import '../../../../reusable_widgets/text_form_field.dart';
import 'add_ticket.dart';

class AddTickets extends StatefulWidget {
  final int par;
  final TicketsModel? previousTicketModel;

  const AddTickets({Key? key, required this.par, this.previousTicketModel})
      : super(key: key);

  @override
  State<AddTickets> createState() => _AddTicketsState();
}

class _AddTicketsState extends State<AddTickets> {
  /// A GlobalKey [_formKey] that can be used to access the FormState for this form.
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ticketPriceControllerFree =
      TextEditingController(text: '0.00');

  bool isEditingCompleteField = false;

  @override
  void initState() {
    super.initState();
    // Add a post-frame callback to run a function after the widgets are built and rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // OUR OLDDDDDDDDDDDDDDD DATAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

      String ticketName = widget.previousTicketModel?.ticketName ?? '';
      String ticketType = widget.previousTicketModel?.ticketType ?? '';
      int capacity = widget.previousTicketModel?.capacity ?? 0;
      double price = widget.previousTicketModel?.price ?? 0.00;
      int quantitySold = widget.previousTicketModel?.quantitySold ?? 0;
      String absorbFeesS = widget.previousTicketModel?.asborbFees ?? '';
      bool absorbFees;
      if (absorbFeesS == "False") {
        absorbFees = false;
      } else {
        absorbFees = true;
      }
      int ticketID = widget.previousTicketModel?.id ?? 0;

      final prevModel =
          Provider.of<UpdatedTicketProviderModel>(context, listen: false);
      prevModel.ticketName = ticketName;
      prevModel.ticketType = ticketType;
      prevModel.availableQuantity = capacity.toString();
      prevModel.absorbFees = absorbFees;
      prevModel.price = price.toString();
      prevModel.ticketID = ticketID;
      //prevModel.quantitySold = 0;

      final dateSelectionStatePrev =
          Provider.of<UpdatedDateSelectionModel>(context, listen: false);
      DateTime eventStart =
          widget.previousTicketModel?.salesStart ?? DateTime(2023, 5, 12);
      DateTime eventEnd =
          widget.previousTicketModel?.salesEnd ?? DateTime(2023, 5, 14);
      TimeOfDay startTime = widget.previousTicketModel?.startTime ??
          TimeOfDay(hour: 12, minute: 00);
      TimeOfDay endTime =
          widget.previousTicketModel?.endTime ?? TimeOfDay(hour: 7, minute: 00);

      //_dateControllerEnd.text = DateFormat('yyyy-MM-dd').format(value);

      dateSelectionStatePrev.timeControllerEnd.text = startTime.format(context);
      dateSelectionStatePrev.timeControllerStart.text = endTime.format(context);
      dateSelectionStatePrev.dateControllerStart.text =
          DateFormat('yyyy-MM-dd').format(eventStart);
      dateSelectionStatePrev.dateControllerEnd.text =
          DateFormat('yyyy-MM-dd').format(eventEnd);

      //we need to make new data = old data then check later if they are equal or not

      final newdate = Provider.of<DateSelectionModel>(context, listen: false);

      final newmodel = Provider.of<TicketProviderModel>(context, listen: false);

      newmodel.absorbFees = prevModel.absorbFees;
      newmodel.availableQuantity = prevModel.availableQuantityController.text;
      newmodel.price = prevModel.priceController.text;
      newmodel.ticketName = prevModel.ticketNameController.text;
      newmodel.ticketType = prevModel.ticketType;
      newmodel.ticketID = prevModel.ticketID;

      newdate.dateStart = dateSelectionStatePrev.dateControllerStart.text;
      newdate.dateEnd = dateSelectionStatePrev.dateControllerEnd.text;
      newdate.timeStart = dateSelectionStatePrev.timeControllerStart.text;
      newdate.timeEnd = dateSelectionStatePrev.timeControllerEnd.text;

      print(newmodel.ticketID);
      print(widget.previousTicketModel?.id);
    });
  }

  //saving default values before user prefills:

  //for dates: we are saving them in a [dateSelectionState] which is a [Provider] of [DateSelectionModel] where we use [Provider] in order to get the data user chose for the date, time and checklist
  @override
  Widget build(BuildContext context) {
    String? token = Provider.of<TokenModel>(context).token;
    return Scaffold(
      body: Consumer2<TicketProviderModel, UpdatedTicketProviderModel>(
          builder: (BuildContext context, model, oldmodel, Widget? child) {
        return Stack(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                backButtonToTickets(context),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8, right: 8),
                    //beginning of our form
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //First text field ===> title:::::::::::::::::::::::::::::
                          TextFormFieldWidget(
                            key: ValueKey("ticketname"),
                            TitleController: model.ticketNameController,
                            //initialValue: _eventTitle,
                            hint: 'Enter a short, distinct name.',
                            maxLength: 50,
                            isSuffixRequired: true,
                            label: 'Name ',
                          ),

                          const SizedBox(
                            height: 30,
                          ),

                          TextFormFieldWidget(
                            key: ValueKey("quantity"),
                            TitleController: model.availableQuantityController,
                            hint: '',
                            isSuffixRequired: true,
                            label: 'Available quantity ',
                          ),

                          const SizedBox(
                            height: 30,
                          ),
                          //note that for absorb fees: Cost to Buyer = 100 + (100 * 0.037) + 1.79 + (100 * 0.029) in online
                          //at door: +1 dollar
                          TextFormFieldWidget(
                            key: ValueKey("price"),
                            enabled: widget.par == 0 ? false : true,
                            TitleController: widget.par == 0
                                ? _ticketPriceControllerFree
                                : model.priceController,
                            //initialValue: _eventTitle,
                            hint: '',
                            isPrefixIconrequired: true,
                            prefixIcon: Icon(Icons.attach_money_outlined),
                            isSuffixRequired: true,
                            label: 'Price ',

                            onEditingComplete: () {
                              setState(() {
                                isEditingCompleteField = true;
                                model.price =
                                    double.parse(model.priceController.text)
                                        .toStringAsFixed(2);
                              });
                            },
                          ),

                          //according to the boolean variable, we show the checkbox and text
                          if (isEditingCompleteField || widget.par != 0)
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        model.absorbFees == false
                                            ? 'Buyer total: \$${calculateTicketPriceAfterFees(double.parse(model.priceController.text)).toStringAsFixed(2)}'
                                            : 'Buyer total: \$${model.priceController.text}',
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 177, 176, 176),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            key: ValueKey("showdialog1"),
                                            onTap: () {
                                              // Show the pop-up widget
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return OnlinePriceInfoPopUpWidget(
                                                      ticketPrice: model
                                                          .priceController
                                                          .text);
                                                },
                                              );
                                            },
                                            child: const Text(
                                              'How online fees work',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            key: ValueKey("showdialog2"),
                                            onTap: () {
                                              // Show the pop-up widget
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return OfflinePriceInfoPopUpWidget(
                                                      ticketPrice: model
                                                          .priceController
                                                          .text);
                                                },
                                              );
                                            },
                                            child: const Text(
                                              'How At the door fees work',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ListTile(
                                  // ignore: prefer_const_constructors
                                  title: const Text(
                                      'Absorb fees: Ticketing fees are deducted from your ticket revenue',
                                      style: TextStyle(
                                          fontSize: 16, fontFamily: "Poppins")),
                                  leading: Checkbox(
                                    activeColor:
                                        const Color.fromARGB(255, 210, 78, 42),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    value: model.absorbFees,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        model.absorbFees = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          else
                            const SizedBox(height: 0),

                          const SizedBox(
                            height: 30,
                          ),

                          const DateSelectionWidget(
                            endDay: 'Sales end',
                            isCheckBoxVisibile: false,
                            startDay: 'Sales start',
                          ),
                          const SizedBox(
                            height: 60,
                          )
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
                        onPressed: () {
                          //change all textfields to its default:
                          // model.absorbFees = false;
                          // model.availableQuantity = '0';
                          // model.price = '0.00';
                          // model.ticketName = 'General Admission';

                          // final dateSelectionState =
                          //     Provider.of<DateSelectionModel>(context,
                          //         listen: false);
                          // dateSelectionState.dateStart = '2023-05-12';
                          // dateSelectionState.dateEnd = '2023-05-14';
                          // dateSelectionState.timeStart = '12:00AM';
                          // dateSelectionState.timeEnd = '7:00PM';

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Tickets()),
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
                      onPressed: () async {
                        final ticketData = Provider.of<TicketProviderModel>(
                            context,
                            listen: false);

                        final dateSelectionState =
                            Provider.of<DateSelectionModel>(context,
                                listen: false);

                        final olddateSelectionState =
                            Provider.of<UpdatedDateSelectionModel>(context,
                                listen: false);

                        _formKey.currentState?.save();

                        model.ticketType = widget.par == 0 ? "Free" : "Paid";

                        if (_formKey.currentState!.validate()) {
                          print("before saving");
                          Provider.of<TicketProviderModel>(context,
                                  listen: false)
                              .saveData(
                                  model.ticketNameController,
                                  model.priceController,
                                  model.availableQuantityController,
                                  dateSelectionState.dateControllerStart,
                                  dateSelectionState.dateControllerEnd,
                                  dateSelectionState.timeControllerStart,
                                  dateSelectionState.timeControllerEnd,
                                  model.absorbFees,
                                  model.quantitySold,
                                  model.ticketType);

                          // String formattedSalesEnd = DateFormat('yyyy-MM-dd')
                          //     .format(model.formData.salesEnd!);
                          // //  print(formattedSalesEnd);

                          // String formattedSalesStart = DateFormat('yyyy-MM-dd')
                          //     .format(model.formData.salesStart!);
                          // // print(formattedSalesEnd);

                          print("after saving");
                          print(model.ticketID);
                          print(model.ticketNameController.text);
                          print(model.formData.id);
                          print(model.formData.ticketName);
                          print(model.formData.asborbFees);
                          print(model.formData.capacity);
                          print(model.formData.price);
                          print(model.formData.quantitySold);
                          print(model.formData.ticketType);
                          print(model.formData.salesStart);
                          print(model.formData.salesEnd);
                          print(model.formData.startTime);
                          print(model.formData.endTime);

                          print(oldmodel.ticketID);
                          if (oldmodel.ticketID == 0 ||
                              oldmodel.ticketID == null) {
                            print("before create");
                            final createTicketResult =
                                await createTicketService().CreateTicket(
                                  token: token,
                              ticketName: ticketData.formData.ticketName,
                              ticketType: ticketData.formData.ticketType,
                              saleStart: ticketData.formData.salesStart,
                              saleEnd: ticketData.formData.salesEnd,
                              startTime: ticketData.formData.startTime,
                              endTime: ticketData.formData.endTime,
                              quantitySold: ticketData.formData.quantitySold,
                              availableQunatity: ticketData.formData.capacity,
                              price: ticketData.formData.price,
                              absorbFees: ticketData.formData.asborbFees,
                              context: context,
                            );
                            print("ticketID");
                            print(createTicketResult['ID']);
                            final ticketId = createTicketResult['ID'];
                            ticketData.ticketID = ticketId;

                            print("after create ");
                          } else {
                            print("isnide update any field");
                            if (model.ticketNameController.text !=
                                oldmodel.ticketNameController.text) {
                              UpdateTicketServices().updateField(
                                  id: ticketData.ticketID!,
                                  fieldName: 'NAME',
                                  //   newValue: ticketData.ticketNameController.text,
                                  newValue: ticketData.formData.ticketName!,
                                  context: context);
                            }

                            if (model.absorbFees != oldmodel.absorbFees) {
                              if (model.absorbFees == true) {
                                UpdateTicketServices().updateField(
                                    id: ticketData.ticketID!,
                                    fieldName: 'Absorb_fees',
                                    newValue: "True",
                                    context: context);
                              } else {
                                UpdateTicketServices().updateField(
                                    id: ticketData.ticketID!,
                                    fieldName: 'Absorb_fees',
                                    newValue: "False",
                                    context: context);
                              }
                            }

                            if (model.availableQuantityController.text !=
                                oldmodel.availableQuantityController.text) {
                              UpdateTicketServices().updateField(
                                  id: ticketData.ticketID!,
                                  fieldName: 'capacity',
                                  newValue:
                                      model.availableQuantityController.text,
                                  context: context);
                            }

                            if (model.priceController.text !=
                                oldmodel.priceController.text) {
                              UpdateTicketServices().updateField(
                                  id: ticketData.ticketID!,
                                  fieldName: 'PRICE',
                                  newValue: model.priceController.text,
                                  context: context);
                            }

                            if (model.ticketType != oldmodel.ticketType) {
                              UpdateTicketServices().updateField(
                                  id: ticketData.ticketID!,
                                  fieldName: 'TICKET_TYPE',
                                  newValue: model.ticketType,
                                  context: context);
                            }

                            if (model.quantitySold != oldmodel.quantitySold) {
                              UpdateTicketServices().updateField(
                                  id: ticketData.ticketID!,
                                  fieldName: 'quantity_sold',
                                  newValue: model.quantitySold.toString(),
                                  context: context);
                            }
                            if (dateSelectionState.dateControllerStart.text !=
                                olddateSelectionState
                                    .dateControllerStart.text) {
                              // Provider.of<BasicInfoFormDataProvider>(context, listen: false)
                              //     .saveDateStart(dateSelectionState.dateControllerStart);
                              UpdateTicketServices().updateField(
                                  id: ticketData.ticketID!,
                                  fieldName: 'Sales_start',
                                  newValue: dateSelectionState
                                      .dateControllerStart.text,
                                  context: context);
                            }
                            if (dateSelectionState.dateControllerEnd.text !=
                                olddateSelectionState.dateControllerEnd.text) {
                              // Provider.of<BasicInfoFormDataProvider>(context, listen: false)
                              //     .saveDateEnd(olddateSelectionState.dateControllerEnd);
                              UpdateTicketServices().updateField(
                                  id: ticketData.ticketID!,
                                  fieldName: 'Sales_end',
                                  newValue:
                                      dateSelectionState.dateControllerEnd.text,
                                  context: context);
                            }
                            if (dateSelectionState.timeControllerStart.text !=
                                olddateSelectionState
                                    .timeControllerStart.text) {
                              // Provider.of<BasicInfoFormDataProvider>(context, listen: false)
                              //     .saveTimeStart(dateSelectionState.timeControllerStart);
                              UpdateTicketServices().updateField(
                                  id: ticketData.ticketID!,
                                  fieldName: 'Start_time ',
                                  newValue: dateSelectionState
                                      .timeControllerStart.text,
                                  context: context);
                            }
                            if (dateSelectionState.timeControllerEnd.text !=
                                olddateSelectionState.timeControllerEnd.text) {
                              // Provider.of<BasicInfoFormDataProvider>(context, listen: false)
                              //     .saveTimeEnd(dateSelectionState.timeControllerEnd);
                              UpdateTicketServices().updateField(
                                  id: ticketData.ticketID!,
                                  fieldName: 'End_time ',
                                  newValue:
                                      dateSelectionState.timeControllerEnd.text,
                                  context: context);
                            }
                            print("after update ");
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Tickets()),
                          );
                        }
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
}
