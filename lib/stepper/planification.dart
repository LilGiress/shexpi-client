import 'package:flutter/material.dart';

import 'date_selector.dart';

class PlanificationRamassage extends StatefulWidget {
  final bool delivery;
  final int deliveryTime;
  final Future Function(BuildContext, int) onSave;
  final Future Function(BuildContext, bool) onDeliveryModeChange;
  final void Function(BuildContext context, dynamic error) onError;

  const PlanificationRamassage({
    Key key,
    this.delivery,
    this.deliveryTime,
    this.onSave,
    this.onDeliveryModeChange,
    this.onError,
  }) : super(key: key);

  @override
  State<PlanificationRamassage> createState() {
    return PlanificationRamassageState();
  }
}

enum Character { isPossible, isTard }

class PlanificationRamassageState extends State<PlanificationRamassage> {
  static var controllerChoix = TextEditingController();
  static var controllerAddress = TextEditingController();
  static var controllerMobileNo = TextEditingController();
  static var controllerGender = TextEditingController();
  var deliveryTime;
  //var deliveryHour;
  var _savedDeliveryTime;

  DeliveryDate _deliveryDate;
  DeliveryHour _deliveryHour;
  List<DeliveryDate> _deliveryDates = [];
  List<DeliveryHour> _deliveryHours = [];
  bool isPossible = true;
  bool isTard = false;
  var validationError;

  void _initDeliveryTime(deliveryTime) {
    setState(() {
      _deliveryDates = DateSelector.getDeliveryDates(context);

      _deliveryDate = deliveryTime != null
          ? DateSelector.getDeliveryDate(context, deliveryTime)
          : _deliveryDates.first;

      _deliveryHours = _deliveryDate.hours;

      _deliveryHour = deliveryTime != null
          ? DateSelector.getDeliveryHour(context, deliveryTime)
          : _deliveryHours.first;

      deliveryTime = _deliveryHour.timestamp;
    });
  }

  void _changeDeliveryDate(deliveryDate) {
    setState(() {
      _deliveryDate = _deliveryDates.firstWhere(
          (element) => element.date == deliveryDate,
          orElse: () => null);

      _deliveryHours = _deliveryDate.hours;

      _deliveryHour = _deliveryHours.first;

      deliveryTime = _deliveryHour.timestamp;

      widget.onDeliveryModeChange(context, deliveryTime);
    });
  }

  void _changeDeliveryHour(deliveryTime) {
    setState(() {
      _deliveryHour = _deliveryHours.firstWhere(
          (element) => element.timestamp.toString() == deliveryTime,
          orElse: () => null);

      deliveryTime = _deliveryHour.timestamp;

      widget.onDeliveryModeChange(context, deliveryTime);
    });
  }

  @override
  void initState() {
    deliveryTime = widget.deliveryTime;

    _savedDeliveryTime = widget.deliveryTime;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _initDeliveryTime(deliveryTime);
    if (deliveryTime != null) {}
    super.didChangeDependencies();
  }

////////////////////////////// pour les bouttons
  ///

  static Character Auto = Character.isPossible;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Center(
          child: Text(
            "Planification du ramassage du colis",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 20),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        _ButtonColise(),
        _ButtonPersonnalite(Auto),
      ]),
    );
  }

  String getValidationError(String field) {
    if (validationError == null || validationError[field] == null) {
      return null;
    }

    return validationError[field][0];
  }

  Widget _ButtonPersonnalite(Auto) {
    if (Auto == Character.isTard) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                DropdownButtonFormField(
                  isExpanded: true,
                  value: _deliveryDate.date,
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 20,
                  elevation: 16,
                  style: Theme.of(context).textTheme.subtitle1,
                  onChanged: _changeDeliveryDate,
                  items: _deliveryDates
                      .map<DropdownMenuItem<String>>((DeliveryDate date) {
                    return DropdownMenuItem<String>(
                      value: date.date,
                      child: Text(date.displayText),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              children: [
                DropdownButtonFormField(
                  isExpanded: true,
                  value: _deliveryHour.timestamp.toString(),
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 20,
                  elevation: 16,
                  style: Theme.of(context).textTheme.subtitle1,
                  onChanged: _changeDeliveryHour,
                  items: _deliveryHours
                      .map<DropdownMenuItem<String>>((DeliveryHour value) {
                    return DropdownMenuItem<String>(
                      value: value.timestamp.toString(),
                      child: Text(value.displayText),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _ButtonColise() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Aussitôt que possible'),
                    leading: Radio<Character>(
                      value: Character.isPossible,
                      groupValue: Auto,
                      onChanged: (Character value) {
                        setState(() {
                          Auto = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Pour plus tard'),
                    leading: Radio<Character>(
                      value: Character.isTard,
                      groupValue: Auto,
                      onChanged: (Character value) {
                        setState(() {
                          Auto = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
