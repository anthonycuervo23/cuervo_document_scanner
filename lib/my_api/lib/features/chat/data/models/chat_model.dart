class UserNameDetail {
  final String profileImage;
  final String userName;
  final String lastMessage;
  final String time;
  final bool isMessage;
  final bool isLastMessage;
  final String mobileNo;
  List<MessageModel>? listOfMessage;

  UserNameDetail({
    required this.profileImage,
    required this.userName,
    required this.lastMessage,
    required this.time,
    required this.isMessage,
    required this.mobileNo,
    required this.isLastMessage,
    this.listOfMessage,
  });
}

class MessageModel {
  final String message;
  final String profileImage;
  final String time;
  final bool sendMessage;

  MessageModel({
    required this.message,
    required this.profileImage,
    required this.time,
    required this.sendMessage,
  });
}

List<UserNameDetail> listOfUserMessages = [
  UserNameDetail(
    isLastMessage: true,
    mobileNo: "123456789",
    profileImage: "assets/photos/svg/chat/user.png",
    userName: "user1",
    lastMessage: "There is an important campaign...",
    time: "01:12 am",
    isMessage: false,
    listOfMessage: [
      MessageModel(
        message: "Hello",
        profileImage: "",
        time: "09:00 pm",
        sendMessage: true,
      ),
      MessageModel(
        message: "Hello",
        profileImage: "assets/photos/svg/chat/user.png",
        time: "09:05 pm",
        sendMessage: false,
      ),
      MessageModel(
        message: "hiii",
        profileImage: "",
        time: "09:15 pm",
        sendMessage: true,
      ),
    ],
  ),
  UserNameDetail(
    isLastMessage: false,
    mobileNo: "123456789",
    profileImage: "assets/photos/svg/chat/user.png",
    userName: "user2",
    lastMessage: "There is an important campaign...",
    time: "01:12 am",
    isMessage: true,
    listOfMessage: [
      MessageModel(
        message: "Hello",
        profileImage: "",
        time: "09:00 pm",
        sendMessage: true,
      ),
      MessageModel(
        message: "Hello",
        profileImage: "assets/photos/svg/chat/user.png",
        time: "09:05 pm",
        sendMessage: false,
      ),
      MessageModel(
        message: "hiii",
        profileImage: "",
        time: "09:15 pm",
        sendMessage: true,
      ),
    ],
  ),
  UserNameDetail(
    isLastMessage: false,
    mobileNo: "123456789",
    profileImage: "assets/photos/svg/chat/user.png",
    userName: "user3",
    lastMessage: "There is an important campaign...",
    time: "01:12 am",
    isMessage: false,
    listOfMessage: [
      MessageModel(
        message: "Hello",
        profileImage: "Hello",
        time: "09:00 pm",
        sendMessage: true,
      ),
      MessageModel(
        message: "Hello",
        profileImage: "assets/photos/svg/chat/user.png",
        time: "09:05 pm",
        sendMessage: false,
      ),
      MessageModel(
        message: "Hello",
        profileImage: "",
        time: "09:15 pm",
        sendMessage: true,
      ),
    ],
  ),
];
