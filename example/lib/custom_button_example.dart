import 'package:customized/customized.dart';
import 'package:flutter/material.dart';

class CustomButtonExample extends StatefulWidget {
  CustomButtonExample({Key key}) : super(key: key);

  @override
  _CustomButtonExampleState createState() => _CustomButtonExampleState();
}

class _CustomButtonExampleState extends State<CustomButtonExample> {
  Color _grey300 = Colors.grey[300];
  Color _green = Colors.green;
  Color _green50 = Colors.green[50];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Txt(
              'click_message',
              textSize: 28,
              textAlign: TextAlign.center,
              builderText: (value) => 'Click here',
            ),
            Txt('DefaultButton'),
            SizedBox(
              height: 16,
            ),
            DefaultButton(
              value: 'Click',
              activeColor: Colors.green,
              textColor: Colors.white,
              onPressed: () {},
            ),
            SizedBox(
              height: 16,
            ),
            Divider(),
            SizedBox(
              height: 16,
            ),
            Txt(
              'CustomProgressButton',
            ),
            SizedBox(
              height: 16,
            ),
            CustomProgressButton(
              isLoading: isLoading,
              border: 16.0,
              ignorePlatform: true,
              onPressed: () async {
                setState(() => isLoading = !isLoading);
                await Future.delayed(Duration(seconds: 2));
                setState(() => isLoading = !isLoading);
              },
              value: 'Click',
              activeColor: _green,
            )
          ],
        ),
      ),
    );
  }
}
