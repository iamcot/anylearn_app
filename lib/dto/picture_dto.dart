class Picture {
  final String? url;
  final int? orgWidth;
  final int? orgHeight;
  final String? orgUrl;
  final String? cloudName;
  Picture(
      {this.url, this.orgWidth, this.orgHeight, this.orgUrl, this.cloudName});
  Picture _$PictureFromJson(Map<String, dynamic> json) => Picture(
        url: json['url'] as String?,
        orgWidth: json['org_width'] as int?,
        orgHeight: json['org_height'] as int?,
        orgUrl: json['org_url'] as String?,
        cloudName: json['cloud_name'] as String?,
      );

}
