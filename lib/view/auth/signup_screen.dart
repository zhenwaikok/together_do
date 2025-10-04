import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mpma_assignment/base_stateful_page.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/constant.dart';
import 'package:mpma_assignment/constant/enum/form_type.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/constant/images.dart';
import 'package:mpma_assignment/constant/styles_manager.dart';
import 'package:mpma_assignment/router/router.gr.dart';
import 'package:mpma_assignment/viewmodel/user_view_model.dart';
import 'package:mpma_assignment/widget/custom_button.dart';
import 'package:mpma_assignment/widget/custom_dropdown.dart';
import 'package:mpma_assignment/widget/custom_text_field.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _SignUpScreen();
  }
}

class _SignUpScreen extends BaseStatefulPage {
  @override
  State<_SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends BaseStatefulState<_SignUpScreen> {
  final genders = DropDownItems.genders;
  String? selectedGender;
  final _formKey = GlobalKey<FormBuilderState>();
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;

  @override
  void initState() {
    selectedGender = genders.first;
    super.initState();
  }

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return StylesManager.zeroPadding;
  }

  @override
  Widget body() {
    return Center(
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              getLogo(),
              SizedBox(height: 15),
              getTitle(),
              SizedBox(height: 30),
              getSignUpForms(),
            ],
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Helper ----------------------------
extension _Helper on _SignUpScreenState {
  String get firstName =>
      _formKey
          .currentState
          ?.fields[SignUpFormFieldsEnum.firstName.name]
          ?.value ??
      '';

  String get lastName =>
      _formKey
          .currentState
          ?.fields[SignUpFormFieldsEnum.lastName.name]
          ?.value ??
      '';

  String get email =>
      _formKey.currentState?.fields[SignUpFormFieldsEnum.email.name]?.value ??
      '';

  String get gender => selectedGender ?? '';

  String get password =>
      _formKey
          .currentState
          ?.fields[SignUpFormFieldsEnum.password.name]
          ?.value ??
      '';
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _SignUpScreenState {
  void onGenderChanged(String? value) {
    _setState(() {
      selectedGender = value;
    });
  }

  void onSignInButtonPressed() async {
    context.router.pushAndPopUntil(LoginRoute(), predicate: (route) => false);
  }

  void onSignUpButtonPressed() async {
    final formValid = _formKey.currentState?.saveAndValidate() ?? false;

    if (formValid) {
      await tryLoad(
        context,
        () => context.read<UserViewModel>().signUpWithEmailPassword(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          gender: gender,
        ),
      );
    }
  }

  void togglePasswordVisibility({required bool passwordField}) {
    _setState(() {
      if (passwordField) {
        isPasswordObscure = !isPasswordObscure;
      } else {
        isConfirmPasswordObscure = !isConfirmPasswordObscure;
      }
    });
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _SignUpScreenState {
  Widget getLogo() {
    return Image.asset(
      Images.appLogo,
      width: _Styles.logoSize,
      height: _Styles.logoSize,
    );
  }

  Widget getTitle() {
    return Text(
      'JOIN US!',
      style: _Styles.titleTextStyle,
      textAlign: TextAlign.center,
    );
  }

  Widget getSignUpForms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCardTitleDescription(),
        SizedBox(height: 20),
        getTextField(),
      ],
    );
  }

  Widget getCardTitleDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sign Up', style: _Styles.cardTitleTextStyle),
        SizedBox(height: 20),
        Text(
          'Enter details below to create an account.',
          style: _Styles.cardDescriptionTextStyle,
        ),
      ],
    );
  }

  Widget getTextField() {
    return Column(
      children: [
        getCustomerNameTextField(),
        SizedBox(height: 20),
        getEmailTextField(),
        SizedBox(height: 20),
        getGenderDropdown(),
        SizedBox(height: 20),
        getPasswordTextField(),
        SizedBox(height: 30),
        getButtons(),
      ],
    );
  }

  Widget getGenderDropdown() {
    return CustomDropdown(
      formName: SignUpFormFieldsEnum.gender.name,
      items: genders,
      title: 'Gender',
      fontSize: _Styles.signUpFormFieldFontSize,
      color: _Styles.signUpFormFieldColor,
      validator: FormBuilderValidators.required(),
      onChanged: (value) {
        onGenderChanged(value);
      },
    );
  }

  Widget getEmailTextField() {
    return CustomTextField(
      fontSize: _Styles.signUpFormFieldFontSize,
      color: _Styles.signUpFormFieldColor,
      title: 'Email Address',
      prefixIcon: Icon(Icons.email_outlined, color: ColorManager.blackColor),
      formName: SignUpFormFieldsEnum.email.name,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.email(),
      ]),
    );
  }

  Widget getCustomerNameTextField() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            fontSize: _Styles.signUpFormFieldFontSize,
            color: _Styles.signUpFormFieldColor,
            title: 'First Name',
            formName: SignUpFormFieldsEnum.firstName.name,
            validator: FormBuilderValidators.required(),
          ),
        ),
        SizedBox(width: 25),
        Expanded(
          child: CustomTextField(
            fontSize: _Styles.signUpFormFieldFontSize,
            color: _Styles.signUpFormFieldColor,
            title: 'Last Name',
            formName: SignUpFormFieldsEnum.lastName.name,
            validator: FormBuilderValidators.required(),
          ),
        ),
      ],
    );
  }

  Widget getPasswordTextField() {
    return Column(
      children: [
        CustomTextField(
          fontSize: _Styles.signUpFormFieldFontSize,
          color: _Styles.signUpFormFieldColor,
          title: 'Password',
          prefixIcon: Icon(Icons.lock_outline, color: ColorManager.blackColor),
          suffixIcon: getTogglePasswordButton(passwordField: true),
          isPassword: isPasswordObscure,
          formName: SignUpFormFieldsEnum.password.name,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(
              6,
              errorText: 'Password must be at least 6 characters long',
            ),
          ]),
        ),
        SizedBox(height: 20),
        CustomTextField(
          fontSize: _Styles.signUpFormFieldFontSize,
          color: _Styles.signUpFormFieldColor,
          title: 'Confirm Password',
          prefixIcon: Icon(Icons.lock_outline, color: ColorManager.blackColor),
          suffixIcon: getTogglePasswordButton(passwordField: false),
          isPassword: isConfirmPasswordObscure,
          formName: SignUpFormFieldsEnum.confirmPassword.name,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            (value) {
              final password = _formKey
                  .currentState
                  ?.fields[SignUpFormFieldsEnum.password.name]
                  ?.value;
              if (password != value) {
                return 'Password does not match';
              }
              return null;
            },
          ]),
        ),
      ],
    );
  }

  Widget getButtons() {
    return Column(
      children: [
        CustomButton(
          text: 'Sign Up',
          textColor: ColorManager.whiteColor,
          onPressed: onSignUpButtonPressed,
        ),
        TextButton(
          style: _Styles.alreadyHaveAccButtonStyle,
          onPressed: onSignInButtonPressed,
          child: RichText(
            text: const TextSpan(
              text: "Already have an account? ",
              style: _Styles.alreadyHaveAccTextStyle,
              children: [
                TextSpan(text: "Sign In", style: _Styles.signInTextStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }

  IconButton getTogglePasswordButton({required bool passwordField}) {
    return IconButton(
      onPressed: () => togglePasswordVisibility(passwordField: passwordField),
      icon: passwordField
          ? (isPasswordObscure
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off))
          : (isConfirmPasswordObscure
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off)),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const logoSize = 200.0;
  static const signUpFormFieldFontSize = 16.0;
  static const signUpFormFieldColor = ColorManager.blackColor;

  static const titleTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const cardTitleTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const cardDescriptionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const alreadyHaveAccTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const signInTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
    decoration: TextDecoration.underline,
  );

  static final alreadyHaveAccButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(Colors.transparent),
  );
}
