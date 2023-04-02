import 'package:flutter/material.dart';
import '../models/autocomplate_prediction.dart';

const primaryColor = Colors.white;
const secondaryColor = Color(0xfff05537);

enum LocationSelection { Venue, OnlineEvent, ToBeAnnonuced }

enum DateSelection { SingleEvent, RecurringEvent }

///for icon:
const IconData location_on = IconData(0xe3ab, fontFamily: 'MaterialIcons');

///api key:
const String apiKey = "AIzaSyCCK4oTJvUUCiu779l_HXak8cqeUqC2u9A";

List<AutocompletePrediction> placePredictions = [];

final List<String> organizer = ['organizer', 'Mahinour Alaa'];

///SHOULD BE GOTTEN FROM BACKEND
final List<String> type = [
  'Type',
  'Appearance or Singing',
  'Attraction',
  'Camp, Trip, or Retreat',
  'Class, Training, or Workshop',
  'Concert or Performance',
  'Conference',
  'Convention',
  'Dinner or Gala',
  'Festival or fair',
  'Game or Competition',
  'Meeting or Networking Event',
  'Party or Social Gathering',
  'Race or Endurance Event',
  'Rally',
  'Screening',
  'Seminar or Talk',
  'Tour',
  'Tournment',
  'Tradeshow, Consumer Show, or Expo',
  'Other'
];

final List<String> category = [
  'Category',
  'Auto, Boat & Air',
  'Business & Professional',
  'Charity & Causes',
  'Community & Culture',
  'Family & Education',
  'Fashion & Beauty',
  'Film, Media & Entertainment',
  'Food & Drink',
  'Government & Politics',
  'Health & Wellness',
  'Hobbies & Special Interest',
  'Home & Lifestyle',
  'Music',
  'Performing & Visual Arts',
  'Religion & Spitituality',
  'School Activities',
  'Science & Technology',
  'Seasonal & Holiday',
  'Sports & Fitness',
  'Travel & Outdoor',
  'Other'
];

final List<String> location = ['Venue', 'Online Event', 'To be Announced'];
