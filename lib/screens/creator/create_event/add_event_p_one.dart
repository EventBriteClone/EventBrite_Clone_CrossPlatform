import 'package:flutter/material.dart';
import 'package:organizer/helpers/api.dart';
import 'package:organizer/models/basic_info_form.dart';
import 'package:organizer/screens/creator/basic_info/basic_info.dart';
import 'package:organizer/utils/back_button_to_events.dart';
import 'package:provider/provider.dart';
import '../../../components/location_list_title.dart';
import 'package:organizer/models/place_auto_complete_response';
import 'package:organizer/constants/constants.dart';
import '../../../components/recurring_date.dart';
import '../../../components/single_date.dart';
import '../../../providers/creator/basic_info_provider.dart';
import '../../../providers/creator/date_selection_provider.dart';
import '../../../reusable_widgets/drop_down_list_widget.dart';
import '../../../reusable_widgets/heading_description_widget.dart';
import '../../../reusable_widgets/heading_widget.dart';
import '../../../reusable_widgets/text_form_field.dart';
import 'add_event_p_two.dart';

/// This widget represents a form for adding new events.
class AddEvents extends StatefulWidget {
  const AddEvents({super.key});

  @override
  State<AddEvents> createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  /// A GlobalKey [_formKey] that can be used to access the FormState for this form.
  final _formKey = GlobalKey<FormState>();

  /// The selected location [_selectedLocation] (either 'Venue' or 'Online' or 'To be Announed').
  String? _selectedLocation = 'Venue';

  /// The state of the single event button using pivate [_isPressedSingle] which is [bool]
  bool _isPressedSingle = false;

  ///  The state of the recurring event button using pivate [_isPressedRecurring] which is [bool]
  bool _isPressedRecurring = false;

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

  /// Controllers for the form input fields.
  ///for getting text back (user input)
  //final TextEditingController _eventTitleController = TextEditingController();
  final TextEditingController _eventTitleController =
      TextEditingController(text: 'Your pre-filled event title');

  ///date picker & time picker:
  ///for date:
  final _dateControllerStart = TextEditingController();
  final _dateControllerEnd = TextEditingController();
  final _eventLocationController = TextEditingController();

  ///for time:
  final _timeControllerStart = TextEditingController();
  final _timeControllerEnd = TextEditingController();

  /// The selected date button ('Single Event' or 'Recurring Event').
  DateSelection _selectedDateButton = DateSelection.SingleEvent;

  @override

  /// Dispose of the controllers when this widget is removed from the tree
  void dispose() {
    _dateControllerEnd.dispose();
    _dateControllerStart.dispose();
    _timeControllerEnd.dispose();
    _timeControllerStart.dispose();
    super.dispose();
  }

  /// The main widget that represents the event creation form.
  ///   ///  The following [Widget] represnts the form where user inpuuts the Event details
  /// It consists of  a [ListView] inside a [Scaffold] to make the content scrollable and avoid overflow issues.

  /// This widget contains three sections that allow users to input information about their event:
  /// - Basic Info: event title, event type, and event category.
  ///               where they use [TextFormField] and [DropdownButtonFormField] but customized
  /// - Location: physical or online location of the event.
  /// - Date & Time: start and end date and time of the event.
  ///

  /// FORM DATA:
  /// ----------
  /// [formData] which gets the info from the [BasicInfoFormDataProvider] to save initial data for prefilling the form:

  ///
  /// ///variables to be saved from the form for later use: (10 variables)
  ///. [_eventTitle] for the event title field in [TextFormFieldWidget]  a custom widget
  String? _eventTitle;

  //we have [_organzier] of event he choose from the  [DropDownListWidget] a custom widge
  String? _organizer = Organizer[0];

  ///2. the [_type] of event he choose from the  [DropDownListWidget] a custom widget
  //String? _type;
  String? _type = type[0];

  ///3. the [_category] of event he choose from the  [DropDownListWidget] a custom widget
  // String? _category;
  // String _category = category.isNotEmpty ? category[0] : '';
  String _category = category[0];

