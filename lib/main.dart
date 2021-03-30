import 'dart:math';

import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<DropdownMenuItem<String>> listDrop = [];
  List<String> drop = ["Male", "Female"];
  final TextEditingController _agecontroller = TextEditingController();
  final TextEditingController _heightcontroller = TextEditingController();
  final TextEditingController _weightcontroller = TextEditingController();
  final TextEditingController _waistcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int age=0;
  double height = 0.0, weight = 0.0, waist = 0.0,bmi=0.0, absi = 0.0, absi_z=0.0;
  String selectedGender="Male",risk="";

  void _trySubmitForm() {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      print('Everything looks good!');
      print(age);
      print(height);
      print(weight);
      print(waist);

      /* 
      Continute proccessing the provided information with your own logic 
      such us sending HTTP requests, savaing to SQLite database, etc.
      */
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('ABSI Calculator'),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: SingleChildScrollView(
          child: Form(
                    key:_formKey,
          child: Container(
            width: double.infinity,
            color: Colors.orange[100],
              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
              child:Column(
                children: <Widget>[
            Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Sex: ",style:TextStyle(fontSize:17,fontWeight: FontWeight.bold,color: Colors.black)),
                      Container(width:99),
               DropdownButton<String>(
               value: selectedGender,
                onChanged: (newValue){
                  setState((){
                    selectedGender = newValue;
                  });
                },
                items:drop.map((gender){
                  return DropdownMenuItem(
                    child: Center(child:Text(gender),),
                    value: gender,
                  );
                }).toList(),
            ),
                    ],
                    ), 
            Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: TextFormField(
                  style: TextStyle(
                    fontSize: 17.0,
                    height: 1.5,
                    color: Colors.black
                  ),
                  decoration: InputDecoration(
                    labelText: "Age: ",
                    suffix: Text('years'),
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.0),                    
                    ),
                  ),
                 validator: (value) {
                          if (value.trim().isEmpty) {
                            return 'Please enter your age.';
                          }
                         if (!(value.startsWith(new RegExp(r'((?<!-)\b([2-9]|[1-8][0-5])\b)' )))){
                            return "Age must between 2 and 85 years.";
                          }
                          return null;
                 },
                 onChanged: (value) => age = value as int,

                keyboardType: TextInputType.numberWithOptions(),
                controller: _agecontroller,
              ),
             ),

            Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: TextFormField(
                  style: TextStyle(
                    fontSize: 17.0,
                    height: 1.5,
                    color: Colors.black
                  ),
                  decoration: InputDecoration(
                    labelText: "Height: ",
                    suffix: Text('cm'),
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.0),
                    ), 
                  ),
                  validator: (value) {
                          if (value.trim().isEmpty) {
                            return 'Please enter your height.';
                          }
                         if (!(value.startsWith(new RegExp(r'((?<!-)\b(^0*([1-2]\d{2,}|[5-9]\d)$)\b)' )))){
                            return "Height must between 50 and\n300cm.";
                          }
                          return null;
                 },
                keyboardType: TextInputType.numberWithOptions(),
                controller: _heightcontroller,
              ),
            ),

            Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: TextFormField(
                  style: TextStyle(
                    fontSize: 17.0,
                    height: 1.5,
                    color: Colors.black
                  ),
                  decoration: InputDecoration(
                    labelText: "Weight: ",
                    suffix: Text('kg'),
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.0),
                    ), 
                  ),
                  validator: (value) {
                          if (value.trim().isEmpty) {
                            return 'Please enter your weight.';
                          }
                         if (!(value.startsWith(new RegExp(r'((?<!-)\b([1-9]|[1-9][0-9]|[1-9][0-9][0-9])\b)' )))){
                            return "Weight needs to be a positive\nvalue.";
                          }
                          return null;
                 },
                keyboardType: TextInputType.numberWithOptions(),
                controller: _weightcontroller,
              ),
            ),
 
          Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: TextFormField(
                  style: TextStyle(
                    fontSize: 17.0,
                    height: 1.5,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: "Waist circumference: ",
                    suffix: Text('cm'),
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.0),
                    ), 
                  ),
                   validator: (value) {
                          if (value.trim().isEmpty) {
                            return 'Please enter your waist\ncirmcumference.';
                          }
                         if (value.startsWith(new RegExp(r'((?<!-)\b([0-9]|[12][0-9]|3[00])\b)' ))) {
                            return "Waist circumference must\ngreater than 30cm.";
                          }
                          return null;
                 },
                 onChanged: (value) => age = value as int,
                keyboardType: TextInputType.numberWithOptions(),
                controller: _waistcontroller,
              ),
            ),
       


            Padding(
              padding: EdgeInsets.all(5),
              child: RaisedButton(
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                color: Colors.deepOrangeAccent,
                child: Text("Get Result",
                style: TextStyle(
                  fontSize: 20.0 ),),
                  onPressed:(){
                    _trySubmitForm();
                    _calculateABSI();
                  }
              ),
            ),
            Text("ABSI: "+absi.toStringAsFixed(5),style:TextStyle(fontSize:17,fontWeight:FontWeight.bold)),
            Text("ABSI z-score: "+absi_z.toStringAsFixed(3),style:TextStyle(fontSize:17,fontWeight: FontWeight.bold)),
            Text(""+risk,style:TextStyle(fontSize:15,color:Colors.red,fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    ),
    ),
        )
    );
  }


  void _calculateABSI() { 
    setState(() { 
      age=int.parse(_agecontroller.text);
      height=double.parse(_heightcontroller.text)/100;
      weight=double.parse(_weightcontroller.text);
      waist=double.parse(_waistcontroller.text)/100;
      bmi = weight / (height*height);
      absi=(waist/(pow(bmi,2/3)*pow(height, 1/2)));
      if (selectedGender == "Male") {
        if (age == 2) {
          absi_z = (absi - 0.07890) / 0.00384;
        } else if (age == 3) {
          absi_z = (absi - 0.07915) / 0.00384;
        } else if (age == 4) {
          absi_z = (absi - 0.07937) / 0.00383;
        } else if (age == 5) {
          absi_z = (absi - 0.07955) / 0.00383;
        } else if (age == 6) {
          absi_z = (absi - 0.07964) / 0.00382;
        } else if (age == 7) {
          absi_z = (absi - 0.07966) / 0.00382;
        } else if (age == 8) {
          absi_z = (absi - 0.07958) / 0.0382;
        } else if (age == 9) {
          absi_z = (absi - 0.07942) / 0.00381;
        } else if (age == 10) {
          absi_z = (absi - 0.07917) / 0.00381;
        } else if (age == 11) {
          absi_z = (absi - 0.07886) / 0.00381;
        } else if (age == 12) {
          absi_z = (absi - 0.07849) / 0.00380;
        } else if (age == 13) {
          absi_z = (absi - 0.0781) / 0.00380;
        } else if (age == 14) {
          absi_z = (absi - 0.07772) / 0.00380;
        } else if (age == 15) {
          absi_z = (absi - 0.07739) / 0.00379;
        } else if (age == 16) {
          absi_z = (absi - 0.07716) / 0.00379;
        } else if (age == 17) {
          absi_z = (absi - 0.07703) / 0.00378;
        } else if (age == 18) {
          absi_z = (absi - 0.07702) / 0.00378;
        } else if (age == 19) {
          absi_z = (absi - 0.07711) / 0.00378;
        } else if (age == 20) {
          absi_z = (absi - 0.07728) / 0.00377;
        } else if (age == 21) {
          absi_z = (absi - 0.0775) / 0.00377;
        } else if (age == 22) {
          absi_z = (absi - 0.07777) / 0.00377;
        } else if (age == 23) {
          absi_z = (absi - 0.07804) / 0.00376;
        } else if (age == 24) {
          absi_z = (absi - 0.07831) / 0.00376;
        } else if (age == 25) {
          absi_z = (absi - 0.07858) / 0.00376;
        } else if (age == 26) {
          absi_z = (absi - 0.07882) / 0.00375;
        } else if (age == 27) {
          absi_z = (absi - 0.07904) / 0.00375;
        } else if (age == 28) {
          absi_z = (absi - 0.07922) / 0.00374;
        } else if (age == 29) {
          absi_z = (absi - 0.07938) / 0.00374;
        } else if (age == 30) {
          absi_z = (absi - 0.07951) / 0.00374;
        } else if (age == 31) {
          absi_z = (absi - 0.07963) / 0.00373;
        } else if (age == 32) {
          absi_z = (absi - 0.07975) / 0.00373;
        } else if (age == 33) {
          absi_z = (absi - 0.07988) / 0.00373;
        } else if (age == 34) {
          absi_z = (absi - 0.08) / 0.00372;
        } else if (age == 35) {
          absi_z = (absi - 0.08013) / 0.00372;
        } else if (age == 36) {
          absi_z = (absi - 0.08027) / 0.00371;
        } else if (age == 37) {
          absi_z = (absi - 0.08042) / 0.00371;
        } else if (age == 38) {
          absi_z = (absi - 0.08057) / 0.00371;
        } else if (age == 39) {
          absi_z = (absi - 0.08072) / 0.0037;
        } else if (age == 40) {
          absi_z = (absi - 0.08087) / 0.0037;
        } else if (age == 41) {
          absi_z = (absi - 0.08102) / 0.0037;
        } else if (age == 42) {
          absi_z = (absi - 0.08117) / 0.00369;
        } else if (age == 43) {
          absi_z = (absi - 0.08132) / 0.00369;
        } else if (age == 44) {
          absi_z = (absi - 0.08148) / 0.00368;
        } else if (age == 45) {
          absi_z = (absi - 0.08165) / 0.00368;
        } else if (age == 46) {
          absi_z = (absi - 0.08183) / 0.00368;
        } else if (age == 47) {
          absi_z = (absi - 0.08201) / 0.00367;
        }  else if (age == 48) {
          absi_z = (absi - 0.08221) / 0.00367;
        } else if (age == 49) {
          absi_z = (absi - 0.0824) / 0.00367;
        } else if (age == 50) {
          absi_z = (absi - 0.0826) / 0.00366;
        } else if (age == 51) {
          absi_z = (absi - 0.08279) / 0.00366;
        } else if (age == 52) {
          absi_z = (absi - 0.08297) / 0.00365;
        } else if (age == 53) {
          absi_z = (absi - 0.08315) / 0.00365;
        } else if (age == 54) {
          absi_z = (absi - 0.08334) / 0.00365;
        } else if (age == 55) {
          absi_z = (absi - 0.08352) / 0.00364;
        } else if (age == 56) {
          absi_z = (absi - 0.08369) / 0.00364;
        } else if (age == 57) {
          absi_z = (absi - 0.08386) / 0.00364;
        }else if (age == 58) {
          absi_z = (absi - 0.08403) / 0.00363;
        } else if (age == 59) {
          absi_z = (absi - 0.08419) / 0.00363;
        } else if (age == 60) {
          absi_z = (absi - 0.08436) / 0.00362;
        } else if (age == 61) {
          absi_z = (absi - 0.08454) / 0.00362;
        } else if (age == 62) {
          absi_z = (absi - 0.08471) / 0.00362;
        } else if (age == 63) {
          absi_z = (absi - 0.08489) / 0.00361;
        } else if (age == 64) {
          absi_z = (absi - 0.08506) / 0.00361;
        } else if (age == 65) {
          absi_z = (absi - 0.08522) / 0.0036;
        } else if (age == 66) {
          absi_z = (absi - 0.08537) / 0.0036;
        } else if (age == 67) {
          absi_z = (absi - 0.08551) / 0.0036;
        }  else if (age == 68) {
          absi_z = (absi - 0.08565) / 0.00359;
        } else if (age == 69) {
          absi_z = (absi - 0.08578) / 0.00359;
        } else if (age == 70) {
          absi_z = (absi - 0.08591) / 0.00359;
        } else if (age == 71) {
          absi_z = (absi - 0.08604) / 0.00358;
        } else if (age == 72) {
          absi_z = (absi - 0.08616) / 0.00358;
        } else if (age == 73) {
          absi_z = (absi - 0.08629) / 0.00357;
        } else if (age == 74) {
          absi_z = (absi - 0.08641) / 0.00357;
        } else if (age == 75) {
          absi_z = (absi - 0.08653) / 0.00357;
        } else if (age == 76) {
          absi_z = (absi - 0.08665) / 0.00356;
        } else if (age == 77) {
          absi_z = (absi - 0.08675) / 0.00356;
        } else if (age == 78) {
          absi_z = (absi - 0.08685) / 0.00355;
        } else if (age == 79) {
          absi_z = (absi - 0.08695) / 0.00355;
        } else if (age == 80) {
          absi_z = (absi - 0.08705) / 0.00355;
        } else if (age == 81) {
          absi_z = (absi - 0.08714) / 0.00354;
        } else if (age == 82) {
          absi_z = (absi - 0.08723) / 0.00354;
        } else if (age == 83) {
          absi_z = (absi - 0.08732) / 0.00354;
        } else if (age == 84) {
          absi_z = (absi - 0.08742) / 0.00353;
        } else if (age == 85) {
          absi_z = (absi - 0.08811) / 0.00356;
        }

        print(absi_z);
      }
        else if (selectedGender == "Female") {
        if (age == 2) {
          absi_z = (absi - 0.08031) / 0.00363;
        } else if (age == 3) {
          absi_z = (absi - 0.08016) / 0.00366;
        }  else if (age == 4) {
          absi_z = (absi - 0.8001) / 0.00369;
        } else if (age == 5) {
          absi_z = (absi - 0.07985) / 0.00372;
        } else if (age == 6) {
          absi_z = (absi - 0.07969) / 0.00375;
        } else if (age == 7) {
          absi_z = (absi - 0.07952) / 0.00378;
        } else if (age == 8) {
          absi_z = (absi - 0.07935) / 0.0380;
        } else if (age == 9) {
          absi_z = (absi - 0.07917) / 0.00383;
        } else if (age == 10) {
          absi_z = (absi - 0.07899) / 0.00386;
        } else if (age == 11) {
          absi_z = (absi - 0.07881) / 0.00389;
        } else if (age == 12) {
          absi_z = (absi - 0.07863) / 0.00392;
        } else if (age == 13) {
          absi_z = (absi - 0.07846) / 0.00395;
        } else if (age == 14) {
          absi_z = (absi - 0.07829) / 0.00397;
        } else if (age == 15) {
          absi_z = (absi - 0.07814) / 0.0040;
        } else if (age == 16) {
          absi_z = (absi - 0.07799) / 0.00403;
        } else if (age == 17) {
          absi_z = (absi - 0.07787) / 0.00406;
        } else if (age == 18) {
          absi_z = (absi - 0.07775) / 0.00408;
        } else if (age == 19) {
          absi_z = (absi - 0.07765) / 0.00411;
        } else if (age == 20) {
          absi_z = (absi - 0.07757) / 0.00414;
        } else if (age == 21) {
          absi_z = (absi - 0.0775) / 0.00416;
        } else if (age == 22) {
          absi_z = (absi - 0.07744) / 0.00419;
        } else if (age == 23) {
          absi_z = (absi - 0.0774) / 0.00422;
        } else if (age == 24) {
          absi_z = (absi - 0.07737) / 0.00424;
        } else if (age == 25) {
          absi_z = (absi - 0.07735) / 0.00432;
        } else if (age == 26) {
          absi_z = (absi - 0.07734) / 0.00429;
        } else if (age == 27) {
          absi_z = (absi - 0.07735) / 0.00432;
        } else if (age == 28) {
          absi_z = (absi - 0.07736) / 0.00435;
        } else if (age == 29) {
          absi_z = (absi - 0.07739) / 0.00437;
        } else if (age == 30) {
          absi_z = (absi - 0.07743) / 0.0044;
        } else if (age == 31) {
          absi_z = (absi - 0.07747) / 0.00442;
        } else if (age == 32) {
          absi_z = (absi - 0.07752) / 0.00445;
        } else if (age == 33) {
          absi_z = (absi - 0.07759) / 0.00447;
        } else if (age == 34) {
          absi_z = (absi - 0.07766) / 0.0045;
        } else if (age == 35) {
          absi_z = (absi - 0.07773) / 0.00452;
        } else if (age == 36) {
          absi_z = (absi - 0.07782) / 0.00454;
        } else if (age == 37) {
          absi_z = (absi - 0.0779) / 0.00457;
        } else if (age == 38) {
          absi_z = (absi - 0.078) / 0.00459;
        } else if (age == 39) {
          absi_z = (absi - 0.0781) / 0.00462;
        } else if (age == 40) {
          absi_z = (absi - 0.0782) / 0.00464;
        } else if (age == 41) {
          absi_z = (absi - 0.07831) / 0.00466;
        } else if (age == 42) {
          absi_z = (absi - 0.07842) / 0.00469;
        } else if (age == 43) {
          absi_z = (absi - 0.07854) / 0.00471;
        } else if (age == 44) {
          absi_z = (absi - 0.07866) / 0.00473;
        } else if (age == 45) {
          absi_z = (absi - 0.07879) / 0.00476;
        } else if (age == 46) {
          absi_z = (absi - 0.07892) / 0.00478;
        } else if (age == 47) {
          absi_z = (absi - 0.07905) / 0.0048;
        }  else if (age == 48) {
          absi_z = (absi - 0.07919) / 0.00483;
        } else if (age == 49) {
          absi_z = (absi - 0.07933) / 0.00485;
        } else if (age == 50) {
          absi_z = (absi - 0.07947)/ 0.00487;
        } else if (age == 51) {
          absi_z = (absi - 0.07962) / 0.00489;
        } else if (age == 52) {
          absi_z = (absi - 0.07977) / 0.00492;
        } else if (age == 53) {
          absi_z = (absi - 0.07992) / 0.00494;
        } else if (age == 54) {
          absi_z = (absi - 0.08007) / 0.00496;
        } else if (age == 55) {
          absi_z = (absi - 0.08023) / 0.00498;
        } else if (age == 56) {
          absi_z = (absi - 0.08039) / 0.00501;
        } else if (age == 57) {
          absi_z = (absi - 0.08055) / 0.00503;
        }else if (age == 58) {
          absi_z = (absi - 0.08072) / 0.00505;
        } else if (age == 59) {
          absi_z = (absi - 0.08088) / 0.00507;
        } else if (age == 60) {
          absi_z = (absi - 0.08105) / 0.00509;
        } else if (age == 61) {
          absi_z = (absi - 0.08122) / 0.00511;
        } else if (age == 62) {
          absi_z = (absi - 0.08139) / 0.00514;
        } else if (age == 63) {
          absi_z = (absi - 0.08156) / 0.00516;
        } else if (age == 64) {
          absi_z = (absi - 0.08174) / 0.00518;
        } else if (age == 65) {
          absi_z = (absi - 0.08191) / 0.0052;
        } else if (age == 66) {
          absi_z = (absi - 0.08208) / 0.00522;
        } else if (age == 67) {
          absi_z = (absi - 0.08226) / 0.00524;
        }  else if (age == 68) {
          absi_z = (absi - 0.08243) / 0.00526;
        } else if (age == 69) {
          absi_z = (absi - 0.08261) / 0.00528;
        } else if (age == 70) {
          absi_z = (absi - 0.08278) / 0.0053;
        } else if (age == 71) {
          absi_z = (absi - 0.08296) / 0.00533;
        } else if (age == 72) {
          absi_z = (absi - 0.08313) / 0.00535;
        } else if (age == 73) {
          absi_z = (absi - 0.0833) / 0.00537;
        } else if (age == 74) {
          absi_z = (absi - 0.08346) / 0.00539;
        } else if (age == 75) {
          absi_z = (absi - 0.08363) / 0.00541;
        } else if (age == 76) {
          absi_z = (absi - 0.0838) / 0.00543;
        } else if (age == 77) {
          absi_z = (absi - 0.08396) / 0.00545;
        } else if (age == 78) {
          absi_z = (absi - 0.08412) / 0.00547;
        } else if (age == 79) {
          absi_z = (absi - 0.08428) / 0.00549;
        } else if (age == 80) {
          absi_z = (absi - 0.08444) / 0.00551;
        } else if (age == 81) {
          absi_z = (absi - 0.0846) / 0.00553;
        } else if (age == 82) {
          absi_z = (absi - 0.08476) / 0.00555;
        } else if (age == 83) {
          absi_z = (absi - 0.08492) / 0.00557;
        }  else if (age == 84) {
          absi_z = (absi - 0.08508) / 0.00559;
        } else if (age == 85) {
          absi_z = (absi - 0.08533) / 0.00528;
        }
        print(absi_z);
      }
      if (absi_z < -0.868) {
      risk="According to your ABSI z score, your premature mortality risk is very low 👌.";
      } else if (absi_z >= -0.868 && absi_z < -0.272) {
      risk="According to your ABSI z score, your premature mortality risk is low 👍.";
      } else if (absi_z >= -0.272 && absi_z < 0.229) {
      risk="According to your ABSI z score, your premature mortality risk is average ✔️.";
      } else if (absi_z >= 0.229 && absi_z < 0.798) {
      risk="According to your ABSI z score, your premature mortality risk is high ❗.";
      } else if (absi_z >=0.798) {
      risk="According to your ABSI z score, your premature mortality risk is very high ❗❗❗.";
      }
      print(risk);
    }
   );
  }
}