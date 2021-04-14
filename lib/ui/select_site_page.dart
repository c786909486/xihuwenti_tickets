import 'package:base_flutter/base_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:xihuwenti_tickets/viewmodel/select_site_view_model.dart';

class SelectSitePage extends BaseStatefulMvvmWidget {
  final String showId;

  SelectSitePage(this.showId);

  @override
  State<StatefulWidget> createState() => _SelectSiteState();
}

class _SelectSiteState
    extends BaseMvvmState<SelectSiteViewModel, SelectSitePage> {
  @override
  Widget buildLoadingContentView() {

    return Stack(
      children: [
        ListView(
          children: [
            ///时间选择
            ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var date = viewModel.dates[index];
                      return CommonText("${date.week}\n${date.date}",
                              textAlign: TextAlign.center,
                              textColor: viewModel.dateSelect == index
                                  ? Colors.white
                                  : Colors.black)
                          .addToContainer(
                              width: 80.fw(),
                              alignment: Alignment.center,
                              color: viewModel.dateSelect == index
                                  ? Colors.blue
                                  : Colors.transparent)
                          .onTap(() {
                        viewModel.clickDate(index, date);
                      });
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        width: 1,
                        color: Color(0xffeeeeee),
                      );
                    },
                    itemCount: viewModel.dates.length)
                .addToContainer(height: 50, color: Colors.white),

            ///选择场地
            Container(
              height: 10,
            ),
            CommonText("选择场次").addToContainer(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
            GridView.builder(
              padding: EdgeInsets.only(top: 10, left: 5, right: 5),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 2.2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
              itemBuilder: (context, index) {
                var item = viewModel.sitesList[index];
                return CommonText(item.name,
                        textColor: viewModel.siteSelect == index
                            ? Colors.white
                            : Colors.black)
                    .addToContainer(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: viewModel.siteSelect == index
                                ? Colors.blue
                                : Colors.white,
                            borderRadius: BorderRadius.circular(4)))
                    .onTap(() {
                  viewModel.selectSiteItem(index);
                });
              },
              itemCount: viewModel.sitesList.length,
            ),

            ///选择时间
            Container(
              height: 10,
            ),
            CommonText("选择时间").addToContainer(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20)),

            GridView.builder(
              padding: EdgeInsets.only(top: 10, left: 5, right: 5),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
              itemBuilder: (context, index) {
                var item = viewModel.siteTimesList[index];
                return CommonText("${item.start}\n-\n${item.end}",
                        textAlign: TextAlign.center,
                        textColor: viewModel.timeSelectList.contains(item)
                            ? Colors.white
                            : Colors.black)
                    .addToContainer(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: viewModel.timeSelectList.contains(item)
                                ? Colors.blue
                                : Colors.white,
                            borderRadius: BorderRadius.circular(4)))
                    .onTap(() {
                  viewModel.onSiteTimeClick(item);
                });
              },
              itemCount: viewModel.siteTimesList.length,
            ),
          ],
        ),
        TextButton(onPressed: () {
          viewModel.createLink();
        },style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          alignment: Alignment.center,
        ),
            child: CommonText("生成链接",textColor: Colors.white)
            .addToContainer(width: double.infinity,height: 50,alignment: Alignment.center)
        ).setLocation(bottom: 0,left: 0,right: 0)
      ],
    );
  }

  @override
  SelectSiteViewModel createViewModel() {
    return (SelectSiteViewModel(context));
  }

  @override
  void onViewModelCreated() {
    super.onViewModelCreated();
    viewModel.initShowId(widget.showId);
  }

  @override
  Widget buildRootView(BuildContext context, Widget loadingContentWidget) {
    return Scaffold(
      appBar: CommonAppBar("选择场地"),
      body: loadingContentWidget,
    );
  }

  @override
  void onRetryClick() {
    // TODO: implement onRetryClick
  }
}
