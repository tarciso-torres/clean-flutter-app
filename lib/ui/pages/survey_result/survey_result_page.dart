import 'package:ForDev/ui/pages/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/components.dart';
import '../../helpers/helpers.dart';
import './components/components.dart';

class SurveyResultPage extends StatelessWidget {
  final SurveyResultPresenter presenter;

  SurveyResultPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(R.strings.surveys),),
      body: Builder(
        builder: (context){
          presenter.isLoadingStream.listen((isLoading) {
            if(isLoading == true) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });
          
          presenter.isSessionExpiredStream.listen((isExpired) {
            if(isExpired == true) {
              Get.offAllNamed('/login');
            }
          });

          presenter.loadData();

          return StreamBuilder<SurveyResultViewModel>(
            stream: presenter.surveyResultStream,
            builder: (context, snapshot) {
              if(snapshot.hasError) {
                return ReloadScreen(error: snapshot.error, reload: presenter.loadData);
              }
              if(snapshot.hasData) {
                return SurveyResult(snapshot.data);
              }
              return SizedBox(height: 0);
            }
          );
        } 
      )
    );
  }
}

