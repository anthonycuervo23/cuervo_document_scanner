class UpcomingEventsModel {
  int? index;
  final String eventName;
  final String eventInformation;
  final String eventDate;

  UpcomingEventsModel({
    required this.eventName,
    required this.eventInformation,
    required this.eventDate,
    this.index,
  });
}

List<UpcomingEventsModel> listOfEvent = [
  UpcomingEventsModel(
    eventName: "Christmas festival",
    eventInformation: "Christmas is a Christian festival that celebrates the birth of Jesus Christ, who Christians...",
    eventDate: "25/12/2023",
  ),
  UpcomingEventsModel(
    eventName: "New year festival",
    eventInformation:
        "New Year's Eve is celebrated with dancing, eating, drinking, and watching or lighting fireworks.",
    eventDate: "01/01/2024",
  ),
  UpcomingEventsModel(
    eventName: "Christmas festival",
    eventInformation: "Christmas is a Christian festival that celebrates the birth of Jesus Christ, who Christians...",
    eventDate: "08/12/2023",
  ),
  UpcomingEventsModel(
    eventName: "Christmas festival",
    eventInformation: "Christmas is a Christian festival that celebrates the birth of Jesus Christ, who Christians...",
    eventDate: "07/12/2023",
  ),
  UpcomingEventsModel(
    eventName: "Christmas festival",
    eventInformation: "Christmas is a Christian festival that celebrates the birth of Jesus Christ, who Christians...",
    eventDate: "07/12/2023",
  ),
];
