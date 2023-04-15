import 'package:event_brite_app/screens/login_signin_pages/publish.dart';
import 'package:flutter/material.dart';
import 'package:event_brite_app/constants.dart';
import '../../components/location_list_title.dart';
import '../../components/recurring_date.dart';
import '../../functions/utils/build_drop_menu_items.dart';
import '../../helper/api.dart';
import 'package:event_brite_app/models/place_auto_complete_response';
import '../../components/single_date.dart';

class AddEvents extends StatefulWidget {
  const AddEvents({super.key});

  @override
  State<AddEvents> createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  ///for the form:
  final _formKey = GlobalKey<FormState>();

  ///selected items:
  String? _selectedType = 'Type';
  String? _selectedCategory = 'Category';
  String? _selectedOrganizer = 'organizer';
  String? _selectedLocation = 'Venue';
  String _selectedLocationInput = '';

  bool _isPressedSingle = false;
  bool _isPressedRecurring = false;

  ///for place autocomplete:
  Future<void> placeAutoComplete(String query) async {
    Uri uri = Uri.https(
      "maps.googleapis.com",
      '/maps/api/place/autocomplete/json',

      ///unencoder path
      {
        "input": query,

        ///query parameter
        "key": apiKey, //
      },
    );

    ///for get request:
    String? response = await Api.fetchUrl(uri);
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

  ///for getting text back (user input)
  final TextEditingController _eventTitleController = TextEditingController();

  ///date picker & time picker:
  ///for date:
  final _dateControllerStart = TextEditingController();
  final _dateControllerEnd = TextEditingController();
  final _eventLocationController = TextEditingController();

  ///for time:
  final _timeControllerStart = TextEditingController();
  final _timeControllerEnd = TextEditingController();

  DateSelection _selectedDateButton = DateSelection.SingleEvent;

  @override
  void dispose() {
    _dateControllerEnd.dispose();
    _dateControllerStart.dispose();
    _timeControllerEnd.dispose();
    _timeControllerStart.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///background:
      backgroundColor: Colors.white,

      ///we wanted a list view for the column to be scrollable and fit into content to avoid overflow
      body: ListView(
        shrinkWrap: true,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),

              ///beginning of our form
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/Tevents.png',
                      width: 100,
                      height: 100,
                    ),

                    ///Section1:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Basic Info",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins"),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Name your event and tell event-goers why they should come. Add details that highlight what makes it unique.",
                        style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    ///First text field ===> title:::::::::::::::::::::::::::::
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: _eventTitleController,
                        maxLength: 75,

                        ///we also have maxLines
                        decoration: InputDecoration(
                          hintText: 'Be clear and descriptive.',
                          hintStyle: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 184, 180, 180),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700),
                          labelText: 'Event Title *',
                          labelStyle: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 100, 117, 224),
                          ),
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 32, horizontal: 24),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 100, 117, 224),
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                    ),

                    /// dropdown ===> organizer:::::::::::::::::::::::::::::

                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 100, 117, 224),
                              width: 2.0,
                            ),
                          ),
                        ),
                        isExpanded: true,
                        value: _selectedOrganizer,
                        iconSize: 36,
                        items: Organizer.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => this._selectedOrganizer = value),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    ///drop down menu ===> type & category in a row beside each other:::::::::::::::::::::::::::::
                    ///note that we used mediquery=> to make drop down take 40% of our device to avoid overflow
                    ///if we did isexpanded= true this means that dropdown list will take all available space if false then takes ssize of its dropdown meny
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 100, 117, 224),
                              width: 2.0,
                            ),
                          ),
                        ),
                        isExpanded: true,
                        value: _selectedType,
                        iconSize: 36,
                        items: type.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => this._selectedType = value),
                      ),
                    ),

                    /////////////////////

                    const SizedBox(width: 20),

                    /////////////////////////

                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 100, 117, 224),
                              width: 2.0,
                            ),
                          ),
                        ),
                        isExpanded: true,
                        value: _selectedCategory,
                        iconSize: 36,
                        items: category.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => this._selectedCategory = value),
                      ),
                    ),

                    ///Tags part

                    ///end of section-1:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::;;
                    const SizedBox(
                      height: 50,
                    ),
                    const Divider(
                      color: Colors.black,
                    ),

                    ///section-2::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::;::

                    Image.asset(
                      'assets/images/location.png',
                      width: 100,
                      height: 100,
                    ),

                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Location",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins"),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Help people in the area discover your event and let attendees know where to show up.",
                        style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 100, 117, 224),
                              width: 2.0,
                            ),
                          ),
                          prefixIcon: const Icon(Icons.location_on),
                        ),
                        isExpanded: true,
                        value: _selectedLocation,
                        iconSize: 36,
                        items: location.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => this._selectedLocation = value),
                      ),
                    ),

                    ///checking which one is selected:
                    if (_selectedLocation == 'Venue') ...[
                      /// Display these widgets if _selectedLocation is 'Venue'
                      // Text('Venue selected'),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          //initialValue: _selectedLocationInput,
                          onChanged: (value) {
                            setState(() {
                              _selectedLocationInput = value;
                            });
                            placeAutoComplete(value);
                          },
                          controller: _eventLocationController,
                          maxLength: 75,

                          ///we also have maxLines
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Search for a venue or address.',
                            hintStyle: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 184, 180, 180),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700),
                            labelText: 'Venue Location *',
                            labelStyle: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 100, 117, 224),
                            ),
                            border: const OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 32, horizontal: 24),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 100, 117, 224),
                                width: 2.0,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Divider(
                        height: 2,
                        thickness: 2,
                        color: Color.fromARGB(255, 215, 215, 215),
                      ),

                      ///created own components for suggestion
                      ///to show the results:
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
                      /// Display these widgets if _selectedLocation is 'Online Event'
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Online events have unique event pages where you can add links to livestreams and more',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      // Add other widgets as needed
                    ] else if (_selectedLocation == 'To be Announced') ...[
                      // const Text('To be Annonced'),
                    ],

                    ///end of section-2:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::;;
                    const SizedBox(
                      height: 50,
                    ),
                    const Divider(
                      color: Colors.black,
                    ),

                    /// section-3:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
                    Image.asset(
                      'assets/images/cal.png',
                      width: 100,
                      height: 100,
                    ),

                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Date & Time",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins"),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Tell event-goers when your event starts and ends so they can make plans to attend.",
                        style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
                      ),
                    ),
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
                                      : Colors.white,

                                  /// background color
                                  onPrimary: _isPressedSingle
                                      ? Colors.white
                                      : Colors.grey,

                                  /// foreground color
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
                                      : Colors.white,

                                  /// background color
                                  onPrimary: _isPressedRecurring
                                      ? Colors.white
                                      : Colors.grey,

                                  /// foreground color
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DependentDropdownMenu()),
          );
        },
        child: const Icon(Icons.arrow_forward),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
