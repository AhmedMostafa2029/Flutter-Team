import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/admin_provider.dart';
import '../widgets/custom_text_field.dart';

class AddDoctorScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final deptCtrl = TextEditingController();

  AddDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تسجيل دكتور جديد")),
      body: Consumer<AdminProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Icon(Icons.medical_services, size: 80, color: Colors.orange),
                  const SizedBox(height: 20),
                  
                  CustomTextField(controller: nameCtrl, label: "الاسم كامل (Name)", icon: Icons.person),
                  CustomTextField(controller: emailCtrl, label: "الإيميل (Email)", icon: Icons.email),
                  CustomTextField(controller: passCtrl, label: "كلمة المرور", icon: Icons.lock, isPassword: true),
                  CustomTextField(controller: phoneCtrl, label: "رقم الهاتف", icon: Icons.phone, type: TextInputType.phone),
                  CustomTextField(controller: deptCtrl, label: "القسم (Department)", icon: Icons.apartment),
                  
                  const SizedBox(height: 30),
                  
                  provider.isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                provider.registerDoctor(
                                  name: nameCtrl.text,
                                  email: emailCtrl.text,
                                  password: passCtrl.text,
                                  phone: phoneCtrl.text,
                                  dept: deptCtrl.text,
                                  context: context,
                                );
                              }
                            },
                            child: const Text("حفظ بيانات الدكتور"),
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