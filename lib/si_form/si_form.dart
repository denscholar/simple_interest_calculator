import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SIForm extends StatefulWidget {
  @override
  _SIFormState createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {
   var _currencies = ['Naira', 'Dollar', 'Pound', 'Others'];
  var _currentItemSelected = 'Naira';

  // Create a text controller for the three text field.
   TextEditingController principalController = TextEditingController();
   TextEditingController interestController = TextEditingController();
   TextEditingController termController = TextEditingController();

//this handles the result display
  var resultDisplay = '';




  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 18.0, color: Colors.white);

    return Scaffold(
//      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Image.asset('images/money.png',
                    width: 100.0, height: 100.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
              child: TextField(
                controller: principalController,
                style: textStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: ('Principal'),
                    labelStyle: textStyle,
                    hintText: 'Enter principal e.g 1200',
                    hintStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
              child: TextField(
                controller: interestController,
                style: textStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Rate of Interest',
                    labelStyle: textStyle,
                    hintText: 'In Percent',
                    hintStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Container(
              width: 25.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 8.0),
                    child: TextField(
                      controller: termController,
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Term',
                          labelStyle: textStyle,
                          hintText: 'Time in Years',
                          hintStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                ),
                Expanded(
                  child: DropdownButton<String>(
                    items: _currencies.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem,
                        style: textStyle,),
                      );
                    }).toList(),
                    onChanged: (String newValueSelected) {
                      _dropDownSelected(newValueSelected);
                    },
                    value: _currentItemSelected,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child:
                    RaisedButton(
                      color: Colors.black12,
                        child: Text('Calculate', style: textStyle,), onPressed: () {

                        /* call a function of setstate to handle the calculation and create the function
                        down below of calculateTotalReturns

                         */

                      setState(() {
                        resultDisplay = _calculateTotalReturns();
                      });

                    }),
                  ),
                  Expanded(
                    child:
                    RaisedButton(child: Text('Reset', style: textStyle,), onPressed: () {
                      setState(() {
                        reset();
                      });
                    }),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(25.0),
                child: Text(resultDisplay,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400)),
              ),
            )
          ],
        ),
      ),
    );
  }

   void _dropDownSelected(String newValueSelected) {

    setState(() {
      this._currentItemSelected = newValueSelected;
    });


   }

   String _calculateTotalReturns() {

    double principal = double.parse(principalController.text);
    double interest = double.parse(interestController.text);
    int term = int.parse(termController.text);

    /*
    Formula for simple interest
   ------------------------------
    simpleInterest = principal (P * I * T)/100
    */

     double totalAmount = principal + (principal * interest * term)/100;

     String result = 'After $term years, your investment will be worth $totalAmount $_currentItemSelected';

     return result;

   }
//the reset function that handles the reset button
  void reset() {
    //set all the field to blanck screen

    principalController.text = '';
    interestController.text = '';
    termController.text = '';
    resultDisplay = '0';
    _currentItemSelected = _currencies[0];

  }
}






