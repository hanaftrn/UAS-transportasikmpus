// import 'package:flutter/material.dart';

// class RegisterPage extends StatelessWidget {
//   RegisterPage({super.key});

//   final _confirmPasswordController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Daftar'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(labelText: 'Email'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Masukkan email';
//                   }
//                   if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                     return 'Masukkan email yang valid';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: const InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Masukkan password';
//                   }
//                   if (value.length < 6) {
//                     return 'Password harus terdiri dari minimal 6 karakter';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _confirmPasswordController,
//                 decoration: const InputDecoration(labelText: 'Konfirmasi Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Konfirmasi password';
//                   }
//                   if (value != _passwordController.text) {
//                     return 'Password tidak cocok';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState?.validate() == true) {
//                     // Implementasi pendaftaran
//                     final email = _emailController.text;
//                     final password = _passwordController.text;
//                     // Lakukan pendaftaran dengan email dan password
//                     print('Email: $email, Password: $password');
//                   }
//                 },
//                 child: const Text('Daftar'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
