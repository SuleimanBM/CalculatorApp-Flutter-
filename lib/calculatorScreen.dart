import "package:flutter/material.dart";

class Calculatorscreen extends StatefulWidget {
  const Calculatorscreen({super.key});

  @override
  State<Calculatorscreen> createState() => _CalculatorscreenState();
}

class _CalculatorscreenState extends State<Calculatorscreen> {
  var displayValue = "";
  double num1 = 0.0;
  double num2 = 0.0;
  String operation = '';
  String prevOperation = '';
  String currentInput = '';
  double result = 0.0;
  double tempResult = 0.0;
  String num = '';
  double size = 30;

  void addvalues(value) {
    setState(() {
      displayValue += value;
    });
  }

  void delete() {
    if (displayValue.isNotEmpty) {
      setState(() {
        // Remove the last character
        displayValue = displayValue.substring(0, displayValue.length - 1);
      });

      // Recompute the calculations
      parseAndCompute(displayValue);
    } else {
      // If display is empty, reset values
      setState(() {
        num1 = 0.0;
        num2 = 0.0;
        operation = '';
        currentInput = '';
        result = 0.0;
      });
    }
  }

  void parseAndCompute(String expression) {
    // Reset all values
    num1 = 0.0;
    num2 = 0.0;
    operation = '';
    result = 0.0;

    String current = '';
    bool isOperator(String char) => ['+', '-', 'x', '/', '%'].contains(char);

    for (int i = 0; i < expression.length; i++) {
      String char = expression[i];

      if (isNumber(char)) {
        current += char;
      } else if (isOperator(char)) {
        if (num1 == 0.0) {
          num1 = double.parse(current);
        } else {
          num2 = double.parse(current);
          calculateIntermediateResult(); // Perform intermediate calculation
          num1 = result; // Chain the result
        }
        operation = char;
        current = ''; // Reset for the next number
      }
    }

    // Handle the final number
    if (current.isNotEmpty) {
      num2 = double.tryParse(current) ?? 0.0;
      if (operation.isNotEmpty) {
        calculateIntermediateResult();
      } else {
        result = num1;
      }
    }

    // Update the display with the final result
    display(result);
  }

  void maths([String? button]) {
    if (button == null) {
      return; // Exit the function if button is null
    }
    if (isNumber(button)) {
      // If the button is a number
      setState(() {
        displayValue += button; // Append to display
      });
      currentInput += button;
      //print(button);

      if (operation.isNotEmpty) {
        // If there's already an operator, update num2

        num += currentInput;
        num2 = double.parse(num);
        calculateIntermediateResult(); // Perform dynamic calculation
      } else {
        // If there's no operator yet, update num1
        num1 = double.parse(currentInput);
        display(num1); // Display the first number
      }
    } else if (['+', '-', 'X', '/', '%'].contains(button)) {
      if (result != 0.0) {
        num1 = result;
        num = '';
      }

      // If the button is an operator
      if (currentInput.isEmpty && result == 0.0) {
        display("Error: Enter a number first");
        return;
      }

      if (operation.isNotEmpty && currentInput.isNotEmpty) {
        // If there's already an operator, finalize the current calculation
        num2 += double.parse(currentInput);
        calculateIntermediateResult();
      }

      // Set the new operator and reset input
      setState(() {
        displayValue += button; // Append operator to display
      });
      operation = button;
      if (operation == "%") {
        calculateIntermediateResult();
      }
      currentInput = ''; // Clear current input for the next number
    } else if (button == '=') {
      // If the button is '='
      if (operation.isNotEmpty && currentInput.isNotEmpty) {
        num2 = double.parse(currentInput);
        calculateIntermediateResult(); // Perform the final calculation
        display(result);
        resetAfterEquals(); // Prepare for a new calculation
      } else {
        display("Error: Invalid input");
      }
    }
  }

// Function to perform the intermediate calculation
  void calculateIntermediateResult() {
    if (operation == '+') {
      result = num1 + num2;
    } else if (operation == '-') {
      result = num1 - num2;
    } else if (operation == 'X') {
      result = num1 * num2;
    } else if (operation == '/') {
      if (num2 == 0.0) {
        display("Error: Division by zero");
        return;
      }
      result = num1 / num2;
    } else if (operation == "%") {
      display(operation);
      // if (num2 == 0.0) {
      //   display("Error: Division by zero");
      //   return;
      // }
      result = num1 * 0.01; // Handles floating-point remainder
      //result = num1 - (num2 * (num1 ~/ num2)); // Handles floating-point remainder
    }

    // Update num1 for chaining operations
    //num1 = result;
    currentInput = '';
    // setState(() {
    //   currentInput = '';
    // });

    // Display the intermediate result
    display(result);
  }

// Function to reset values after '='
  void resetAfterEquals() {
    num1 = result;
    num2 = 0.0;
    currentInput = '';
    operation = '';
  }

// Helper function to check if a string is a number
  bool isNumber(String str) {
    return double.tryParse(str) != null;
  }

// Function to display a value (update the UI or log to console)
  void display(dynamic value) {
    print(value); // Replace with UI display logic
  }

// Function to clear the calculator
  void clear() {
    setState(() {
      displayValue = "";
      result = 0.0;
      num1 = 0.0;
      num2 = 0.0;
      currentInput = '';
      operation = '';
      num = '';
    });
    display(0); // Reset the display
  }

