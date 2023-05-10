import 'dart:io';

import 'package:event_brite_app/functions/services/update_event.dart';
import 'package:event_brite_app/models/basic_info_form.dart';
import 'package:event_brite_app/providers/creator/details_provider.dart';
import 'package:event_brite_app/providers/creator/updated_event_two_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../components/location_list_title.dart';
import '../../../components/single_date.dart';
import '../../../constants.dart';
import '../../../functions/utils/back_button_to_events.dart';
import '../../../helper/api.dart';
import '../../../models/place_auto_complete_response';
import '../../../providers/creator/basic_info_provider.dart';
import '../../../providers/creator/date_selection_provider.dart';
import '../../../providers/creator/date_selection_updated.dart';
import '../../../providers/creator/updated_event_one_provider.dart';
import '../../../reusable_widgets/drop_down_list_widget.dart';
import '../../../reusable_widgets/heading_description_widget.dart';
import '../../../reusable_widgets/heading_widget.dart';
import '../../../reusable_widgets/text_form_field.dart';
import 'add_event_p_two.dart';

/// This widget represents a form for adding new events.
///
/// /// The main widget that represents the event creation form.
///   ///  The following [Widget] represnts the form where user inpuuts the Event details
/// It consists of  a [ListView] inside a [Scaffold] to make the content scrollable and avoid overflow issues.

/// This widget contains three sections that allow users to input information about their event:
/// - Basic Info: event title, event type, and event category.
///               where they use [TextFormField] and [DropdownButtonFormField] but customized
/// - Location: physical or online location of the event.
/// - Date & Time: start and end date and time of the event.

class AddEvents extends StatefulWidget {
  final BasicInfoFormData? previousBasicInfoData;
  const AddEvents({Key? key, this.previousBasicInfoData}) : super(key: key);

  @override
  State<AddEvents> createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  /// A GlobalKey [_formKey] that can be used to access the FormState for this form.
  final _formKey = GlobalKey<FormState>();

