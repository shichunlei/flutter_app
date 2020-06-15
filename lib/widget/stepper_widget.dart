import 'package:flutter/material.dart';

class StepperWidget extends StatefulWidget {
  @override
  createState() => StepperWidgetState();
}

class StepperWidgetState extends State<StepperWidget> {
  /// init the step to 0th position
  int currentStep = 0;
  List<Step> steps = [
    Step(
        // Title of the Step
        title: Text("Step 1"),
        // Content, it can be any widget here. Using basic Text for this example
        content: Text("Hello!"),
        state: StepState.error,
        isActive: true),
    Step(
        title: Text("Step 2"),
        content: Text("World!"),
        // You can change the style of the step icon i.e number, editing, etc.
        state: StepState.editing,
        isActive: true),
    Step(
        title: Text("Step 3"),
        content: Text("Hello World!"),
        state: StepState.complete,
        isActive: true)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Stepper Widget"),
        ),
        body: Container(
            child: Stepper(

                /// Using a variable here for handling the currentStep
                currentStep: this.currentStep,

                /// List the steps you would like to have
                steps: steps,

                /// Define the type of Stepper style
                /// StepperType.horizontal :  Horizontal Style
                /// StepperType.vertical   :  Vertical Style
                type: StepperType.vertical,

                /// Know the step that is tapped
                onStepTapped: (step) {
                  /// On hitting step itself, change the state and jump to that step
                  setState(() {
                    /// update the variable handling the current step value jump to the tapped step
                    currentStep = step;
                  });

                  /// Log function call
                  print("onStepTapped : " + step.toString());
                },

                /// On hitting cancel button, change the state
                onStepCancel: () {
                  setState(() {
                    /// update the variable handling the current step value
                    /// going back one step i.e subtracting 1, until its 0
                    if (currentStep > 0) {
                      currentStep = currentStep - 1;
                    } else {
                      currentStep = 0;
                    }
                  });

                  /// Log function call
                  print("onStepCancel : " + currentStep.toString());
                },

                /// On hitting continue button, change the state
                onStepContinue: () {
                  setState(() {
                    /// update the variable handling the current step value
                    /// going back one step i.e adding 1, until its the length of the step
                    if (currentStep < steps.length - 1) {
                      currentStep = currentStep + 1;
                    } else {
                      currentStep = 0;
                    }
                  });

                  /// Log function call
                  print("onStepContinue : " + currentStep.toString());
                })));
  }
}
