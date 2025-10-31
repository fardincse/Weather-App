import 'package:intl/intl.dart';

String formatDate(dateString){
  final date = DateTime.parse(dateString);
  final now = DateTime.now();
  final tomorrow = now.add(Duration(days: 1));

  if(date.year == now.year && date.month == now.month && date.day == now.day){
    return "Today";
  }else if(date.year == now.year && date.month == now.month && date.day == tomorrow.day){
    return "Tomorrow";
  }else{
    final formatted = DateFormat('dd, MMM').format(date);
    return formatted;
  }
}