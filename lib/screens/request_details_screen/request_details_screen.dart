import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/request_bloc/request_bloc.dart';
import 'package:charity/screens/add_new_case_screen/add_new_case_screen.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/details_component.dart';
import 'package:charity/widgets/failure_dialog.dart';
import 'package:charity/widgets/loading_dialog.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:charity/widgets/show_image_component.dart';
import 'package:charity/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_repository/request_repository.dart';

class RequestDetailsScreen extends StatelessWidget {
  Request request;
  RequestDetailsScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    AppLocale.of(context).loadLang();
    return BlocProvider<RequestBloc>(
      create: (context) => RequestBloc(
        requestRepository: FirebaseRequestRepository(),
      ),
      child: BlocConsumer<RequestBloc, RequestState>(
        listener: (context, state) {
          if(state is RefuseRequestProcess){
            showDialog(
              context: context,
              builder: (context){
                return const LoadingDialog();
              }
            );
          }else if(state is RefuseRequestFailure){
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context){
                  return FailureDialog(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  );
                }
            );
          }else if(state is RefuseRequestSuccess){
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context){
                  return SuccessDialog(
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
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
                      SecondDefaultText(
                          text: getLang(context, "request details")!),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ShowImage(url: request.idImage1),
                          ShowImage(url: request.idImage2),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      DetailsCom(
                          what: getLang(context, 'Name')!, res: request.name),
                      const SizedBox(
                        height: 10.0,
                      ),
                      DetailsCom(
                          what: getLang(context, 'national id')!,
                          res: request.nationalId),
                      const SizedBox(
                        height: 10.0,
                      ),
                      DetailsCom(
                          what: getLang(context, "Phone")!, res: request.phone),
                      const SizedBox(
                        height: 10.0,
                      ),
                      DetailsCom(what: getLang(context, "des")!, res: ''),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Text(
                          request.description,
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
                      Row(
                        children: [
                          Expanded(
                            child: DefaultMaterialButton(
                              text: getLang(context, "add")!,
                              textColor: Colors.white,
                              buttonColor: Colors.green,
                              function: () {
                                Navigator.push(context ,
                                  MaterialPageRoute(builder: (context)=>AddNewCaseScreen(request: request)),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: DefaultMaterialButton(
                              text: getLang(context, "refuse")!,
                              textColor: Colors.white,
                              buttonColor: Colors.red,
                              function: () {
                                request = request.edit(status: 'refused');
                                context.read<RequestBloc>().add(
                                  RefuseRequest(request: request),
                                );
                              },
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
        },
      ),
    );
  }
}
