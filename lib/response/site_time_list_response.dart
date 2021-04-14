class SiteTimeListResponse {
    List<SiteTimeListBean> list;

    SiteTimeListResponse({this.list});

    factory SiteTimeListResponse.fromJson(Map<String, dynamic> json) {
        return SiteTimeListResponse(
            list: json['list'] != null ? (json['list'] as List).map((i) => SiteTimeListBean.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.list != null) {
            data['list'] = this.list.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class SiteTimeListBean {
    String end;
    String price;
    String start;
    int sort;

    SiteTimeListBean({this.end, this.price, this.start,this.sort});

    factory SiteTimeListBean.fromJson(Map<String, dynamic> json) {
        return SiteTimeListBean(
            end: json['end'],
            price: json['price'],
            start: json['start'],
            sort: json['sort'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['end'] = this.end;
        data['price'] = this.price;
        data['start'] = this.start;
        data['sort'] = this.sort;
        return data;
    }
}