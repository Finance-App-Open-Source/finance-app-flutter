import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, current) {
        // final title = current?.location;
        return Scaffold(
          // appBar: AppBar(
          //   title: Text(title ?? ''),
          //   centerTitle: true,
          // ),
          resizeToAvoidBottomInset: false,
          body: GetRouterOutlet(initialRoute: Routes.HISTORY_TRANSACTIONS),
        );
      },
    );
  }
}
