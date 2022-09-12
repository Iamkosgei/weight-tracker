import 'package:timeago/timeago.dart' as timeago;

String getHowLongAgo(int timeStamp) {
  Duration difference =
      DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(timeStamp));
  final fifteenAgo = DateTime.now().subtract(difference);

  return timeago.format(fifteenAgo);
}
