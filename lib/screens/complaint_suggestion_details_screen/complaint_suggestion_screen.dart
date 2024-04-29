import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/complaint_bloc/complaint_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/details_component.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:complaint_repository/complaint_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplaintSuggestionDetailsScreen extends StatelessWidget {
  final Complaint complaint;

  const ComplaintSuggestionDetailsScreen({super.key, required this.complaint});

  @override
  Widget build(BuildContext context) {
    AppLocale.of(context).loadLang();
    return BlocProvider<ComplaintBloc>(
      create: (context) =>
          ComplaintBloc(complaintRepository: FirebaseComplaintRepository()),
      child: BlocConsumer<ComplaintBloc, ComplaintState>(
        listener: (context, state) {
          if(state is RemoveComplaintProcess){
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
          }else if (state is RemoveComplaintFailure){
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: Image.asset(
                      'assets/images/failure.png',
                    ),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(getLang(context, "OK")!),
                      ),
                    ],
                  );
                }
            );
          }else if(state is RemoveComplaintSuccess){
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: Image.asset(
                      'assets/images/success.png',
                    ),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(getLang(context, "OK")!),
                      ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Back(),
                      Center(
                          child: SecondDefaultText(
                              text: getLang(context, "details")!)),
                      const SizedBox(
                        height: 20.0,
                      ),
                      DetailsCom(
                        what: getLang(context, "title")!,
                        res: complaint.title,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      DetailsCom(
                        what: getLang(context, "Phone")!,
                        res: complaint.phone,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      DetailsCom(
                        what: getLang(context, "des")!,
                        res: '',
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Text(
                          complaint.description,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      DefaultMaterialButton(
                        buttonColor: Colors.red,
                        textColor: Colors.white,
                        text: getLang(context, "remove")!,
                        function: () {
                          context.read<ComplaintBloc>().add(
                            RemoveComplaintEvent(id: complaint.userId),
                          );
                        },
                      ),
                    ],
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
