import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mpma_assignment/base_stateful_page.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/enum/form_type.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/constant/images.dart';
import 'package:mpma_assignment/constant/styles_manager.dart';
import 'package:mpma_assignment/router/router.gr.dart';
import 'package:mpma_assignment/viewmodel/user_view_model.dart';
import 'package:mpma_assignment/widget/custom_button.dart';
import 'package:mpma_assignment/widget/custom_text_field.dart';
import 'package:provider/provider.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _LoginScreen();
  }
}

class _LoginScreen extends BaseStatefulPage {
  @override
  State<_LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseStatefulState<_LoginScreen> {
  List<PageRouteInfo> routes = [];
  List<BottomNavigationBarItem> navBarItems = [];
  final _formKey = GlobalKey<FormBuilderState>();
  bool isPasswordObscure = true;

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
              getLogInForms(),
            ],
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Helper ----------------------------
extension _Helper on _LoginScreenState {
  String get email =>
      _formKey.currentState?.fields[LoginFormFieldsEnum.email.name]?.value
          as String? ??
      '';
  String get password =>
      _formKey.currentState?.fields[LoginFormFieldsEnum.password.name]?.value
          as String? ??
      '';
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _LoginScreenState {
  void onSignInButtonPressed() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      await tryLoad(
        context,
        () => context.read<UserViewModel>().loginWithEmailPassword(
          email: email,
          password: password,
        ),
      );
    }
  }

  void onCreateAccountButtonPressed() {
    context.router.pushAndPopUntil(SignUpRoute(), predicate: (route) => false);
  }

  void togglePasswordVisibility() {
    _setState(() {
      isPasswordObscure = !isPasswordObscure;
    });
  }

  void onForgotPasswordPressed() {
    context.router.push(ForgotPasswordRoute());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _LoginScreenState {
  Widget getLogo() {
    return Image.asset(
      Images.appLogo,
      width: _Styles.logoSize,
      height: _Styles.logoSize,
    );
  }

  Widget getTitle() {
    return Text(
      'WELCOME BACK!',
      style: _Styles.titleTextStyle,
      textAlign: TextAlign.center,
    );
  }

  Widget getLogInForms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCardTitleDescription(),
        SizedBox(height: 30),
        getLoginTextField(),
        getForgotPasswordText(),
        SizedBox(height: 30),
        getButtons(),
      ],
    );
  }

  Widget getCardTitleDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Login', style: _Styles.cardTitleTextStyle),
        SizedBox(height: 20),
        Text(
          'Enter email address and password to log in.',
          style: _Styles.cardDescriptionTextStyle,
        ),
      ],
    );
  }

  Widget getLoginTextField() {
    return Column(
      children: [
        CustomTextField(
          fontSize: _Styles.loginFormFieldFontSize,
          color: _Styles.loginFormFieldColor,
          title: 'Email Address',
          prefixIcon: Icon(
            Icons.email_outlined,
            color: ColorManager.blackColor,
          ),
          formName: LoginFormFieldsEnum.email.name,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ]),
        ),
        SizedBox(height: 20),
        CustomTextField(
          fontSize: _Styles.loginFormFieldFontSize,
          color: _Styles.loginFormFieldColor,
          title: 'Password',
          prefixIcon: Icon(Icons.lock_outline, color: ColorManager.blackColor),
          suffixIcon: getTogglePasswordButton(),
          isPassword: isPasswordObscure,
          formName: LoginFormFieldsEnum.password.name,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(
              6,
              errorText: 'Password must be at least 6 characters long',
            ),
          ]),
        ),
      ],
    );
  }

  IconButton getTogglePasswordButton() {
    return IconButton(
      onPressed: () => togglePasswordVisibility(),
      icon: isPasswordObscure
          ? Icon(Icons.visibility)
          : Icon(Icons.visibility_off),
    );
  }

  Widget getForgotPasswordText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: onForgotPasswordPressed,
          style: _Styles.forgotPasswordButtonStyle,
          child: Text(
            'Forgot Password?',
            style: _Styles.forgotPasswordTextStyle,
          ),
        ),
      ],
    );
  }

  Widget getButtons() {
    return Column(
      children: [
        CustomButton(
          text: 'Sign In',
          textColor: ColorManager.whiteColor,
          onPressed: onSignInButtonPressed,
        ),
        TextButton(
          style: _Styles.createAccButtonStyle,
          onPressed: onCreateAccountButtonPressed,
          child: RichText(
            text: const TextSpan(
              text: "Doesn't have an account? ",
              style: _Styles.createAccTextStyle,
              children: [
                TextSpan(text: "Sign Up", style: _Styles.signUpTextStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const logoSize = 200.0;
  static const loginFormFieldFontSize = 16.0;
  static const loginFormFieldColor = ColorManager.blackColor;

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

  static const forgotPasswordTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
    decoration: TextDecoration.underline,
    decorationColor: ColorManager.primary,
  );

  static final forgotPasswordButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(Colors.transparent),
  );

  static const createAccTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const signUpTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
    decoration: TextDecoration.underline,
  );

  static final createAccButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(Colors.transparent),
  );
}
