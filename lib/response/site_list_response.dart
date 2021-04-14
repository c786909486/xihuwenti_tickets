class SiteListResponse {
    List<SiteListBean> list;

    SiteListResponse({this.list});

    factory SiteListResponse.fromJson(Map<String, dynamic> json) {
        return SiteListResponse(
            list: json['list'] != null ? (json['list'] as List).map((i) => SiteListBean.fromJson(i)).toList() : null,
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

class SiteListBean {
    String id;
    String name;

    SiteListBean({this.id, this.name});

    factory SiteListBean.fromJson(Map<String, dynamic> json) {
        return SiteListBean(
            id: json['id'],
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['name'] = this.name;
        return data;
    }
}