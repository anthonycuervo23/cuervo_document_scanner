class ReviewAndFeedbackModel {
  String name;
  int views;
  String image;
  int rating;
  String viewTime;
  String viewDetails;
  int like;
  int comments;

  ReviewAndFeedbackModel({
    required this.name,
    required this.views,
    required this.image,
    required this.rating,
    required this.viewTime,
    required this.viewDetails,
    required this.like,
    required this.comments,
  });
}

List<ReviewAndFeedbackModel> listOfDummyRating = [
  ReviewAndFeedbackModel(
      name: "Jenny Wilson",
      views: 250,
      image: "assets/photos/png/review_and_feedback_screen/profile.png",
      rating: 4,
      viewTime: "1",
      viewDetails:
          "I'm very happy with the services.I think this is the best product in I'm very happy with the services.I think this is the best product in",
      comments: 0,
      like: 0),
  ReviewAndFeedbackModel(
      name: "",
      views: 200,
      image: "assets/photos/png/review_and_feedback_screen/picture.png",
      rating: 3,
      viewTime: "2",
      viewDetails:
          "I'm very happy with the services.I think this is the best product in I'm very happy with the services.I think this is the best product in",
      comments: 1,
      like: 1),
  ReviewAndFeedbackModel(
      name: "Kristin Watson",
      views: 250,
      image: "assets/photos/png/review_and_feedback_screen/profile.png",
      rating: 2,
      viewTime: "1",
      viewDetails:
          "I'm very happy with the services.I think this is the best product in I'm very happy with the services.I think this is the best product in",
      comments: 0,
      like: 0),
  ReviewAndFeedbackModel(
      name: "",
      views: 200,
      image: "",
      rating: 5,
      viewTime: "2",
      viewDetails:
          "I'm very happy with the services.I think this is the best product in I'm very happy with the services.I think this is the best product in",
      comments: 1,
      like: 1),
];
