import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Complimently",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _myNum = 0;
  String _userInput = "";
  bool _checked = false;
  int _radioChecked = 0;
  bool _switched = true;
  double _loveMeter = 0.0;
  int _footerIdx = 0;
  final List<String> _compliments = [
    "Delightfull",
    "Scrumptuos",
    "Fabulous",
    "Amazing",
    "Remarkable"
  ];

  void _add() => setState(() => _myNum++);
  void _subtract() => setState(() => _myNum--);
  void _onChange(String value) => setState(() => _userInput = value);
  void _onChecked(bool? checkVal) =>
      setState(() => _checked = checkVal ?? false);
  void _onRadioCheck(int? radioVal) =>
      setState(() => _radioChecked = radioVal ?? 0);
  void _onSwitch(bool val) => setState(() => _switched = val);
  void _onSlide(double val) => setState(() => _loveMeter = val);
  void _onTap(int index) => setState(() => _footerIdx = index);

  Widget makeRadioTiles() {
    List<Widget> radioList = [];
    for (int i = 0; i < 3; i++) {
      radioList.add(
        Radio(value: i, groupValue: _radioChecked, onChanged: _onRadioCheck),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: radioList,
    );
  }

  List<BottomNavigationBarItem> makeFooterItems() {
    List<BottomNavigationBarItem> footerItems = [];

    footerItems.add(
      const BottomNavigationBarItem(
        icon: Icon(Icons.flare_rounded),
        label: "sparkle",
      ),
    );

    footerItems.add(
      const BottomNavigationBarItem(
        icon: Icon(Icons.camera_alt_rounded),
        label: "dazzling",
      ),
    );

    footerItems.add(
      const BottomNavigationBarItem(
        icon: Icon(Icons.whatshot_rounded),
        label: "on fire",
      ),
    );

    return footerItems;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const BackgroundImage(),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Complimently"),
        ),
        drawer: Drawer(
          width: 150.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                padding: const EdgeInsets.all(0.0),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("images/bees.jpg"),
                  fit: BoxFit.cover,
                )),
                child: Icon(
                  Icons.star,
                  size: 90.0,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Things you are:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: ListView.builder(
                        padding: const EdgeInsets.all(0.0),
                        itemCount: _compliments.length,
                        shrinkWrap: true,
                        itemExtent: 45.0,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              const Icon(Icons.star),
                              Text(_compliments[index]),
                            ],
                          );
                        }),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text("Want to know a secret?"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RichText(
                                text: const TextSpan(
                                  text: 'You looked ',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    height: 3.0,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'STUNNING',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(text: ' on:'),
                                  ],
                                ),
                              ),
                              Text("${DateTime.now()}")
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text("Click me"),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              children: [
                Text(_userInput),
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Jane Smith",
                    labelText: "Enter your name",
                    icon: Icon(Icons.people),
                  ),
                  onChanged: _onChange,
                ),
                const SizedBox(height: 30.0),
                const Text("Add some Swagger!"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MathBtn(
                        btnIcon: const Icon(Icons.add),
                        btnFunc: _add,
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      MathBtn(
                        btnIcon: const Icon(Icons.remove),
                        btnFunc: _subtract,
                      ),
                    ],
                  ),
                ),
                Text("Swag level: $_myNum"),
                const ThickDivider(),
                CheckboxListTile(
                  title: const Text("Are you shining bright?"),
                  subtitle: Text(_checked ? "As you should!" : ""),
                  value: _checked,
                  onChanged: _onChecked,
                  controlAffinity: ListTileControlAffinity.leading,
                  secondary: Icon(
                    Icons.diamond_rounded,
                    color: _checked ? Theme.of(context).primaryColor : null,
                  ),
                ),
                const ThickDivider(),
                makeRadioTiles(),
                const ThickDivider(),
                SwitchListTile(
                  value: _switched,
                  onChanged: _onSwitch,
                  title: Text(
                    "Are you feeling loved?",
                    style: TextStyle(
                        fontWeight:
                            _switched ? FontWeight.bold : FontWeight.normal),
                  ),
                  subtitle: _switched
                      ? const Text(
                          "<3 <3 <3",
                          textAlign: TextAlign.center,
                        )
                      : const Text("Let's work on it :("),
                  secondary: _switched
                      ? Icon(
                          Icons.favorite,
                          color: Theme.of(context).primaryColor,
                        )
                      : const Icon(Icons.heart_broken),
                ),
                if (_switched)
                  Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Great! How full is your love tank: ${(_loveMeter * 100).round()}",
                      ),
                      Slider(
                        value: _loveMeter,
                        onChanged: _onSlide,
                      ),
                    ],
                  ),
                const ThickDivider(),
                Expanded(
                  child: Image(
                    image: NetworkImage(
                      _footerIdx == 0
                          ? "https://images.emojiterra.com/google/noto-emoji/unicode-15/color/512px/2728.png"
                          : _footerIdx == 1
                              ? "https://cdn-icons-png.flaticon.com/512/5169/5169909.png"
                              : "https://cdn-icons-png.flaticon.com/512/8722/8722283.png",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Center(
                child: _userInput != ""
                    ? Text("$_userInput, you are Gorgeous!")
                    : const Text("Welcome Bee-You-tiful!"),
              ),
            ));
          },
          child: const Icon(
            Icons.hive,
            color: Colors.white,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: makeFooterItems(),
          onTap: _onTap,
          currentIndex: _footerIdx,
          backgroundColor: Theme.of(context).primaryColorDark,
          selectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ]);
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bees.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          color: const Color.fromARGB(240, 255, 255, 255),
        ),
      ],
    );
  }
}

class MathBtn extends StatelessWidget {
  final Function()? btnFunc;
  final Icon btnIcon;

  const MathBtn({
    super.key,
    required this.btnIcon,
    required this.btnFunc,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
        shape: const CircleBorder(),
        color: Theme.of(context).primaryColor,
      ),
      child: IconButton(
        onPressed: btnFunc,
        icon: btnIcon,
        color: Colors.white,
      ),
    );
  }
}

class ThickDivider extends StatelessWidget {
  const ThickDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Divider(
        thickness: 2.5,
      ),
    );
  }
}
