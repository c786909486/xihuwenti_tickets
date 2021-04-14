import 'dart:convert';

import 'package:base_flutter/base_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:xihuwenti_tickets/data/select_date_model.dart';
import 'package:xihuwenti_tickets/data/site_data.dart';
import 'package:xihuwenti_tickets/response/site_list_response.dart';
import 'package:xihuwenti_tickets/response/site_time_list_response.dart';

class SelectSiteViewModel extends BaseViewModel{
  SelectSiteViewModel(BuildContext context) : super(context);

  //场馆id
  String venueId;
  void initShowId(String showId){
    this.venueId = showId;
    ///初始化日期
    initDate();
    ///初始化场次信息
    initSiteData();
    getSiteTimes(dates[dateSelect].week);
  }


  //日期选择
  var dates = <SelectDateModel>[];
  ///选择的日期index
  var dateSelect = 0;
  // SelectDateModel selectDate;

  var sitesList = <SiteListBean>[];
  var siteSelect = 0;

  var siteTimesList = <SiteTimeListBean>[];
  var timeSelectList = <SiteTimeListBean>[];

  @override
  void onCreated() {
    super.onCreated();

  }


  void initDate(){
    var format = ["m","月","d","日"];
    var weekFormat = ["D"];
    var ymdFormat = ["yyyy","-","mm","-","dd"];
    for(var i=0;i<7;i++){
      var now = DateTime.now().add(Duration(days: i));
      // now.add(Duration(days: i));
      var time = formatDate(now, format, LocaleType.zh);
      var week = formatDate(now, weekFormat, LocaleType.zh);
      var ymd = formatDate(now, ymdFormat, LocaleType.zh);
      dates.add(SelectDateModel(week, time,ymd));
    }

  }

  void initSiteData(){
    var data = venueId=="752"?siteDataStr_one:siteDataStr_three;
    var response = SiteListResponse.fromJson(data);
    sitesList = response.list;
    notifyListeners();
  }

  ///日期点击
  void clickDate(int index,SelectDateModel date){
    dateSelect = index;
    // this.selectDate = date;
    timeSelectList.clear();
    getSiteTimes(date.week);
    notifyListeners();
  }

  ///场地点击
  void selectSiteItem(int index){
    this.siteSelect = index;
    notifyListeners();
  }

  void onSiteTimeClick(SiteTimeListBean item){
    if(timeSelectList.contains(item)){
      timeSelectList.remove(item);
    }else{
      timeSelectList.add(item);
    }
    notifyListeners();
  }

  ///获取点击场次信息
  void getSiteTimes(String week){
    SiteTimeListResponse siteTimeListResponse;
    if(week=="星期日"||week=="星期六"){
      if(venueId=="753"){
        siteTimeListResponse = SiteTimeListResponse.fromJson(week_times_three);
      }else{
        siteTimeListResponse = SiteTimeListResponse.fromJson(week_times_one);
      }
    }else{
      if(venueId=="753"){
        siteTimeListResponse = SiteTimeListResponse.fromJson(normal_times_three);
      }else{
        siteTimeListResponse = SiteTimeListResponse.fromJson(normal_times_one);
      }
    }
    siteTimesList = siteTimeListResponse.list;
    notifyListeners();
  }

  void createLink(){
    if(timeSelectList.isEmpty){
      showToast("请先选择时间");
      return;
    }

    var map = Map();
    map["date"] = dates[dateSelect].ymd;
    var site = sitesList[siteSelect];
    timeSelectList.sort((a,b){
      return a.sort.compareTo(b.sort);
    });
    num price = 0;
    var period = <String>[];
    for(var time in timeSelectList){
      var itemPrice = num.parse(time.price);
      price+=itemPrice;

      var str = "${site.id},${time.start},${time.end}";
      period.add(str);
    }

    map["period"] = period;
    map["money"] = price;
    map["total_fee"] = price;

    String json = jsonEncode(map);
    String params = encodeBase64(json);
    print(params);
    var url = "https://xihuwenti.juyancn.cn/wechat/order/index?show_id=$venueId&param=$params";
    Clipboard.setData(ClipboardData(text: url));
    showToast(url);
    showToast("已复制到剪切板");
  }


  static String encodeBase64(String data){
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

}