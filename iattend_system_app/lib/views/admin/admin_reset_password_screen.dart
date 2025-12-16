import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/admin_provider.dart';
import '../widgets/custom_text_field.dart';

class AdminResetPasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final emailCtrl = TextEditingController();
  final newPassCtrl = TextEditingController();

  AdminResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تغيير كلمة مرور المستخدم"),
        backgroundColor: Colors.redAccent,
      ),
      body: Consumer<AdminProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_reset, size: 80, color: Colors.redAccent),
                  const SizedBox(height: 20),
                  const Text(
                    "أدخل إيميل المستخدم وكلمة المرور الجديدة",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),

                  // 1. الإيميل
                  CustomTextField(
                    controller: emailCtrl, 
                    label: "إيميل المستخدم (Email)", 
                    icon: Icons.email
                  ),
                  
                  // 2. الباسورد الجديد
                  CustomTextField(
                    controller: newPassCtrl, 
                    label: "كلمة المرور الجديدة", 
                    icon: Icons.lock,
                    isPassword: true,
                  ),

                  const SizedBox(height: 30),

                  provider.isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                provider.resetUserPassword(
                                  email: emailCtrl.text,
                                  newPassword: newPassCtrl.text,
                                  context: context,
                                );
                              }
                            },
                            child: const Text("تغيير كلمة المرور"),
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