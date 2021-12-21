import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeliveryHour {
  final int timestamp;
  final String fromDate;
  final String toDate;
  final String displayText;
  final String fromHour;
  final String toHour;
  final dateDisplayText;

  DeliveryHour(
      {this.timestamp,
      this.fromDate,
      this.toDate,
      this.displayText,
      this.fromHour,
      this.toHour,
      this.dateDisplayText});
}

class DeliveryDate {
  final String displayText;
  final String date;
  final List<DeliveryHour> hours;

  DeliveryDate({this.displayText, this.date, this.hours});
}

class DateSelector with ChangeNotifier {
  static final int maxDeliveryDaysCount = 7;
  static final int intervalDeliveryTime = 30;
  int _deliveryTime;

  static Map<String, String> getDeliveryDateMap(
      {BuildContext context, int deliveryTime, bool deliveryMode = true}) {
    var dateMap = {'dayString': '', 'hourString': ''};

    // ignore: unnecessary_null_comparison
    if (deliveryTime == null) {
      dateMap['dayString'] = toBeginningOfSentenceCase('Maintenant');
      dateMap['hourString'] = '';
      return dateMap;
    }
    DeliveryHour deliveryHour;

    if (checkDeliveryTime(deliveryTime)) {
      deliveryHour = getDeliveryHour(context, deliveryTime);
    }

    if (deliveryHour == null && deliveryMode) {
      deliveryHour = getHourList(
          context, DateFormat('yyyy-MM-dd').format(DateTime.now()))[0];
    }

    var date = DateTime.fromMillisecondsSinceEpoch(deliveryTime * 1000);

    if (deliveryHour != null) {
      date = DateTime.fromMillisecondsSinceEpoch(deliveryHour.timestamp * 1000);
    }

    // ignore: unnecessary_null_comparison
    if (deliveryHour != null) {
      var today = DateTime.now();
      var tomorrow = today.add(Duration(days: 1));

      if (DateTime(today.year, today.month, today.day) ==
          DateTime(date.year, date.month, date.day)) {
        dateMap['dayString'] = toBeginningOfSentenceCase('Aujourd\'hui');
        dateMap['hourString'] =
            'entre ${deliveryHour.fromHour} et ${deliveryHour.toHour}';
      } else if (DateTime(tomorrow.year, tomorrow.month, tomorrow.day) ==
          DateTime(date.year, date.month, date.day)) {
        dateMap['dayString'] = toBeginningOfSentenceCase('demain');
        dateMap['hourString'] =
            'entre ${deliveryHour.fromHour} et ${deliveryHour.toHour}';
      } else {
        dateMap['dayString'] = toBeginningOfSentenceCase(
            '${deliveryHour.dateDisplayText.toLowerCase()}');
        dateMap['hourString'] = 'à ${DateFormat('HH:mm').format(date)}';
      }
    } else {
      dateMap['dayString'] = DateFormat('d LLL y').format(date);
      dateMap['hourString'] = DateFormat('à HH:mm').format(date);
    }

    return dateMap;
  }

  String getDeliveryDateString(BuildContext context) {
    var dayString = getDeliveryDateMap(
        context: context, deliveryTime: _deliveryTime)['dayString'];
    var hourString = getDeliveryDateMap(
        context: context, deliveryTime: _deliveryTime)['hourString'];

    return '$dayString $hourString'.toLowerCase();
  }

  static bool checkDeliveryTime(int deliveryTime) {
    if (deliveryTime == null) {
      return false;
    }

    if (deliveryTime < (DateTime.now().millisecondsSinceEpoch / 1000).round()) {
      return false;
    }

    return DateTime.now()
        .add(Duration(days: maxDeliveryDaysCount))
        .isAfter(DateTime.fromMillisecondsSinceEpoch(deliveryTime * 1000));
  }

  static DeliveryDate getDeliveryDate(BuildContext context, int deliveryTime) {
    var date = DateTime.fromMillisecondsSinceEpoch(deliveryTime * 1000);

    if (!checkDeliveryTime(deliveryTime)) {
      return getDeliveryDates(context)[0];
    }

    var minDate = DateTime.now();

    var maxDate =
        DateTime.now().add(Duration(days: (maxDeliveryDaysCount - 1).toInt()));

    maxDate =
        DateTime(maxDate.year, maxDate.month, maxDate.day, 22, 1, 0, 0, 0);
    DeliveryDate deliveryDate;

    if (minDate.isBefore(date) && maxDate.isAfter(date)) {
      getDeliveryDates(context).forEach((d) {
        var currentDate = DateTime.parse(d.date);

        if (DateTime(currentDate.year, currentDate.month, currentDate.day) ==
            DateTime(date.year, date.month, date.day)) {
          deliveryDate = d;
        }
      });
    }

    return deliveryDate;
  }

