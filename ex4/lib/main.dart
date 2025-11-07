import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _interestController = TextEditingController();
  final _tenureController = TextEditingController();

  String _result = "";

  void _calculateEmi() {
    if (_formKey.currentState!.validate()) {
      double p = double.tryParse(_amountController.text) ?? 0.0;
      double annualInterest = double.tryParse(_interestController.text) ?? 0.0;
      double r = annualInterest / 12 / 100;
      int n = int.tryParse(_tenureController.text) ?? 0;

      double emi;
      if (r == 0) {
        emi = p / n;
      } else {
        emi = (p * r * pow(1 + r, n)) / (pow(1 + r, n) - 1);
      }

      double totalInterest = (emi * n) - p;

      setState(() {
        _result =
            "Loan Amount : ₹ ${p.toStringAsFixed(2)}\nEMI Amount : ₹ ${emi.toStringAsFixed(2)}\nTotal Interest : ₹ ${totalInterest.toStringAsFixed(2)}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "EMI Calculator App",
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 242, 225),
        appBar: AppBar(
          title: const Text("EMI Calculator App"),
          backgroundColor: const Color.fromARGB(255, 255, 175, 2),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Loan Amount
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Loan Amount",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the loan amount";
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) <= 0) {
                      return "Please enter a valid positive number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Interest Rate
                TextFormField(
                  controller: _interestController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Annual Interest Rate (%)",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the interest rate";
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) < 0) {
                      return "Please enter a valid interest rate";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Tenure
                TextFormField(
                  controller: _tenureController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Loan Tenure (Months)",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the loan tenure";
                    }
                    if (int.tryParse(value) == null ||
                        int.parse(value) <= 0) {
                      return "Please enter a valid positive number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 132, 31),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: _calculateEmi,
                  child: const Text("Calculate EMI"),
                ),
                const SizedBox(height: 20),

                // Result
                Text(
                  _result,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
