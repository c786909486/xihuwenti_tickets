import 'package:base_flutter/base_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xihuwenti_tickets/ui/select_site_page.dart';

class SelectVenuePage extends BaseStatefulMvvmWidget {
  @override
  State<StatefulWidget> createState() => _SelectVenueState();
}

class _SelectVenueState extends BaseMvvmState<CommonViewModel,SelectVenuePage> {

  @override
  Widget buildLoadingContentView() {
   return null;
  }


  @override
  CommonViewModel createViewModel() {
    return CommonViewModel(context);
  }

  @override
  Widget buildRootView(BuildContext context, Widget loadingContentWidget) {
    return Scaffold(
      appBar: CommonAppBar("选择场馆",fontSize: 17.fs()),
      body: Column(
        children: [
          TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
                alignment: Alignment.center,
              ),
              onPressed: () {
                Go().push(SelectSitePage("753"));
              },
              child: CommonText("3楼竞训馆",
                  textSize: 16.fs(), textColor: Colors.white)
                  .addToContainer(
                  width: double.infinity,
                  height: 80.fw(),
                  alignment: Alignment.center))
              .addToContainer(margin: EdgeInsets.all(20.fw())),

          TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                alignment: Alignment.center,
              ),
              onPressed: () {
                Go().push(SelectSitePage("752"));
              },
              child: CommonText("1楼综合馆",
                  textSize: 16.fs(), textColor: Colors.white)
                  .addToContainer(
                  width: double.infinity,
                  height: 80.fw(),
                  alignment: Alignment.center))
              .addToContainer(margin: EdgeInsets.all(20.fw())),
        ],
      ),
    );
  }

  @override
  void onRetryClick() {
    // TODO: implement onRetryClick
  }
}