  static DeliveryHour getDeliveryHour(BuildContext context, int deliveryTime) {
    var date = DateTime.fromMillisecondsSinceEpoch(deliveryTime * 1000);

    DeliveryDate deliveryDate = getDeliveryDate(context, deliveryTime);
    DeliveryHour deliveryHour;

    if (deliveryDate == null) {
      return null;
    }

    if (!checkDeliveryTime(deliveryTime)) {
      return deliveryDate.hours[0];
    }

    deliveryDate.hours.forEach((h) {
      if (DateTime.parse(h.fromDate).isBefore(date) &&
          DateTime.parse(h.toDate).isAfter(date)) {
        deliveryHour = h;
      }
    });

    return deliveryHour;
  }

  static List<DeliveryHour> getHourList(BuildContext context, String date) {
    var start = DateTime.parse(date);
    var today = DateTime.now();

    if (DateTime(today.year, today.month, today.day) ==
        DateTime(start.year, start.month, start.day)) {
      start = DateTime.now();
    }

    List<DeliveryHour> hours = [];

    var remainder = (intervalDeliveryTime / 2) -
        (start.minute % (intervalDeliveryTime / 2));

    var startDate = start
        .add(Duration(minutes: remainder.toInt()))
        .subtract(Duration(minutes: intervalDeliveryTime ~/ 2));

    startDate = DateTime(startDate.year, startDate.month, startDate.day,
        startDate.hour, startDate.minute, 0, 0, 0);

    var maxDate = DateTime(
        startDate.year, startDate.month, startDate.day, 22, 1, 0, 0, 0);

    var endDate = startDate.add(Duration(minutes: intervalDeliveryTime));

    var beforeTime = TimeOfDay(hour: 6, minute: 0);
    var afterTime = TimeOfDay(hour: 22, minute: 0);

    do {
      double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

      var startTime = TimeOfDay.fromDateTime(startDate);
      var endTime = TimeOfDay.fromDateTime(endDate);

      if ((toDouble(startTime) >= toDouble(beforeTime) &&
              toDouble(startTime) <= toDouble(afterTime)) ||
          toDouble(startTime) == toDouble(beforeTime) ||
          toDouble(endTime) == toDouble(afterTime)) {
        var fromHour = DateFormat('HH:mm').format(startDate);
        var toHour = DateFormat('HH:mm').format(endDate);
        var displayText = fromHour + ' - ' + toHour;

        var fromDate = DateFormat('yyyy-MM-dd HH:mm').format(startDate);
        var toDate = DateFormat('yyyy-MM-dd HH:mm').format(endDate);
        var timestamp = (endDate
                    .subtract(Duration(minutes: intervalDeliveryTime ~/ 2))
                    .millisecondsSinceEpoch /
                1000)
            .round();

        hours.add(DeliveryHour(
            timestamp: timestamp,
            fromDate: fromDate,
            toDate: toDate,
            displayText: displayText,
            fromHour: fromHour,
            toHour: toHour,
            dateDisplayText: getDayDisplayText(context,
                DateTime.fromMillisecondsSinceEpoch(timestamp * 1000))));
      }

      startDate = startDate.add(Duration(minutes: intervalDeliveryTime ~/ 2));
      endDate = startDate.add(Duration(minutes: intervalDeliveryTime.toInt()));
    } while (endDate.isBefore(maxDate));

    return hours;
  }

  static List<DeliveryDate> getDeliveryDates(BuildContext context) {
    List<DeliveryDate> deliveryDates = [];

    for (var i = 0; i < maxDeliveryDaysCount; i++) {
      var date = DateTime.now();

      if (deliveryDates.length > 0) {
        date = DateTime.parse(deliveryDates[i - 1].date).add(Duration(days: 1));
      }

      var displayText =
          toBeginningOfSentenceCase(getDayDisplayText(context, date));

      deliveryDates.add(DeliveryDate(
          date: DateFormat('yyyy-MM-dd').format(date),
          displayText: displayText,
          hours: getHourList(context, DateFormat('yyyy-MM-dd').format(date))));
    }

    return deliveryDates;
  }

  static String getDayDisplayText(BuildContext context, DateTime date) {
    var today = DateTime.now();
    var tomorrow = today.add(Duration(days: 1));

    var displayText =
        toBeginningOfSentenceCase(DateFormat('EEEE').format(date));

    if (DateTime(today.year, today.month, today.day) ==
        DateTime(date.year, date.month, date.day)) {
      displayText = 'Aujoudh\hui';
    }

    if (DateTime(tomorrow.year, tomorrow.month, tomorrow.day) ==
        DateTime(date.year, date.month, date.day)) {
      displayText = 'Demain';
    }

    return displayText;
  }
}
