import 'package:ForDev/ui/pages/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../helpers/helpers.dart';
import 'components/components.dart';

class SurveysPage extends StatelessWidget {
  final SurveysPresenter presenter;

  SurveysPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(R.strings.surveys),),
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream.listen((isLoading) {
            if(isLoading == true) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });
          presenter.loadData();
          
          return StreamBuilder<List<SurveyViewModel>>(
            stream: presenter.surveysStream,
            builder: (context, snapshot) {
              if(snapshot.hasError) {
                return ReloadScreen(error: snapshot.error, reload: presenter.loadData);
              }
              if(snapshot.hasData) {
                return SurveyItems(viewModels: snapshot.data);
              }
              return SizedBox(height: 0,);
            }
          );
        }
      ),
    );
  }
}