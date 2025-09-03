import 'package:flutter/material.dart';
import 'package:mfs_mobile/core/ui/glass_card.dart';
import 'package:mfs_mobile/core/ui/app_input.dart';
import 'package:mfs_mobile/core/ui/app_button.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  final amountController = TextEditingController();
  String? selectedBank;

  final List<String> banks = [
    "Bank of a",
    "Bank of b",
    "Bank of c",
    "Bank of d",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Deposit"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Your Balance",
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                  SizedBox(height: 6),
                  Text("\$2,500.00",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GlassCard(
              child: Column(
                children: [
                  AppInput(
                    hint: "Enter deposit amount",
                    type: TextInputType.number,
                    controller: amountController,
                  ),
                  const SizedBox(height: 16),

                  // ✅ Bank Selector Dropdown
                  DropdownButtonFormField<String>(
                    value: selectedBank,
                    dropdownColor: Colors.black87,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                    ),
                    hint: Text(
                      "Select Bank",
                      style: TextStyle(color: Colors.white.withOpacity(0.6)),
                    ),
                    items: banks.map((bank) {
                      return DropdownMenuItem<String>(
                        value: bank,
                        child: Text(bank),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedBank = value;
                      });
                    },
                  ),

                  const SizedBox(height: 16),
                  AppButton(
                    label: "Deposit",
                    onPressed: () {
                      // ✅ Access values:
                      // print(amountController.text);
                      // print(selectedBank);
                    },
                    color: Colors.greenAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}