  final List<Map<String, dynamic>> boxData = [
    {
      "color": const Color.fromARGB(209, 34, 33, 33),
      "content":
          const Text("C", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": const Color.fromARGB(209, 34, 33, 33),
      "content":
          const Text("/", style: TextStyle(color: Colors.amber, fontSize: 30))
    },
    {
      "color": const Color.fromARGB(209, 34, 33, 33),
      "content":
          const Text("X", style: TextStyle(color: Colors.amber, fontSize: 24))
    },
    {
      "color": const Color.fromARGB(209, 34, 33, 33),
      "content": const Icon(Icons.cancel, color: Colors.amber, size: 40),
    },
    {
      "color": const Color.fromARGB(209, 34, 33, 33),
      "content": const Text(
        "7",
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    },
    {
      "color": const Color.fromARGB(209, 34, 33, 33),
      "content":
          const Text("8", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": const Color.fromARGB(209, 34, 33, 33),
      "content":
          const Text("9", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": const Color.fromARGB(209, 34, 33, 33),
      "content":
          const Text("-", style: TextStyle(color: Colors.amber, fontSize: 40))
    },
    {
      "color": const Color.fromARGB(209, 34, 33, 33),
      "content":
          const Text("4", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": const Color.fromARGB(209, 34, 33, 33),
      "content":
          const Text("5", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": const Color.fromARGB(209, 34, 33, 33),
      "content":
          const Text("6", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": const Color.fromARGB(209, 34, 33, 33),
      "content":
          const Text("+", style: TextStyle(color: Colors.amber, fontSize: 30))
    },
    {
      "color": const Color.fromARGB(209, 34, 33, 33),
      "content":
          const Text("1", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": const Color.fromARGB(209, 34, 33, 33),
      "content":
          const Text("2", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": const Color.fromARGB(209, 34, 33, 33),
      "content":
          const Text("3", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": const Color.fromARGB(209, 34, 33, 33),
      "content":
          const Text("=", style: TextStyle(color: Colors.amber, fontSize: 24))
    },
    {
      "color": const Color.fromARGB(209, 34, 33, 33),
      "content":
          const Text("%", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": const Color.fromARGB(209, 34, 33, 33),
      "content":
          const Text("0", style: TextStyle(color: Colors.white, fontSize: 24)),
    },
    {
      "color": const Color.fromARGB(209, 34, 33, 33),
      "content":
          const Text(".", style: TextStyle(color: Colors.white, fontSize: 40))
    },
    {
      "color": Colors.amber,
      "content":
          const Text("", style: TextStyle(color: Colors.white, fontSize: 24))
    },

    // Add more boxes as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(232, 0, 0, 0),
        appBar: AppBar(
          title: const Text("Calculator"),
          centerTitle: true,
        ),
        body: Column(children: [
          Expanded(
            flex: 2,
            child: Container(
                margin: const EdgeInsets.only(bottom: 0),
                height: 300,
                width: double.infinity,
                color: const Color.fromARGB(210, 22, 22, 22),
                alignment: AlignmentDirectional.bottomEnd,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      displayValue,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      result.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size,
                      ),
                    ),
                  ],
                )
                //color: Colors.green
                ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              // height: 400,
              margin: const EdgeInsets.only(bottom: 0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(204, 68, 67, 67),
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(50),
                //   topRight: Radius.circular(50),
                // ),
              ),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Number of squares per row
                    crossAxisSpacing: 2, // Spacing between columns
                    mainAxisSpacing: 2, // Spacing between rows
                  ),
                  itemCount: 20, // Total number of squares (3x3)
                  itemBuilder: (context, index) {
                    final box = boxData[index];
                    return Container(
                      color: box["color"], // Color of each square
                      child: InkWell(
                        onTap: () {
                          if (box["content"] is Icon &&
                              (box["content"] as Icon).icon == Icons.cancel) {
                            delete();
                          } else if (box["content"] is Text &&
                              (box["content"] as Text).data == "C") {
                            clear();
                          } else if (box["content"] is Text) {
                            String buttonValue = (box["content"] as Text).data!;
                            maths(buttonValue);
                          }
                        },
                        child: Center(
                          child: box["content"],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ]));
  }
}
