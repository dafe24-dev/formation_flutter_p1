import 'package:contact_pro/pages/barre_navigation.dart';
import 'package:contact_pro/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
     setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usernameController.text.trim(),
        password: _passwordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Connexion réussie.'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => BarreNavigation()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('E-mail ou mot de passe incorrect.'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Une erreur est survenue. Veuillez réessayer.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Une erreur est survenue. Veuillez réessayer.'),
          backgroundColor: Colors.red,
        ),
      );
    }finally {
      // Ce bloc est exécuté dans tous les cas
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/image.png',
                    height: 220,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image, size: 150, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  'Bienvenue sur',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'ContactPro',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F46E5),
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Gérez vos contacts facilement',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 30),

                TextFormField(
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Le nom d\'utilisateur est obligatoire';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: Color(0xFF4F46E5),
                    ),
                    hintText: 'Nom d\'utilisateur *',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFFF8F9FF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Le mot de passe est obligatoire';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Color(0xFF4F46E5),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    hintText: 'Mot de passe *',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFFF8F9FF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Mot de passe oublié?',
                      style: TextStyle(
                        color: Color(0xFF4F46E5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F46E5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: isLoading ? null : _login,
                    child: isLoading ? const Center(child: CircularProgressIndicator()) : Text(
                      'Se connecter',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[300])),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('ou', style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider(color: Colors.grey[300])),
                  ],
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey[300]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/images/google.jpeg",
                          height: 22,
                          width: 22,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.g_mobiledata, size: 24),
                        ),
                        const SizedBox(width: 12),
                        const Flexible(
                          child: Text(
                            'Continuer avec Google',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Vous n\'avez pas de compte? ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisterPage()),
                      ),
                      child: const Text(
                        'S\'inscrire',
                        style: TextStyle(
                          color: Color(0xFF4F46E5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
