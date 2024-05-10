import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/payment_donations_bloc/payment_donations_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/paymob_iframe/paymob_iframe.dart';
import 'package:charity/size.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/default_text_form_field.dart';
import 'package:charity/widgets/failure_dialog.dart';
import 'package:charity/widgets/loading_dialog.dart';
import 'package:charity/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController amountController = TextEditingController();
    TextEditingController firstController = TextEditingController();
    TextEditingController lastController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    return BlocProvider<PaymentDonationsBloc>(
      create: (context) => PaymentDonationsBloc()
        ..add(
          GetAuthTokenEvent(),
        ),
      child: BlocConsumer<PaymentDonationsBloc, PaymentDonationsState>(
        listener: (context, state) {
          if (State is GetPaymentKeyProcess) {
            showDialog(
                context: context,
                builder: (context) {
                  return const LoadingDialog();
                });
          }else if(state is GetPaymentKeyFailure){
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context) {
                  return FailureDialog(onPressed: (){
                    Navigator.pop(context);
                  });
                });
          }else if(state is GetPaymentKeySuccess){
            String url = state.visaUrl;
            showSnackBar(
              context: context,
              text: getLang(context, "success")!,
              color: Colors.green,
            );
            Navigator.push(context,
              MaterialPageRoute(builder: (context)=>PayMobIFrame(visaUrl: url,)),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15.0,
                    ),
                    Image.asset(
                      'assets/images/cloud-data.png',
                      height: sizeConfig.screenHeight! * 0.3,
                      width: sizeConfig.screenWidth! * 0.5,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultTextFormField(
                            icon: Icons.account_circle_outlined,
                            label: getLang(context, "first")!,
                            controller: firstController,
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return getLang(
                                    context, "This field must be assigned")!;
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Expanded(
                          child: DefaultTextFormField(
                            icon: Icons.account_circle_outlined,
                            label: getLang(context, "second")!,
                            controller: lastController,
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return getLang(
                                    context, "This field must be assigned")!;
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    DefaultTextFormField(
                      icon: Icons.alternate_email,
                      label: getLang(context, "Enter Your Email")!,
                      controller: emailController,
                      validator: (val) {
                        // Regular expression for email validation
                        final RegExp emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (val!.isEmpty) {
                          return getLang(
                              context, "This field must be assigned");
                        } else if (!emailRegex.hasMatch(val)) {
                          return getLang(
                              context, "You must assign a valid email");
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    DefaultTextFormField(
                      icon: Icons.phone,
                      label: getLang(context, "phone")!,
                      controller: phoneController,
                      validator: (val) {
                        // Regular expression for email validation
                        if (val!.isEmpty) {
                          return getLang(
                              context, "This field must be assigned");
                        } else if (val.length < 11) {
                          return getLang(context, "invalid phone");
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    DefaultTextFormField(
                      icon: Icons.money_off,
                      label: getLang(context, "amount")!,
                      controller: amountController,
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return getLang(
                              context, "This field must be assigned")!;
                        } else if (!(double.tryParse(val) != null ||
                            int.tryParse(val) != null)) {
                          return getLang(context, "invalid");
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    DefaultMaterialButton(
                      buttonColor: MyColors.myBlue,
                      textColor: Colors.white,
                      text: getLang(context, "Continue")!,
                      function: () {
                        if (formKey.currentState!.validate()) {
                          context.read<PaymentDonationsBloc>().add(
                                GetPaymentKeyEvent(
                                    firstName: firstController.text,
                                    lastName: lastController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    amount: int.parse(amountController.text)),
                              );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
