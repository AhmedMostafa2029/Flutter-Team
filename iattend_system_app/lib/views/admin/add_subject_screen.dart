import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/admin_provider.dart';
import '../widgets/custom_text_field.dart';

class AddSubjectScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final codeCtrl = TextEditingController();
  final docEmailCtrl = TextEditingController(); // إيميل الدكتور للربط

  AddSubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إضافة مادة جديدة")),
      body: Consumer<AdminProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.menu_book, size: 80, color: Colors.teal),
                  const SizedBox(height: 20),

                  CustomTextField(controller: nameCtrl, label: "اسم المادة (Machine Learning)", icon: Icons.book),
                  CustomTextField(controller: codeCtrl, label: "كود المادة (CS400)", icon: Icons.qr_code),
                  CustomTextField(controller: docEmailCtrl, label: "إيميل الدكتور المسؤول", icon: Icons.person_pin),
                  
                  const SizedBox(height: 30),
                  
                  provider.isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                provider.addSubject(
                                  name: nameCtrl.text,
                                  code: codeCtrl.text,
                                  docEmail: docEmailCtrl.text,
                                  context: context,
                                );
                              }
                            },
                            child: const Text("إضافة المادة"),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}