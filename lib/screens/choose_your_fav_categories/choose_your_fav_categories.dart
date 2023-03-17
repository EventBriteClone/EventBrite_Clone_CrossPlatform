import 'package:event_brite_app/screens/choose_your_fav_categories/category_container.dart';
import 'package:flutter/material.dart';

class ChooseYourFavCategories extends StatefulWidget {
  const ChooseYourFavCategories({super.key});

  @override
  State<ChooseYourFavCategories> createState() =>
      _ChooseYourFavCategoriesState();
}

class _ChooseYourFavCategoriesState extends State<ChooseYourFavCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          const SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                "You're interested in: ",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: GridView.count(
              padding: EdgeInsets.zero,
              mainAxisSpacing: MediaQuery.of(context).size.height * 0.03,
              crossAxisCount: 3,
              crossAxisSpacing: MediaQuery.of(context).size.width * 0.08,
              children: const [
                InterestsContainer(text: 'Food & Drink'),
                InterestsContainer(text: 'Music'),
                InterestsContainer(text: 'Charity & Causes'),
                InterestsContainer(text: 'Party'),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
