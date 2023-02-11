import 'package:admin/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class SingleTypeScreen extends StatelessWidget {
  const SingleTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Center(child: Text('Single Type'),)
    );
  }
}
