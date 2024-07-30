import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalculatorHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
  List<String> history = [];

  void buttonPressed(String buttonText) {
    if (buttonText == "AC") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "÷" ||
        buttonText == "×") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      String result = "";
      if (operand == "+") {
        result = (num1 + num2).toString();
      }
      if (operand == "-") {
        result = (num1 - num2).toString();
      }
      if (operand == "×") {
        result = (num1 * num2).toString();
      }
      if (operand == "÷") {
        result = (num1 / num2).toString();
      }
      _output = result;

      String formattedNum1 =
          num1 == num1.toInt() ? num1.toInt().toString() : num1.toString();
      String formattedNum2 =
          num2 == num2.toInt() ? num2.toInt().toString() : num2.toString();
      String formattedResult =
          double.parse(result) == double.parse(result).toInt()
              ? double.parse(result).toInt().toString()
              : result;

      history.add("$formattedNum1 $operand $formattedNum2 = $formattedResult");

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "%") {
      _output = (double.parse(output) / 100).toString();
    } else if (buttonText == "+/-") {
      _output = (double.parse(output) * -1).toString();
    } else {
      _output = _output + buttonText;
    }

    setState(() {
      output = double.parse(_output) == double.parse(_output).toInt()
          ? double.parse(_output).toInt().toString()
          : double.parse(_output).toString();
    });
  }

  Widget buildButton(String buttonText, Color buttonColor, Color textColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(
            4.0), // Mengatur margin untuk spacing antara tombol
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                buttonColor, // Mengatur warna latar belakang tombol
            padding: const EdgeInsets.all(
                16.0), // Mengatur padding untuk ukuran tombol lebih kecil
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  15.0), // Mengatur border radius untuk tombol kotak
            ),
            elevation: 0,
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  void _showClearHistoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text('Konfirmasi'),
          ),
          content: const Text('Apakah Anda yakin ingin menghapus riwayat?'),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Tidak',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
            TextButton(
              child: const Text(
                'Ya',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                setState(() {
                  history.clear();
                });
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Kalkulator',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25.0,
            fontFamily: 'Roboto',
            letterSpacing: 1.0,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Colors.black,
              ),
            ],
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 80.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.history),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              title: const Text(
                'Riwayat',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Center(
                        child: Text(
                          'Riwayat',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      content: SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: history.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(history[index]),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 8.0),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text(
                            'Hapus Riwayat',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              Navigator.of(context).pop();
                              _showClearHistoryDialog();
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                        ),
                        TextButton(
                          child: const Text(
                            'Tutup',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              title: const Text(
                'Tentang',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Tentang Aplikasi',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Version: 1.1.0',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Rifki Darmawan',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text(
                            'Tutup',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 12.0,
            ),
            child: Text(
              output,
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("AC", Colors.grey[300]!,
                      Colors.black), // Tombol AC dengan warna grey
                  buildButton("%", Colors.grey[300]!,
                      Colors.black), // Tombol % dengan warna grey
                  buildButton("+/-", Colors.grey[300]!,
                      Colors.black), // Tombol +/-, warna grey
                  buildButton("÷", Colors.orangeAccent, Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton(
                      "7", Color.fromARGB(255, 37, 37, 37), Colors.white),
                  buildButton(
                      "8", Color.fromARGB(255, 37, 37, 37), Colors.white),
                  buildButton(
                      "9", Color.fromARGB(255, 37, 37, 37), Colors.white),
                  buildButton("×", Colors.orangeAccent, Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton(
                      "4", Color.fromARGB(255, 37, 37, 37), Colors.white),
                  buildButton(
                      "5", Color.fromARGB(255, 37, 37, 37), Colors.white),
                  buildButton(
                      "6", Color.fromARGB(255, 37, 37, 37), Colors.white),
                  buildButton("-", Colors.orangeAccent, Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton(
                      "1", Color.fromARGB(255, 37, 37, 37), Colors.white),
                  buildButton(
                      "2", Color.fromARGB(255, 37, 37, 37), Colors.white),
                  buildButton(
                      "3", Color.fromARGB(255, 37, 37, 37), Colors.white),
                  buildButton("+", Colors.orangeAccent, Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton(
                      "0", Color.fromARGB(255, 37, 37, 37), Colors.white),
                  buildButton(
                      ".", Color.fromARGB(255, 37, 37, 37), Colors.white),
                  buildButton("=", Colors.orangeAccent, Colors.white),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
