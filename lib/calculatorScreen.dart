import "package:flutter/material.dart";

class Calculatorscreen extends StatefulWidget {
  const Calculatorscreen({super.key});

  @override
  State<Calculatorscreen> createState() => _CalculatorscreenState();
}

class _CalculatorscreenState extends State<Calculatorscreen> {
  var displayValue = "";
  void addvalues(value) {
    setState(() {
      displayValue += value;
    });
  }

  void delete() {
    setState(() =>
        displayValue = displayValue.substring(0, displayValue.length - 1));
  }

  double num1 = 0.0;
  String operation = '';
  String currentInput = '';
  double result = 0.0;
  double tempResult = 0.0;

  void maths(String button) {
    if (isNumber(button)) {
      // If the button is a number
      setState(() {
        displayValue += button;
      });
      currentInput += button;
      display(currentInput); // Display the current input
    } else if (['+', '-', 'x', '/'].contains(button)) {
      // If the button is an operator
      setState(() {
        displayValue += button;
      });
      if (tempResult == 0.0) {
        num1 = double.parse(currentInput);
      } else {
        num1 = tempResult;
      }

      operation = button;
      currentInput = '';
    } else if (button == '=') {
      // If the button is '='
      double num2 = double.parse(currentInput);

      // Perform the operation
      if (operation == '+') {
        setState(() {
          result = num1 + num2;
        });
        //result = num1 + num2;
      } else if (operation == '-') {
        setState(() {
          result = num1 - num2;
        });
        //result = num1 - num2;
      } else if (operation == 'x') {
        setState(() {
          result = num1 * num2;
        });
        //result = num1 * num2;
      } else if (operation == '/') {
        setState(() {
          result = num1 / num2;
        });
      }else if (operation == "%"){
        
      }

      // Display and prepare for the next calculation
      display(result);

      num1 = result;
      tempResult = result;
      currentInput = "";
      operation = '';
    }
  }

  bool isNumber(String str) {
    // Check if the string is a number
    return double.tryParse(str) != null;
  }

  void display(dynamic value) {
    print(
        value); // You can replace this with logic to update the calculator display in your app's UI
  }

  void clear() {
    setState(
      () {
        displayValue = "";
        result = 0.0;
        tempResult = 0.0;
      },
    );

  }

  final List<Map<String, dynamic>> boxData = [
    {
      "color": Colors.red,
      "content":
          const Text("c", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": Colors.blue,
      "content":
          const Text("/", style: TextStyle(color: Colors.white, fontSize: 30))
    },
    {
      "color": Colors.green,
      "content":
          const Text("x", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": Colors.green,
      "content": const Icon(Icons.close_rounded, color: Colors.white, size: 24),
    },
    {
      "color": Colors.green,
      "content": const Text(
        "7",
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    },
    {
      "color": Colors.green,
      "content":
          const Text("8", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": Colors.green,
      "content":
          const Text("9", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": Colors.green,
      "content":
          const Text("-", style: TextStyle(color: Colors.white, fontSize: 40))
    },
    {
      "color": Colors.green,
      "content":
          const Text("4", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": Colors.green,
      "content":
          const Text("5", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": Colors.green,
      "content":
          const Text("6", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": Colors.green,
      "content":
          const Text("+", style: TextStyle(color: Colors.white, fontSize: 30))
    },
    {
      "color": Colors.green,
      "content":
          const Text("1", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": Colors.green,
      "content":
          const Text("2", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": Colors.green,
      "content":
          const Text("3", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": Colors.green,
      "content":
          const Text("=", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": Colors.green,
      "content":
          const Text("%", style: TextStyle(color: Colors.white, fontSize: 24))
    },
    {
      "color": Colors.green,
      "content":
          const Text("0", style: TextStyle(color: Colors.white, fontSize: 24)),
    },
    {
      "color": Colors.green,
      "content":
          const Text(".", style: TextStyle(color: Colors.white, fontSize: 40))
    },
    {
      "color": Colors.green,
      "content":
          const Text("=", style: TextStyle(color: Colors.white, fontSize: 24))
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
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
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
                      color: const Color.fromARGB(
                          209, 34, 33, 33), // Color of each square
                      child: InkWell(
                        onTap: () => {
                          // if(index == 0){
                          //   clear()
                          // }else if(index == 3){
                          //   delete()
                          // }else if( index == 1 || index == 2 || index == 7 || index == 11 || index == 16 ){
                          //   addvalues(box['content'].data)
                          // }
                          // else
                          // maths(box['content'].data),
                          if (box["content"] is Icon &&
                              box["content"].icon == Icons.close_rounded)
                            {delete()}
                          else if (box["content"].data == "c")
                            {clear()}
                          else
                            {
                              maths(box['content'].data),
                            },
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
