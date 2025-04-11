import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;

import '../models/generic/resultModel.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);
}

abstract class BaseState<T extends BasePage> extends State<T> {
  double width = 0.0;
  double height = 0.0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Delay access to MediaQuery by using post-frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateScreenSize();
    });
  }

  void _updateScreenSize() {
    final screenSize = MediaQuery.of(context).size;
    setState(() {
      width = screenSize.width;
      height = screenSize.height;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // You can add logic here for dependencies that may change, if needed
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Abstract method for child widgets to override with their UI content
  //Widget buildPageContent(BuildContext context);

  // Loader or common widgets can be added here if needed
  Widget loader() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 28.0),
      child: SizedBox.square(
        dimension: 40.0,
        child: CircularProgressIndicator(),
      ),
    );
  }

  bool handleResponse(Result? response) {
      final result = response;
      if (result?.validation != null) {
        showErrorSnackBar(context, result?.validation?.message);
      } else if(result?.errorMessage != null) {
        showErrorSnackBar(
            context,
             result?.errorMessage
                );
      }
     return result?.isSuccess ?? false;
  }

  showErrorSnackBar(BuildContext context, String? msg) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(msg ?? "")));
    });
  }
}