  ///4.  The user-input location if [_selectedLocation] is 'Venue' , it saves the data in [_selectedLocationInput] which is from a [TextFormFieldWidget]  a custom widget
  String _selectedLocationInput = '';

  /// for 5,6,7,8,9,10 we are saving them in a [dateSelectionState] which is a [Provider] of [DateSelectionModel] where we use [Provider] in order to get the data user chose for the date, time and checklist

  @override
  Widget build(BuildContext context) {
    //late final formData = context.watch<BasicInfoFormDataProvider>().formData;
    //String? _eventTitle = formData.eventTitle ?? '';
    //String? _eventTitle;
    // if (formData.eventTitle != null) {
    //   _eventTitle = formData.eventTitle!;
    // }
    return Scaffold(
      //background:
      backgroundColor: Colors.white,
      //we wanted a list view for the column to be scrollable and fit into content to avoid overflow
      body: ListView(
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
                        eventTitleController: _eventTitleController,
                        //initialValue: _eventTitle,
                        hint: 'Be clear and descriptive.',
                        isRequired: true,
                        label: 'Event Title ',
                        onChanged: (value) {
                          setState(() {
                            print('$_eventTitle');
                            _eventTitle = value;
                            print('$_eventTitle');
                          });
                        }),

                    const SizedBox(
                      height: 30,
                    ),

                    //drop down menu ===> type & category in a row beside each other:::::::::::::::::::::::::::::
                    ///note that we used mediquery=> to make drop down take 40% of our device to avoid overflow
                    ///if we did isexpanded= true this means that dropdown list will take all available space if false then takes ssize of its dropdown meny
                    DropDownListWidget(
                      items: Organizer,
                      selectedValue: _organizer,
                      hinttext: 'Organizer',
                      onChanged: (value) {
                        setState(() {
                          _organizer = value;
                        });
                      },
                    ),
                    DropDownListWidget(
                      items: type,
                      selectedValue: _type,
                      hinttext: 'Type',
                      onChanged: (value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),

                    /////////////////////

                    const SizedBox(width: 20),

                    /////////////////////////

                    DropDownListWidget(
                      items: category,
                      hinttext: 'Category',
                      selectedValue: _category,
                      onChanged: (value) {
                        setState(() {
                          _category = value;
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
                      items: location,
                      hinttext: 'Venue',
                      prefixIcon: const Icon(Icons.location_on),
                      selectedValue: _selectedLocation,
                      onChanged: (value) {
                        // Update the selected location.
                        setState(() {
                          _selectedLocation = value;
                        });
                      },
                    ),

                    //checking which one is selected:
                    if (_selectedLocation == 'Venue') ...[
                      // Display these widgets if _selectedLocation is 'Venue'
                      // Text('Venue selected'),
                      TextFormFieldWidget(
                        eventTitleController: _eventLocationController,
                        label: 'Venue Location ',
                        hint: 'Search for a venue or address.',
                        isRequired: true,
                        onChanged: (value) {
                          setState(() {
                            _selectedLocationInput = value;
                          });
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
                                _selectedLocationInput = value;
                                placePredictions.clear();
                              });
                              _eventLocationController.text = value;
                            },

                            location: placePredictions[index].description!,
                            // location: "Cairo University, Cairo, Egypt",
                          ),
                        ),
                      )
                    ] else if (_selectedLocation == 'Online Event') ...[
                      // Display these widgets if _selectedLocation is 'Online Event'
                      const HeadingDescriptionWidget(
                          headingDescText:
                              'Online events have unique event pages where you can add links to livestreams and more'),
                    ] else if (_selectedLocation == 'To be Announced')
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: _isPressedSingle
                                      ? const Color.fromARGB(150, 208, 214, 246)
                                      : Colors.white, // background color
                                  onPrimary: _isPressedSingle
                                      ? Colors.white
                                      : Colors.grey, // foreground color
                                  //backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      side: BorderSide(
                                        color: _isPressedSingle
                                            ? const Color.fromARGB(
                                                255, 100, 117, 224)
                                            : Colors.grey,
                                      )),
                                  elevation: 0,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _selectedDateButton =
                                        DateSelection.SingleEvent;
                                    _isPressedSingle = !_isPressedSingle;
                                    _isPressedRecurring = false;
                                  });
                                },
                                child: Text(
                                  'Single Event',
                                  style: TextStyle(
                                      color: _isPressedSingle
                                          ? const Color.fromARGB(
                                              255, 100, 117, 224)
                                          : Colors.black,
                                      fontSize: 16,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: _isPressedRecurring
                                      ? const Color.fromARGB(150, 208, 214, 246)
                                      : Colors.white, // background color
                                  onPrimary: _isPressedRecurring
                                      ? Colors.white
                                      : Colors.grey, // foreground color
                                  //backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      side: BorderSide(
                                        color: _isPressedRecurring
                                            ? const Color.fromARGB(
                                                255, 100, 117, 224)
                                            : Colors.grey,
                                      )),
                                  elevation: 0,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _selectedDateButton =
                                        DateSelection.RecurringEvent;
                                    _isPressedRecurring = !_isPressedRecurring;
                                    _isPressedSingle = false;
                                  });
                                },
                                child: Text(
                                  'Recurring Event',
                                  style: TextStyle(
                                      color: _isPressedRecurring
                                          ? const Color.fromARGB(
                                              255, 100, 117, 224)
                                          : Colors.black,
                                      fontSize: 16,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Flexible(
                          child:
                              _selectedDateButton == DateSelection.SingleEvent
                                  ? const DateSelectionWidget()
                                  : _selectedDateButton ==
                                          DateSelection.RecurringEvent
                                      ? const RecurringDateButtonWidget()
                                      : const DateSelectionWidget(),
                        )
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _eventTitle = _eventTitleController.text;
          print('Event title: $_eventTitle');
          final dateSelectionState =
              Provider.of<DateSelectionModel>(context, listen: false);

          if (_selectedLocation == 'Online Event') {
            _selectedLocationInput = 'Online Event';
          } else if (_selectedLocation == 'To be Announced') {
            _selectedLocationInput = 'To be Announced';
          }

          if (dateSelectionState.timeControllerStart == null ||
              dateSelectionState.timeControllerEnd == null) {
            dateSelectionState.timeStart = '';
            dateSelectionState.timeEnd = '';
          }

          _formKey.currentState?.save();

          if (_formKey.currentState!.validate()) {
            // if the form is valid, save the data
            String? singleorRecurring;
            if (_selectedDateButton == DateSelection.SingleEvent) {
              singleorRecurring = 'Single';
            } else {
              singleorRecurring = 'Recurring';
            }

            String? _online = 'False';
            if (_selectedLocationInput == 'Online Event') {
              _online = 'True';
            }
            String? _status = 'Draft';

            print('Event title: $_eventTitle');
            Provider.of<BasicInfoFormDataProvider>(context, listen: false)
                .saveData(
              _eventTitle!,
              _category,
              _type!,
              _selectedLocationInput,
              dateSelectionState.dateControllerStart,
              dateSelectionState.dateControllerEnd,
              dateSelectionState.timeControllerStart,
              dateSelectionState.timeControllerEnd,
              dateSelectionState.isChecked1,
              dateSelectionState.isChecked2,
              dateSelectionState.isChecked3,
              singleorRecurring,
              _organizer!,
              _status,
              _online,
            );

            print('Event title: $_eventTitle');
            print('Category: $_category');
            print('Event organzier: $_organizer');
            print('type: $_type');
            print('location: $_selectedLocationInput');
            print('startdate: $dateSelectionState.dateControllerStart');
            print(dateSelectionState.dateControllerEnd);
            print(dateSelectionState.timeControllerStart);
            print(dateSelectionState.timeControllerEnd);
            print(dateSelectionState.isChecked1);
            print(dateSelectionState.isChecked2);
            print(dateSelectionState.isChecked3);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddDetails()),
            );
          }
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

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
