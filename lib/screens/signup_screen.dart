import 'package:charity_app/resources/auth_methods.dart';
import 'package:charity_app/screens/login_screen.dart';
import 'package:charity_app/screens/root_screen.dart';
import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/widgets/common/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  bool _isLoading = false;

  void signUpUser() async {
    final isFormValid = _formKey.currentState!.validate();
    if (isFormValid == false) {
      return;
    }

    setState(() {
      _isLoading = true;
    });
    final navigator = Navigator.of(context);
    String res = await AuthMethods().signUpuser(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      Fluttertoast.showToast(
          msg: res, backgroundColor: Colors.red, textColor: Colors.white);
    } else {
      navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) => const RootScreen(),
        ),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          width: double.infinity,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    const Spacer(),
                    Image.asset(
                      'assets/logo.png',
                      height: 160,
                    ),
                    const Spacer(flex: 2),
                    Text(
                      'Sign up for free',
                      style: GoogleFonts.urbanist(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.1,
                      ),
                    ),
                    const Spacer(),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFieldInput(
                            textEditingController: _nameController,
                            label: 'Name',
                            hintText: 'Enter your name',
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(height: 12),
                          TextFieldInput(
                            textEditingController: _emailController,
                            label: 'Email Address',
                            hintText: 'Enter your email',
                            textInputType: TextInputType.emailAddress,
                            isEmail: true,
                          ),
                          const SizedBox(height: 12),
                          TextFieldInput(
                            textEditingController: _passwordController,
                            label: 'Password',
                            hintText: 'Enter your password',
                            textInputType: TextInputType.text,
                            isPass: true,
                          ),
                          const SizedBox(height: 12),
                          TextFieldInput(
                            textEditingController: _confirmPassController,
                            label: 'Confirm Password',
                            hintText: 'Enter confirm password',
                            textInputType: TextInputType.text,
                            isPass: true,
                            isConfirmPass: _passwordController.text,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),
                    InkWell(
                      onTap: signUpUser,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          color: primaryColor,
                        ),
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Sign up',
                                style: GoogleFonts.urbanist(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Text(
                            'Do you have an account?',
                            style: GoogleFonts.urbanist(
                              fontSize: 15,
                              color: const Color.fromRGBO(30, 35, 44, 1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: navigateToLogin,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              ' Sign in.',
                              style: GoogleFonts.urbanist(
                                fontSize: 15,
                                color: const Color.fromRGBO(30, 35, 44, 1),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
