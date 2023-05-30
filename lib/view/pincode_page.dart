
import 'package:flutter/material.dart';

class SetPinCodePage extends StatefulWidget {
  const SetPinCodePage({super.key});

  @override
  State<SetPinCodePage> createState() => _SetPinCodePageState();
}

class _SetPinCodePageState extends State<SetPinCodePage> {
  List<int> numbers = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    0,
  ];

  String inputText = "";
  List<bool> actives = [false, false, false, false];
  List<bool> clears = [false, false, false, false];
  List<int> values = [1, 2, 2, 1];
  int currentIndex = 0;
  final pinCode = "1234";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
      leading: Padding(
        padding: EdgeInsets.only(left: context.width * 0.02),
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xff1C1C1C),
            )),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      actions: [
        TextButton(
          onPressed: () {},
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Padding(
              padding: EdgeInsets.only(
                  left: context.width * 0.02, right: context.width * 0.05),
              child: Text(
                "Connection",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            )
          ]),
        ),
      ],
    )
,
      backgroundColor: Colors.white,
      body: Column(
        children: [
           Padding(
             padding:  EdgeInsets.only(top:context.height*0.05 ),
             child: Center(
              child: Text(
                "PIN code installation",
                               style: Theme.of(context).textTheme.bodyLarge,
           
              ),
                     ),
           ),SizedBox(height: context.height*0.03,),
          Expanded(
              flex: 1,
              child: Center(
                child: SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                       Text("Enter the PIN code below and confirm it"
                       ,style: Theme.of(context).textTheme.displaySmall,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < actives.length; i++)
                            PasswordBurning(
                              clear: clears[i],
                              active: actives[i],
                              value: values[i],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 4,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.7 / 0.6, crossAxisCount: 3),
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(4.0),
                  width: 50,
                  height: 50,
                  child: index == 9
                      ? const SizedBox()
                      : Center(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: index == 9
                                        ? Colors.black
                                        : const Color(0xffE4E4E4)),
                                borderRadius: BorderRadius.circular(25)),
                            child: MaterialButton(
                                onPressed: () {
                                  if (index == 11) {
                                    if (inputText.isNotEmpty) {
                                      inputText = inputText.substring(
                                          0, inputText.length - 1);
                                      clears =
                                          clears.map((e) => false).toList();
                                      currentIndex--;
                                    } else {
                                      inputText = "";
                                    }
                                    if (currentIndex >= 0) {
                                      setState(() {
                                        clears[currentIndex] = true;
                                        actives[currentIndex] = false;
                                      });
                                    } else {
                                      currentIndex = 0;
                                    }
                                    return;
                                  } else {
                                    inputText +=
                                        numbers[index == 10 ? index - 1 : index]
                                            .toString();
                                    if (inputText.length == 4) {
                                      setState(() {
                                        clears =
                                            clears.map((e) => true).toList();
                                        actives =
                                            actives.map((e) => false).toList();
                                      });
                                      if (inputText == pinCode) {
                                       
                                      } else {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return const Center(
                                                child: Text(
                                                    "Password is incorrect"));
                                          },
                                        );
                                      }
                                      inputText = "";
                                      currentIndex = 0;
                                      return;
                                    }
                                    clears = clears.map((e) => false).toList();
                                    setState(() {
                                      actives[currentIndex] = true;
                                      currentIndex++;
                                    });
                                  }
                                },
                                minWidth: 50,
                                height: 50,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: index == 11
                                    ? const Icon(Icons.backspace)
                                    : Text(
                                        "${numbers[index == 10 ? index - 1 : index]}",
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      )),
                          ),
                        ),
                ),
                itemCount: 12,
              )),
        ],
      ),
    );
  }
}

class PasswordBurning extends StatefulWidget {
  final bool clear;
  final int value;
  final bool active;
  const PasswordBurning(
      {super.key, this.clear = false, this.active = false,required this.value});

  @override
  State<PasswordBurning> createState() => _PasswordBurningState();
}

class _PasswordBurningState extends State<PasswordBurning>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {

    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.clear) {
      animationController!.forward(from: 0);
    }
    return AnimatedBuilder(
      animation: animationController!,
      builder: (context, child) {
        return Container(
            margin: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: widget.active
                            ? const Color(0xff212640)
                            : const Color(0xffE4E4E4)),
                    color:
                        widget.active ? const Color(0xff212640) : Colors.white,
                  ),
                ),
              ],
            ));
      },
    );
  }
}


extension SizeBuildContext on BuildContext{
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}