import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '';
      } else if (value == '=') {
        _calculateResult();
      } else {
        _expression += value;
      }
    });
  }

  void _calculateResult() {
    try {
      final exp = _expression.replaceAll('×', '*').replaceAll('÷', '/');
      final result = double.parse(
          (double.parse(
            exp.split(RegExp(r'[+\-*/]'))[0],
          )).toStringAsFixed(2)); // fallback parse

          _result = _safeEval(exp);
    } catch (e) {
      _result = 'Error';
    }
  }

  String _safeEval(String exp) {
    try {
      // Very basic safe eval for + - * /
      final finalExp = exp.replaceAll('×', '*').replaceAll('÷', '/');
      final parser = RegExp(r'^-?\d+(\.\d+)?([+\-*/]-?\d+(\.\d+)?)*$');
      if (!parser.hasMatch(finalExp)) return 'Invalid';

      final expression = finalExp;
      double total = double.parse(expression.split(RegExp(r'[+\-*/]'))[0]);
      final ops = RegExp(r'([+\-*/])');
      final parts = expression.split(ops);
      final operators = ops.allMatches(expression).map((e) => e.group(0)!).toList();

      for (int i = 1; i < parts.length; i++) {
        final double num = double.parse(parts[i]);
        final String op = operators[i - 1];
        switch (op) {
          case '+':
            total += num;
            break;
          case '-':
            total -= num;
            break;
          case '*':
            total *= num;
            break;
          case '/':
            total = num == 0 ? double.nan : total / num;
            break;
        }
      }

      return total.toStringAsFixed(2);
    } catch (_) {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> buttons = [
      '7', '8', '9', '÷',
      '4', '5', '6', '×',
      '1', '2', '3', '-',
      'C', '0', '=', '+',
    ];

    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            color: Colors.black87,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _expression,
                  style: const TextStyle(fontSize: 28, color: Colors.white70),
                ),
                const SizedBox(height: 10),
                Text(
                  _result,
                  style: const TextStyle(fontSize: 36, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: buttons.length,
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final button = buttons[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => _onPressed(button),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isOperator(button)
                      ? Colors.orange
                      : button == 'C'
                      ? Colors.red
                      : Colors.grey.shade800,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(fontSize: 24),
                ),
                child: Text(button),
              ),
            );
          },
        ),
      ],
    );
  }

  bool _isOperator(String x) {
    return x == '+' || x == '-' || x == '×' || x == '÷';
  }
}
