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
        children: const [
           SafeArea(
            child: Text(
              "You're Interested in:",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
           SizedBox(
            height: 50,
          ),
          InterestsContainer(
            text: 'Food',
          ),
        ],
      ),
    );
  }
}
