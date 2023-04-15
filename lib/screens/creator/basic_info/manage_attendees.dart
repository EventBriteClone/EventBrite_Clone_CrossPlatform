import 'package:flutter/material.dart';
import 'package:organizer/components/main_side_menu.dart';
import 'package:organizer/models/basic_info_form.dart';
import 'package:provider/provider.dart';

import '../../../components/inside_side_menu.dart';

import '../../../providers/creator/basic_info_provider.dart';
import '../../../reusable_widgets/app_bar.dart';
import '../../../reusable_widgets/image_widget.dart';

class ManageAttendees extends StatelessWidget {
  const ManageAttendees({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: buildDrawer(context),
      ),
      appBar: AppBarWidget(),
      // drawer: Drawer(),
      body: Container(),
    );
  }
}
