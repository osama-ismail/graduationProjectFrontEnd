import 'package:flutter/material.dart';
import 'package:medilab_prokit/components/MLDoctorChatComponent.dart';
import 'package:medilab_prokit/main.dart';
import 'package:medilab_prokit/screens/PurchaseMoreScreen.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLString.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class MLChatFragment extends StatefulWidget {
  static String tag = '/MLChatFragment';

  @override
  MLChatFragmentState createState() => MLChatFragmentState();
}

class MLChatFragmentState extends State<MLChatFragment> with SingleTickerProviderStateMixin {
  int notificationCounter = 3;
  TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

   getCtegories() {

    var phoneNumber = 'tel:+101';

    launch(phoneNumber);

   }

  Future<void> fetchCategories() async {
    await getCtegories();
    // Other asynchronous tasks
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
    _tabController = TabController(length: 2, vsync: this);
    fetchCategories();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //

    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Container(

        ),
      ),
    );
  }
}
