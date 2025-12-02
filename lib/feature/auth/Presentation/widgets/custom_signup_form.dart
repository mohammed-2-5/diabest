import 'package:diiabest/feature/auth/Presentation/widgets/signup_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/Utils/App-String.dart';
import '../../../../core/Utils/App-colors.dart';
import '../../../../core/Widgets/custom_btn.dart';
import '../../../../core/Widgets/custom_text_field.dart';
import '../../../Register_your_information/presentation/views/register_your_information.dart';
import '../../../doctor/presentation/views/doctor_view.dart';
import '../../auth_cubit/autch_state.dart';
import '../../auth_cubit/auth_cubit.dart';
import '../Views/sign_in.dart';
import 'have_an_account_widget.dart';

class CustomSignUpForm extends StatefulWidget {
  const CustomSignUpForm({super.key});

  @override
  State<CustomSignUpForm> createState() => _CustomSignUpFormState();
}

class _CustomSignUpFormState extends State<CustomSignUpForm> {
  String? selectedGender;
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffE3F2FD), Color(0xffBBDEFB)], // Blue gradient
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignUpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)),
            );
          }
          if (state is SignUpSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => state.currentUser.role == AppStrings.patient
                    ? const RegisterPatientInformation()
                    : const DoctorView(),
              ),
            );
          }
        },
        child: Column(
          children: [
            _buildTextField(
              controller: BlocProvider.of<AuthCubit>(context).fullName,
              labelText: AppStrings.fullname,
              icon: Icons.person,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Full name is required';
                return null;
              },
            ),
            _buildTextField(
              controller: BlocProvider.of<AuthCubit>(context).nationalID,
              labelText: AppStrings.nationalID,
              icon: Icons.credit_card,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Please enter some text';
                if (value.length != 14) return "Your National ID is not correct";
                return null;
              },
            ),

            // Gender Selection
            _buildGenderDropdown(),

            _buildTextField(
              controller: BlocProvider.of<AuthCubit>(context).emailAddress,
              labelText: AppStrings.emailAddress,
              icon: Icons.email,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Email is required';
                if (!RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$").hasMatch(value)) {
                  return "Enter a valid email";
                }
                return null;
              },
            ),

            _buildPasswordField(
              validator: (value) {
                if (value == null || value.isEmpty) return 'Password is required';
                if (value.length < 6) return "Password must be at least 6 characters";
                return null;
              },
              controller: BlocProvider.of<AuthCubit>(context).password,
              labelText: AppStrings.password,
              isObscure: isPasswordObscure,
              toggleObscure: () {
                setState(() {
                  isPasswordObscure = !isPasswordObscure;
                });
              },
            ),

            _buildPasswordField( validator: (value) {
              if (value == null || value.isEmpty) return 'Confirm password is required';
              if (value != BlocProvider.of<AuthCubit>(context).password.text) {
                return "Passwords do not match";
              }
              return null;
            },

              controller: BlocProvider.of<AuthCubit>(context).confirmThePassword,
              labelText: AppStrings.confirmThePassword,
              isObscure: isConfirmPasswordObscure,
              toggleObscure: () {
                setState(() {
                  isConfirmPasswordObscure = !isConfirmPasswordObscure;
                });
              },
            ),

            SizedBox(height: height * 0.02),

            const SignUpRadio(),

            SizedBox(height: height * 0.03),

            // Modern Sign Up Button
            _buildSignUpButton(),

            SizedBox(height: height * 0.02),
            HaveAnAccountWidget(
              text1: AppStrings.alreadyHaveAnAccount,
              text2: AppStrings.signIn,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInView(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // 📌 Modern Text Field
  Widget _buildTextField({required TextEditingController controller, required String labelText, required IconData icon, String? Function(String?)? validator}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(2, 3)),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 12.sp,),
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          prefixIcon: Icon(icon, color: Colors.blue.shade700),
          hintText: labelText,
          hintStyle: const TextStyle(color: Colors.blueGrey,fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // 📌 Password Field with Toggle Visibility
  Widget _buildPasswordField({
    required String? Function(String?) validator,
    required TextEditingController controller,
    required String labelText,
    required bool isObscure,
    required VoidCallback toggleObscure,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(2, 3)),
        ],
      ),
      child: TextFormField(  validator: validator,

        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 12.sp,),
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          prefixIcon: const Icon(Icons.lock, color: Colors.blue),
          suffixIcon: IconButton(
            icon: Icon(isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey.shade600),
            onPressed: toggleObscure,
          ),
          hintText: labelText,
          hintStyle: const TextStyle(color: Colors.blueGrey, fontSize:14),
          border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // 📌 Gender Selection Dropdown
  Widget _buildGenderDropdown() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(2, 3)),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedGender??"Male",
          hint: const Text("Select Gender"),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
          isExpanded: true,
          onChanged: (value) {
            setState(() {
              selectedGender = value;
            });
            BlocProvider.of<AuthCubit>(context).gender = value!;
          },

          items: const [
            DropdownMenuItem(value: AppStrings.male, child: Text("Male", style: TextStyle(fontSize: 16))),
            DropdownMenuItem(value: AppStrings.female, child: Text("Female", style: TextStyle(fontSize: 16))),
          ],
        ),
      ),
    );
  }

  // 📌 Modern Animated Sign Up Button
  Widget _buildSignUpButton() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => state.currentUser.role == AppStrings.patient
                  ? const RegisterPatientInformation()
                  : const DoctorView(),
            ),
          );
        }
      },
      builder: (context, state) {
        bool isLoading = state is SignupLoadingState;
        return Stack(
          children: [
            GestureDetector(
              onTap: isLoading
                  ? null
                  : () {
                var formKey = BlocProvider.of<AuthCubit>(context).signupFormKey;
                if (formKey.currentState!.validate()) {
                  BlocProvider.of<AuthCubit>(context).signUpWithEmailAndPassword();
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff64B5F6), Color(0xff1E88E5)], // Light blue to deep blue
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(color: Colors.blue.withOpacity(0.4), blurRadius: 8, offset: const Offset(2, 4)),
                  ],
                ),
                alignment: Alignment.center,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            if (isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3), // Semi-transparent overlay
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

}
