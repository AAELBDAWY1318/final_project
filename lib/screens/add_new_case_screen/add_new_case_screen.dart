import 'package:case_campaign_repository/case_campaign_repository.dart';
import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/cases_campaigns_bloc/cases_campaigns_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/camera_component.dart';
import 'package:charity/widgets/default_dropdown_button.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/default_text_form_field.dart';
import 'package:charity/widgets/my_custom_conditional_builder.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:charity/widgets/show_image_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:request_repository/request_repository.dart';

class AddNewCaseScreen extends StatelessWidget {
  final Request request;

  const AddNewCaseScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    AppLocale.of(context).loadLang();
    TextEditingController nameController = TextEditingController();
    TextEditingController idController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController moneyController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    nameController.text = request.name;
    idController.text = request.nationalId;
    phoneController.text = request.phone;
    descriptionController.text = request.description;
    List<String> dropdownItems = [
      getLang(context, "Poor")!,
      getLang(context, "Widows")!,
      getLang(context, "Students")!,
      getLang(context, "Debtors")!,
    ];
    String dropdownValue = getLang(context, "Poor")!;
    String ? imagePath1 , imagePath2;
    return BlocProvider<CasesCampaignsBloc>(
      create: (context) => CasesCampaignsBloc(
          caseCampaignRepository: FirebaseCaseCampaignRepository()),
      child: BlocConsumer<CasesCampaignsBloc, CasesCampaignsState>(
        listener: (context, state) {
          if(state is AddCaseWithRequestProcess){
            showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: CircularProgressIndicator(
                    color: MyColors.myBlue,
                  ),
                );
              }
            );
          }else if(state is AddCaseWithRequestSuccess){
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: Image.asset('assets/images/success.png'),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(getLang(context, "OK")!),
                      )
                    ],
                  );
                }
            );
          }else if (state is AddCaseWithRequestFailure){
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: Image.asset('assets/images/failure.png'),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text(getLang(context, "OK")!),
                      )
                    ],
                  );
                }
            );
          }else if(state is AddCaseWithoutRequestProcess){
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: CircularProgressIndicator(
                      color: MyColors.myBlue,
                    ),
                  );
                }
            );
          }else if(state is AddCaseWithoutRequestSuccess){
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: Image.asset('assets/images/success.png'),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(getLang(context, "OK")!),
                      )
                    ],
                  );
                }
            );
          }else if (state is AddCaseWithoutRequestFailure){
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: Image.asset('assets/images/failure.png'),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text(getLang(context, "OK")!),
                      )
                    ],
                  );
                }
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Back(),
                        SecondDefaultText(
                            text: getLang(context, "add new case")!),
                        const SizedBox(
                          height: 10.0,
                        ),
                        DefaultTextFormField(
                          controller: nameController,
                          label: getLang(context, "Name")!,
                          icon: Icons.person,
                          validator: (String? val) {
                            if(val!.isEmpty){
                              return getLang(context, "This field must be assigned")!;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        DefaultTextFormField(
                          controller: idController,
                          label: getLang(context, "id")!,
                          icon: Icons.credit_card_outlined,
                          validator: (String? val) {
                            if(val!.isEmpty){
                              return getLang(context, "This field must be assigned")!;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        DefaultTextFormField(
                          controller: phoneController,
                          label: getLang(context, "phone")!,
                          icon: Icons.phone,
                          validator: (String? val) {
                            if(val!.isEmpty){
                              return getLang(context, "This field must be assigned")!;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        DefaultTextFormField(
                          controller: descriptionController,
                          label: getLang(context, "description")!,
                          icon: Icons.description,
                          validator: (String? val) {
                            if(val!.isEmpty){
                              return getLang(context, "This field must be assigned")!;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MyConditionalBuilder(
                              condition: (request.nationalId.isNotEmpty),
                              whenTrueCondition: ShowImage(
                                url: request.idImage1,
                              ),
                              whenFalseCondition: CameraComponent(
                                text: getLang(context, "id face")!,
                                onTap: () async {
                                  var imagePicker = ImagePicker();
                                  var pickedImage = await imagePicker.pickImage(
                                    source: ImageSource.camera,
                                  );
                                  if (pickedImage != null) {
                                    imagePath1 = pickedImage.path;
                                  }
                                },
                              ),
                            ),
                            MyConditionalBuilder(
                              condition: (request.nationalId.isNotEmpty),
                              whenTrueCondition: ShowImage(
                                url: request.idImage2,
                              ),
                              whenFalseCondition: CameraComponent(
                                text: getLang(context, "id tail")!,
                                onTap: () async {
                                  var imagePicker = ImagePicker();
                                  var pickedImage = await imagePicker.pickImage(
                                    source: ImageSource.camera,
                                  );
                                  if (pickedImage != null) {
                                    imagePath2 = pickedImage.path;
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        DefaultDropdownButton(
                          dropdownItems: dropdownItems,
                          dropdownValue: dropdownValue,
                          onChange: (String? val) {
                            if (val != dropdownValue) { // Check if the value has changed
                              dropdownValue = val!;
                              context.read<CasesCampaignsBloc>().add(
                                DropdownChange(), // Dispatch event only if value has changed
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        DefaultTextFormField(
                          label: getLang(context, "money")!,
                          controller: moneyController,
                          validator: (String? val) {
                            if(val!.isEmpty){
                              return getLang(context, "This field must be assigned")!;
                            }
                            return null;
                          },
                          icon: Icons.money_off,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        DefaultMaterialButton(
                          text: getLang(context, "add")!,
                          textColor: Colors.white,
                          buttonColor: MyColors.myBlue,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              if (request.nationalId.isNotEmpty) {
                                CaseModel caseModel = CaseModel(
                                    caseId: request.nationalId,
                                    name: request.name,
                                    phone: request.phone,
                                    description: request.description,
                                    idImage1: request.idImage1,
                                    idImage2: request.idImage2,
                                    category: dropdownValue,
                                    allAmount: moneyController.text,
                                    getAmount: "0.0");
                                context.read<CasesCampaignsBloc>().add(
                                  AddCaseWithRequest(caseModel: caseModel),
                                );
                              }else{
                                if(imagePath1!= null&& imagePath2!= null){
                                  CaseModel caseModel = CaseModel(
                                      caseId: idController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      description: descriptionController.text,
                                      idImage1: imagePath1!,
                                      idImage2: imagePath2!,
                                      category: dropdownValue,
                                      allAmount: moneyController.text,
                                      getAmount: "0.0");
                                  context.read<CasesCampaignsBloc>().add(
                                    AddCaseWithoutRequest(caseModel: caseModel),
                                  );
                                }else{
                                  showDialog(
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        content: Text(
                                          getLang(context, "empty image")!,
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text(getLang(context, "OK")!),
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                  );
                                }
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
