import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/inside_side_menu.dart';

import '../../../providers/creator/basic_info_provider.dart';
import '../../../reusable_widgets/app_bar.dart';
import '../../../reusable_widgets/image_widget.dart';

class Publish extends StatelessWidget {
  const Publish({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: buildDrawer(context),
      ),
      appBar: AppBarWidget(
        appBarText: 'Publish',
      ),
      // drawer: Drawer(),
      body: Container(),
    );
  }
}
