class HelpDeskModel {
  String? ticketNo;
  String? title;
  String? description;
  String? assignedTo;
  String? status;

  HelpDeskModel(
      {this.ticketNo,
      this.title,
      this.description,
      this.assignedTo,
      this.status});

  HelpDeskModel.fromJson(Map<String, dynamic> json) {
    ticketNo = json['ticket_no'];
    title = json['title'];
    description = json['description'];
    assignedTo = json['assignedTo'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticket_no'] = ticketNo;
    data['title'] = title;
    data['description'] = description;
    data['assignedTo'] = assignedTo;
    data['status'] = status;
    return data;
  }
}
