import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen(this.isLoading, this.sumbitFn);
  final bool isLoading;
  final void Function(
    String email,
    String password,
    bool isLoggedIn,
    BuildContext ctx,
  ) sumbitFn;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FormGroup buildForm() => fb.group(<String, Object>{
        'email': FormControl<String>(
          validators: [Validators.required, Validators.email],
        ),
        'password': ['', Validators.required, Validators.minLength(8)],
        // 'rememberMe': false,
      });
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(16),
      child: ReactiveFormBuilder(
        form: buildForm,
        builder: (context, form, child) {
          return Column(
            children: [
              ReactiveTextField<String>(
                formControlName: 'email',
                validationMessages: (control) => {
                  ValidationMessage.required: 'The email must not be empty',
                  ValidationMessage.email:
                      'The email value must be a valid email',
                  'unique': 'This email is already in use',
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  helperText: '',
                  helperStyle: TextStyle(height: 0.7),
                  errorStyle: TextStyle(height: 0.7),
                ),
              ),
              const SizedBox(height: 16.0),
              ReactiveTextField<String>(
                formControlName: 'password',
                obscureText: true,
                validationMessages: (control) => {
                  ValidationMessage.required: 'The password must not be empty',
                  ValidationMessage.minLength:
                      'The password must be at least 8 characters',
                },
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  helperText: '',
                  helperStyle: TextStyle(height: 0.7),
                  errorStyle: TextStyle(height: 0.7),
                ),
              ),
              // Row(
              //   children: [
              //     ReactiveCheckbox(formControlName: 'rememberMe'),
              //     const Text('Remember me')
              //   ],
              // ),
              const SizedBox(height: 16.0),
              if (widget.isLoading) CircularProgressIndicator(),

              if (!widget.isLoading) ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity,
                        MediaQuery.of(context).size.height * 0.06)),
                onPressed: () {
                  if (form.valid) {
                    Map signupData = form.value;
                    widget.sumbitFn(signupData['email'], signupData['password'],
                        false, context);
                  } else {
                    form.markAllAsTouched();
                  }
                },
                child: const Text('Sign Up'),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              if (!widget.isLoading) ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                    minimumSize: Size(double.infinity, deviceHeight * 0.06)),
                onPressed: () => form.resetState({
                  'email': ControlState<String>(value: null),
                  'password': ControlState<String>(value: null),

                  // 'rememberMe': ControlState<bool>(value: false),
                }, removeFocus: true),
                child: const Text('Reset all'),
              ),
            ],
          );
        },
      ),
    );
  }
}