  //for place autocomplete:
  /// Makes a request to the Google Places API autocomplete with the given query.
  /// Updates [placePredictions] with the results.
  Future<void> placeAutoComplete(String query) async {
    Uri uri = Uri.https(
      "maps.googleapis.com",
      '/maps/api/place/autocomplete/json', //unencoder path
      {
        "input": query, //query parameter
        "key": apiKey, //
      },
    );

    ///for get request:
    String? response = await Api.fetchUrl(uri);

    /// Parse the response and update [placePredictions] if there are any predictions.
    if (response != null) {
      PlaceAutoCompleteResponse result =
          PlaceAutoCompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }

  ///date picker & time picker:
  ///for date:
  // final _dateControllerStart = TextEditingController();
  // final _dateControllerEnd = TextEditingController();
  // // final _eventLocationController = TextEditingController();

  // ///for time:
  // final _timeControllerStart = TextEditingController();
  // final _timeControllerEnd = TextEditingController();

  // @override

  // /// Dispose of the controllers when this widget is removed from the tree
  // void dispose() {
  //   _dateControllerEnd.dispose();
  //   _dateControllerStart.dispose();
  //   _timeControllerEnd.dispose();
  //   _timeControllerStart.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();

    // Add a post-frame callback to run a function after the widgets are built and rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // OUR OLDDDDDDDDDDDDDDD DATAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
      String eventName = widget.previousBasicInfoData?.eventTitle ?? '';
      String organizer = widget.previousBasicInfoData?.organizer ?? '';
      String type = widget.previousBasicInfoData?.type ?? '';
      String category = widget.previousBasicInfoData?.category ?? '';
      String location = widget.previousBasicInfoData?.venueLocation ?? '';
      int eventID = widget.previousBasicInfoData?.eventID ?? 0;
      String online = widget.previousBasicInfoData?.online ?? '';
      String selectedLocationInput =
          widget.previousBasicInfoData?.venueLocation ?? '';
      String status = widget.previousBasicInfoData?.status ?? '';

      String summary = widget.previousBasicInfoData?.summary ?? '';
      String desc = widget.previousBasicInfoData?.eventDesc ?? '';
      File? image = widget.previousBasicInfoData?.eventImage ?? null;

      final prevModelTwo =
          Provider.of<UpdatedEventTwoProvider>(context, listen: false);
      prevModelTwo.eventSummary = summary;
      prevModelTwo.eventImage = image;
      prevModelTwo.eventDesc = desc;

      final prevModel =
          Provider.of<UpdatedEventOneProvider>(context, listen: false);
      prevModel.eventName = eventName;
      prevModel.organizer = organizer;
      prevModel.typee = type;
      prevModel.categoryy = category;
      prevModel.eventLocation = location;
      prevModel.eventId = eventID;
      prevModel.online = online;
      prevModel.selectedLocationInput = selectedLocationInput;
      if (prevModel.selectedLocationInput == "Online Event") {
        prevModel.selectedLocation = "Online Event";
      } else if (prevModel.selectedLocationInput == "To be Announced") {
        prevModel.selectedLocation = "To be Announced";
      } else {
        prevModel.selectedLocation = "Venue";
      }
      prevModel.status = status;

      final dateSelectionStatePrev =
          Provider.of<UpdatedDateSelectionModel>(context, listen: false);
      DateTime eventStart =
          widget.previousBasicInfoData?.eventStart ?? DateTime(2023, 5, 12);
      DateTime eventEnd =
          widget.previousBasicInfoData?.eventEnd ?? DateTime(2023, 5, 14);
      TimeOfDay startTime = widget.previousBasicInfoData?.startTime ??
          TimeOfDay(hour: 12, minute: 00);
      TimeOfDay endTime = widget.previousBasicInfoData?.endTime ??
          TimeOfDay(hour: 7, minute: 00);

      //_dateControllerEnd.text = DateFormat('yyyy-MM-dd').format(value);

      dateSelectionStatePrev.timeControllerEnd.text = startTime.format(context);
      dateSelectionStatePrev.timeControllerStart.text = endTime.format(context);
      dateSelectionStatePrev.dateControllerStart.text =
          DateFormat('yyyy-MM-dd').format(eventStart);
      dateSelectionStatePrev.dateControllerEnd.text =
          DateFormat('yyyy-MM-dd').format(eventEnd);

      //we need to make new data = old data then check later if they are equal or not

      final newdate = Provider.of<DateSelectionModel>(context, listen: false);

      final newmodel =
          Provider.of<BasicInfoFormDataProvider>(context, listen: false);

      final newmodelTwo =
          Provider.of<DetailsFormDataProvider>(context, listen: false);
      newmodelTwo.eventDesc = prevModelTwo.eventDescController.text;
      newmodelTwo.eventSummary = prevModelTwo.eventSummaryController.text;
      newmodelTwo.eventImage = prevModelTwo.eventImage;

      newmodel.categoryy = prevModel.categoryy;
      newmodel.eventId = prevModel.eventId;
      newmodel.eventName = prevModel.eventNameController.text;
      newmodel.eventLocation = prevModel.eventLocationController.text;
      newmodel.online = prevModel.online;
      newmodel.organizer = prevModel.organizer;
      newdate.dateStart = dateSelectionStatePrev.dateControllerStart.text;
      newdate.dateEnd = dateSelectionStatePrev.dateControllerEnd.text;
      newdate.timeStart = dateSelectionStatePrev.timeControllerStart.text;
      newdate.timeEnd = dateSelectionStatePrev.timeControllerEnd.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //background:
      backgroundColor: Colors.white,
      //we wanted a list view for the column to be scrollable and fit into content to avoid overflow
      body: Consumer2<BasicInfoFormDataProvider, UpdatedEventOneProvider>(
          builder: (BuildContext context, newmodel, oldmodel, Widget? child) {
        int orgindex = Organizer.indexOf(oldmodel.organizer);
        int typeindex = type.indexOf(oldmodel.typee);
        int categoryindex = category.indexOf(oldmodel.categoryy);
        int locationchoiceindex = location.indexOf(oldmodel.selectedLocation);

        return ListView(
          shrinkWrap: true,
          children: [
            backButtonToEvents(context),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8, right: 8),

                //beginning of our form
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //Section1:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
                      Image.asset(
                        'assets/images/Tevents.png',
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),

                      const HeadingWidget(
                        headingText: "Basic Info",
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      const HeadingDescriptionWidget(
                        headingDescText:
                            "Name your event and tell event-goers why they should come. Add details that highlight what makes it unique.",
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      //First text field ===> title:::::::::::::::::::::::::::::
                      TextFormFieldWidget(
                        key: ValueKey("eventname"),
                        TitleController: newmodel.eventNameController,
                        hint: 'Be clear and descriptive.',
                        maxLength: 75,
                        isSuffixRequired: true,
                        label: 'Event Title ',
                        onChanged: (value) {
                          //if updated we change new value
                          newmodel.eventName = value;
                        },
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      //drop down menu ===> type & category in a row beside each other:::::::::::::::::::::::::::::
                      ///note that we used mediquery=> to make drop down take 40% of our device to avoid overflow
                      ///if we did isexpanded= true this means that dropdown list will take all available space if false then takes ssize of its dropdown meny
                      DropDownListWidget(
                        key: ValueKey("organizer"),
                        items: Organizer,
                        selectedValue:
                            orgindex != -1 ? Organizer[orgindex] : Organizer[0],
                        hinttext: 'Organizer',
                        onChanged: (value) {
                          setState(() {
                            //update new value
                            print("iniside setting organizer:");
                            newmodel.organizer = value;
                          });
                        },
                      ),
                      DropDownListWidget(
                        key: ValueKey("type"),
                        items: type,
                        selectedValue:
                            typeindex != -1 ? type[typeindex] : type[0],
                        hinttext: 'Type',
                        onChanged: (value) {
                          setState(() {
                            //update new value
                            newmodel.typee = value;
                          });
                        },
                      ),

                      /////////////////////

                      const SizedBox(width: 20),

                      /////////////////////////

                      DropDownListWidget(
                        key: ValueKey("category"),
                        items: category,
                        hinttext: 'Category',
                        selectedValue: categoryindex != -1
                            ? category[categoryindex]
                            : category[0],
                        onChanged: (value) {
                          setState(() {
                            //update new value
                            newmodel.categoryy = value;
                          });
                        },
                      ),

                      //Tags part

                      //end of section-1:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::;;
                      const SizedBox(
                        height: 50,
                      ),
                      const Divider(
                        color: Colors.black,
                      ),

                      //section-2::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::;::

                      Image.asset(
                        'assets/images/location.png',
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),

                      const HeadingWidget(headingText: "Location"),

                      const SizedBox(
                        height: 5,
                      ),

                      const HeadingDescriptionWidget(
                          headingDescText:
                              "Help people in the area discover your event and let attendees know where to show up."),

                      const SizedBox(
                        height: 10,
                      ),

                      DropDownListWidget(
                        key: ValueKey("locationchoice"),
                        items: location,
                        //hinttext: 'Venue',
                        prefixIcon: const Icon(Icons.location_on),
                        selectedValue: locationchoiceindex != -1
                            ? location[locationchoiceindex]
                            : location[0],
                        onChanged: (value) {
                          // Update the selected location.
                          setState(() {
                            newmodel.selectedLocation = value;
                          });
                        },
                      ),

                      //checking which one is selected:
                      if (newmodel.selectedLocation == 'Venue') ...[
                        // Display these widgets if _selectedLocation is 'Venue'
                        //Text('Venue selected'),
                        TextFormFieldWidget(
                          key: ValueKey("location"),
                          TitleController: newmodel.eventLocationController,
                          label: 'Venue Location ',
                          hint: 'Search for a venue or address.',
                          isSuffixRequired: true,
                          onChanged: (value) {
                            // setState(() {
                            //   _selectedLocationInput = value;
                            // });
                            placeAutoComplete(value);
                          },
                        ),

                        const Divider(
                          height: 2,
                          thickness: 2,
                          color: Color.fromARGB(255, 215, 215, 215),
                        ),
                        //created own components for suggestion
                        //to show the results:
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: ListView.builder(
                            itemCount: placePredictions.length,
                            itemBuilder: (context, index) => LocationListTitle(
                              onSelect: (value) {
                                setState(() {
                                  newmodel.selectedLocationInput = value;

                                  placePredictions.clear();
                                });
                                newmodel.eventLocationController.text = value;
                              },
                              location: placePredictions[index].description!,
                            ),
                          ),
                        )
                      ] else if (newmodel.selectedLocation ==
                          'Online Event') ...[
                        // Display these widgets if _selectedLocation is 'Online Event'
                        const HeadingDescriptionWidget(
                            headingDescText:
                                'Online events have unique event pages where you can add links to livestreams and more'),
                      ] else if (newmodel.selectedLocation == 'To be Announced')
                        ...[],

                      //end of section-2:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::;;
                      const SizedBox(
                        height: 50,
                      ),
                      const Divider(
                        color: Colors.black,
                      ),

                      //section-3:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
                      Image.asset(
                        'assets/images/cal.png',
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),

                      const HeadingWidget(headingText: "Date & Time"),

                      const SizedBox(
                        height: 5,
                      ),
                      const HeadingDescriptionWidget(
                          headingDescText:
                              "Tell event-goers when your event starts and ends so they can make plans to attend."),

                      const SizedBox(
                        height: 10,
                      ),

                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          DateSelectionWidget(
                            startDay: 'Event Start',
                            endDay: 'Event Ends',
                            isCheckBoxVisibile: true,
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        key: ValueKey("floatingactionbutton"),
        onPressed: () {
          print('pressed');

          final dateSelectionState =
              Provider.of<DateSelectionModel>(context, listen: false);

          final olddateSelectionState =
              Provider.of<UpdatedDateSelectionModel>(context, listen: false);

          final model =
              Provider.of<BasicInfoFormDataProvider>(context, listen: false);

          final oldmodel =
              Provider.of<UpdatedEventOneProvider>(context, listen: false);

          if (model.selectedLocation == 'Online Event') {
            model.selectedLocationInput = 'Online Event';
            model.eventLocationController.text = 'Online Event';
          } else if (model.selectedLocation == 'To be Announced') {
            model.selectedLocationInput = 'To be Announced';
            model.eventLocationController.text = 'To be Announced';
          }

          _formKey.currentState?.save();

          if (_formKey.currentState!.validate()) {
            if (model.selectedLocationInput == 'Online Event') {
              model.online = 'True';
            }

            if (model.organizer.isEmpty || model.organizer == '') {
              model.organizer = 'organizer';
            }

            if (model.categoryy.isEmpty || model.categoryy == '') {
              model.categoryy = category[0];
            }

            //updating to make new values = old values again
            //first we check if new==old if yes we dont do anything
            //if not we update new=old and call the request
            //also we have to chek that if this was the first time user enters data then
            //old will not be equal to new  but we wont need to see update request and we will make old=new

            print("newwwwwwwwwwww name: ${model.eventNameController.text}");
            print("olddddddddd name: ${oldmodel.eventNameController.text}");
            print("newwwwwwwwwwww id: ${model.eventId}");
            print("newwwwwwwwww status: ${model.status}");
            print("oldddddddd id: ${oldmodel.eventId}");
            print("oldddddddddd status: ${oldmodel.status}");
            print("Newwwwwwwww online: ${model.online}");
            print("oldddddddd online: ${oldmodel.online}");
            print('oldddddddddd Category: ${oldmodel.categoryy}');
            print('newwwwwwwwwwww Category: ${model.categoryy}');
            print('newwwwwwwwwwwwwwwwwwr: ${model.organizer}');
            print('olddddddddddd: ${oldmodel.organizer}');
            print('newwwwwwwwwwww type: ${model.typee}');
            print('oldddddddddd type: ${oldmodel.typee}');
            print('newwwwwww location: ${model.eventLocationController.text}');
            print('mewwwwwwwwww location: ${model.selectedLocation}');
            print(
                'olddddddddddd location: ${oldmodel.eventLocationController.text}');
            print('oldddddddddd location: ${oldmodel.selectedLocation}');

            print('new startdate: ${dateSelectionState.dateControllerStart}');
            print(dateSelectionState.dateControllerEnd);
            print(dateSelectionState.timeControllerStart);
            print(dateSelectionState.timeControllerEnd);

            print(
                'old startdate: ${olddateSelectionState.dateControllerStart}');
            print(olddateSelectionState.dateControllerEnd);
            print(olddateSelectionState.timeControllerStart);
            print(olddateSelectionState.timeControllerEnd);

            //we either update or create

            //if create the id will be 0
            //print(oldmodel.eventId);

            bool update = true;

            Provider.of<BasicInfoFormDataProvider>(context, listen: false)
                .saveData(
              model.eventNameController.text,
              model.categoryy,
              model.typee,
              model.eventLocationController.text,
              dateSelectionState.dateControllerStart,
              dateSelectionState.dateControllerEnd,
              dateSelectionState.timeControllerStart,
              dateSelectionState.timeControllerEnd,
              dateSelectionState.isChecked1,
              dateSelectionState.isChecked2,
              dateSelectionState.isChecked3,
              model.organizer,
              model.status,
              model.online,
            );

            if (oldmodel.eventId == 0) {
              print("inside create");
              //create
              update = false;
            } else {
              //check which fields needs updating:
              print("inside update any field");
              if (model.eventNameController.text !=
                  oldmodel.eventNameController.text) {
                // Provider.of<BasicInfoFormDataProvider>(context, listen: false)
                //     .saveTitle(model.eventNameController.text);

                UpdateEventServices().updateField(
                    id: model.eventId!,
                    fieldName: 'Title',
                    newValue: model.eventNameController.text,
                    context: context);
              }
              if (model.online != oldmodel.online) {
                // Provider.of<BasicInfoFormDataProvider>(context, listen: false)
                //     .saveOnline(model.online);
                UpdateEventServices().updateField(
                    id: model.eventId!,
                    fieldName: 'online',
                    newValue: model.online,
                    context: context);
              }
              if (model.categoryy != oldmodel.categoryy) {
                // Provider.of<BasicInfoFormDataProvider>(context, listen: false)
                //     .saveCategory(model.categoryy);
                UpdateEventServices().updateField(
                    id: model.eventId!,
                    fieldName: 'category_name',
                    newValue: model.categoryy,
                    context: context);
              }
              if (model.organizer != oldmodel.organizer) {
                // Provider.of<BasicInfoFormDataProvider>(context, listen: false)
                //     .saveOrganizer(model.organizer);
                UpdateEventServices().updateField(
                    id: model.eventId!,
                    fieldName: 'organizer',
                    newValue: model.organizer,
                    context: context);
              }
              if (model.eventLocationController.text !=
                  oldmodel.eventLocationController.text) {
                // Provider.of<BasicInfoFormDataProvider>(context, listen: false)
                //     .saveLocation(model.eventLocationController.text);
                UpdateEventServices().updateField(
                    id: model.eventId!,
                    fieldName: 'venue_name',
                    newValue: model.eventLocationController.text,
                    context: context);
              }
              if (model.status != oldmodel.status) {
                // Provider.of<BasicInfoFormDataProvider>(context, listen: false)
                //     .saveStatus(model.status);
                UpdateEventServices().updateField(
                    id: model.eventId!,
                    fieldName: 'STATUS',
                    newValue: model.status,
                    context: context);
              }
              if (model.selectedLocation != oldmodel.selectedLocation) {
                // Provider.of<BasicInfoFormDataProvider>(context, listen: false)
                //     .saveTitle(model.selectedLocation);
              }
              if (model.typee != oldmodel.typee) {
                // Provider.of<BasicInfoFormDataProvider>(context, listen: false)
                //     .saveType(model.typee);
                UpdateEventServices().updateField(
                    id: model.eventId!,
                    fieldName: 'type',
                    newValue: model.typee,
                    context: context);
              }

              if (dateSelectionState.dateControllerStart.text !=
                  olddateSelectionState.dateControllerStart.text) {
                // Provider.of<BasicInfoFormDataProvider>(context, listen: false)
                //     .saveDateStart(dateSelectionState.dateControllerStart);
                UpdateEventServices().updateField(
                    id: model.eventId!,
                    fieldName: 'ST_DATE',
                    newValue: dateSelectionState.dateControllerStart.text,
                    context: context);
              }
              if (dateSelectionState.dateControllerEnd.text !=
                  olddateSelectionState.dateControllerEnd.text) {
                // Provider.of<BasicInfoFormDataProvider>(context, listen: false)
                //     .saveDateEnd(olddateSelectionState.dateControllerEnd);
                UpdateEventServices().updateField(
                    id: model.eventId!,
                    fieldName: 'END_DATE',
                    newValue: dateSelectionState.dateControllerEnd.text,
                    context: context);
              }
              if (dateSelectionState.timeControllerStart.text !=
                  olddateSelectionState.timeControllerStart.text) {
                // Provider.of<BasicInfoFormDataProvider>(context, listen: false)
                //     .saveTimeStart(dateSelectionState.timeControllerStart);
                UpdateEventServices().updateField(
                    id: model.eventId!,
                    fieldName: 'ST_TIME ',
                    newValue: dateSelectionState.timeControllerStart.text,
                    context: context);
              }
              if (dateSelectionState.timeControllerEnd.text !=
                  olddateSelectionState.timeControllerEnd.text) {
                // Provider.of<BasicInfoFormDataProvider>(context, listen: false)
                //     .saveTimeEnd(dateSelectionState.timeControllerEnd);
                UpdateEventServices().updateField(
                    id: model.eventId!,
                    fieldName: 'END_TIME ',
                    newValue: dateSelectionState.timeControllerEnd.text,
                    context: context);
              }

              print(model.formData.eventDesc);
              print(model.formData.summary);
              print(model.formData.eventImage);
            }
            print("outside for");
            print(model.formData.eventTitle);
            print(model.formData.category);
            print(model.formData.type);
            print(model.formData.online);
            print(model.formData.organizer);
            print(model.formData.venueLocation);
            print(model.formData.status);
            print(model.formData.eventStart);
            print(model.formData.eventEnd);
            print(model.formData.startTime);
            print(model.formData.endTime);

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddDetails(update: update)),
            );
          }
        },
        backgroundColor: const Color.fromARGB(255, 210, 78, 42),
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

//-------------------------------------------------------------------------------draft-----------------------------------------

//  if (dateSelectionState.dateControllerStart == null ||
//               dateSelectionState.dateControllerEnd == null ||
//               dateSelectionState.timeControllerStart == null ||
//               dateSelectionState.timeControllerEnd == null) {
//             dateSelectionState.dateStart = '';
//             dateSelectionState.dateEnd = '';
//             dateSelectionState.timeStart = '';
//             dateSelectionState.timeEnd = '';
//           }

// _selectedDateButton == DateSelection.SingleEvent
//     ? Provider.of<BasicInfoFormDataProvider>(context, listen: false)
//         .saveDataSingle(
//         _eventTitle!,
//         _category,
//         _type!,
//         _selectedLocationInput,
//         dateSelectionState.dateControllerStart,
//         dateSelectionState.dateControllerEnd,
//         dateSelectionState.timeControllerStart,
//         dateSelectionState.timeControllerEnd,
//         dateSelectionState.isChecked1,
//         dateSelectionState.isChecked2,
//       )
//     : Provider.of<BasicInfoFormDataProvider>(context, listen: false)
//         .saveDataRecurring(
//         _eventTitle!,
//         _category,
//         _type!,
//         _selectedLocationInput,
//         dateSelectionState.isChecked3,
//       );

// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     SizedBox(
//       height: MediaQuery.of(context).size.height * 0.07,
//       width: MediaQuery.of(context).size.width * 0.45,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           primary: _isPressedSingle
//               ? const Color.fromARGB(150, 208, 214, 246)
//               : Colors.white, // background color
//           onPrimary: _isPressedSingle
//               ? Colors.white
//               : Colors.grey, // foreground color
//           //backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(3),
//               side: BorderSide(
//                 color: _isPressedSingle
//                     ? const Color.fromARGB(
//                         255, 100, 117, 224)
//                     : Colors.grey,
//               )),
//           elevation: 0,
//         ),
//         onPressed: () {
//           setState(() {
//             _selectedDateButton =
//                 DateSelection.SingleEvent;
//             _isPressedSingle = !_isPressedSingle;
//             _isPressedRecurring = false;
//           });
//         },
//         child: Text(
//           'Single Event',
//           style: TextStyle(
//               color: _isPressedSingle
//                   ? const Color.fromARGB(
//                       255, 100, 117, 224)
//                   : Colors.black,
//               fontSize: 16,
//               fontFamily: "Poppins"),
//         ),
//       ),
//     ),
//     SizedBox(
//       height: MediaQuery.of(context).size.height * 0.07,
//       width: MediaQuery.of(context).size.width * 0.45,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           primary: _isPressedRecurring
//               ? const Color.fromARGB(150, 208, 214, 246)
//               : Colors.white, // background color
//           onPrimary: _isPressedRecurring
//               ? Colors.white
//               : Colors.grey, // foreground color
//           //backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(3),
//               side: BorderSide(
//                 color: _isPressedRecurring
//                     ? const Color.fromARGB(
//                         255, 100, 117, 224)
//                     : Colors.grey,
//               )),
//           elevation: 0,
//         ),
//         onPressed: () {
//           setState(() {
//             _selectedDateButton =
//                 DateSelection.RecurringEvent;
//             _isPressedRecurring = !_isPressedRecurring;
//             _isPressedSingle = false;
//           });
//         },
//         child: Text(
//           'Recurring Event',
//           style: TextStyle(
//               color: _isPressedRecurring
//                   ? const Color.fromARGB(
//                       255, 100, 117, 224)
//                   : Colors.black,
//               fontSize: 16,
//               fontFamily: "Poppins"),
//         ),
//       ),
//     ),
//   ],
// ),
// const SizedBox(
//   height: 20,
// ),
// Flexible(
//   child:
//       _selectedDateButton == DateSelection.SingleEvent
//           ? const DateSelectionWidget()
//           : _selectedDateButton ==
//                   DateSelection.RecurringEvent
//               ? const RecurringDateButtonWidget()
//               : const DateSelectionWidget(),
// ),
