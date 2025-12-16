import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/admin_provider.dart';
import '../widgets/custom_text_field.dart';

class EnrollStudentScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final uniIdCtrl = TextEditingController(); // الرقم الجامعي
  final subjectCodeCtrl = TextEditingController(); // كود المادة

  EnrollStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تسجيل طالب في مادة")),
      body: Consumer<AdminProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.link, size: 80, color: Colors.purple),
                  const SizedBox(height: 20),
                  const Text(
                    "ربط الطالب بالمقرر الدراسي",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),

                  // 1. الرقم الجامعي للطالب
                  CustomTextField(
                    controller: uniIdCtrl,
                    label: "الرقم الجامعي للطالب (University ID)",
                    icon: Icons.badge,
                  ),

                  // 2. كود المادة
                  CustomTextField(
                    controller: subjectCodeCtrl,
                    label: "كود المادة (Subject Code)",
                    icon: Icons.qr_code,
                  ),

                  const SizedBox(height: 30),

                  provider.isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                provider.enrollStudent(
                                  universityId: uniIdCtrl.text,
                                  subjectCode: subjectCodeCtrl.text,
                                  context: context,
                                );
                              }
                            },
                            child: const Text("تأكيد التسجيل"),
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
