import 'package:flutter/material.dart';



void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
     debugShowCheckedModeBanner: false,
      
       
 home:  HomePage(),
    );
  }


// ignore: must_be_immutable
class HomePage extends StatefulWidget {
   const HomePage({super.key});
   

  @override
  State<HomePage> createState() => _HomePageState();

} 
class _HomePageState extends State<HomePage> {

final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  double bmiResult = 0.0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

@override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar ( title:const Text('BMI Calculator',
        style: TextStyle(color:Color(0xFF0202FF),fontSize:30,fontWeight: FontWeight.bold )),backgroundColor: Colors.grey[200]),
        body: Center(
          child: SizedBox( 
            
            width: 370,
            child: Column(
            children: [
              
             Form(
                 key: _formKey,
                 autovalidateMode: AutovalidateMode.onUserInteraction,
                 child:TextFormField(
                 controller: heightController,
                 keyboardType: TextInputType.number,
                 decoration: const InputDecoration(
                 focusColor: Colors.blue,
                 labelText: 'height(cm)'),

  
          validator: (value) {
          if (value == null || value.isEmpty) {
           return 'Please enter a height';}
    
          double height = double.parse(value);
          if (height < 20 || height > 180) {
           return 'Height must be between 20 and 180';}  
           return null; },
 
)),

Container(height: 30),

Form(
    key: _formKey1,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    child:TextFormField(
   controller: weightController,
   keyboardType: TextInputType.number,
   decoration: const InputDecoration(
    focusColor: Colors.blue,
    labelText: 'weight(kg)',
    
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a weight';
    }
    int weight = int.parse(value);
    if (weight <= 0) {
      return 'Weight must be higher than 0';
    }
    return null;
  }  
 
     
)),
           const SizedBox(height: 30),
          ElevatedButton(
                onPressed: () {
                  if (heightController.text.isNotEmpty &&
                      weightController.text.isNotEmpty) {
                    calculateBMI(
                      weight: double.parse(weightController.text),
                      height: double.parse(heightController.text) / 100,
                    );
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                child: const Text('CALCULATE',style:TextStyle(color: Color(0xFF0011FF),fontSize: 20)),
              
              ), const SizedBox(height: 20.0),
              bmiResult > 0.0
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0034F1).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Result:',
                            style: TextStyle(fontSize: 30.0),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            bmiResult.toStringAsFixed(2),
                            style: const TextStyle(fontSize: 35.0),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            determineCategory(bmiResult),
                            style: const TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 20.0),
              bmiResult > 0.0
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          bmiResult = 0.0;
                          heightController.clear();
weightController.clear();
                        });
                      },
                      child: const Text('CLEAR',style:TextStyle(color: Color(0xFF0011FF))),
                    )
                  : const SizedBox.shrink(),],
          )),
        ));
 
}


void calculateBMI({required double weight, required double height}) {
    final double bmi = weight / (height * height);
    setState(() {
      bmiResult = bmi;
    });
  }

  String determineCategory(double bmiResult) {
    if (bmiResult < 1) {
      return '';
    } else if (bmiResult < 18.5) {
      return 'Underweight: you should eat more nutritious food ';
    } else if (bmiResult < 25) {
      return 'Normal Weight';
    } else if (bmiResult < 30) {
      return 'Overweight: you should take care of your deit and exercise more often';
    } else if (bmiResult <= 34.9) {
      return 'Obesity Class I : you should visit a nutritionist to change your deit and exercise more often if possible';
    } else if (bmiResult <= 39.9) {
      return 'Obesity Class II: you should visit a nutritionist to change your deit to avoid health problems';
    } else {
      return 'Obesity Class III: you should visit a nutritionist to change your deit to avoid health problems';
    }
  }
}