import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'date_selector.dart';

class BasicTimeField extends StatefulWidget {
  final bool delivery;
  final int deliveryTime;
  final Future Function(BuildContext, int) onSave;
  final Future Function(BuildContext, bool) onDeliveryModeChange;
  final void Function(BuildContext context, dynamic error) onError;
  const BasicTimeField({
    Key key,
    this.delivery,
    this.deliveryTime,
    this.onSave,
    this.onDeliveryModeChange,
    this.onError,
  }) : super(key: key);
  @override
  State<BasicTimeField> createState() => _BasicTimeFieldState();
}

class _BasicTimeFieldState extends State<BasicTimeField> {
  var _deliveryTime;
  var _savedDeliveryTime;
  String _groupValue;

  DeliveryDate _deliveryDate;
  DeliveryHour _deliveryHour;
  List<DeliveryDate> _deliveryDates = [];
  List<DeliveryHour> _deliveryHours = [];

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

      _deliveryTime = _deliveryHour.timestamp;
    });
  }

  void _changeDeliveryDate(deliveryDate) {
    setState(() {
      _deliveryDate = _deliveryDates.firstWhere(
          (element) => element.date == deliveryDate,
          orElse: () => null);

      _deliveryHours = _deliveryDate.hours;

      _deliveryHour = _deliveryHours.first;

      _deliveryTime = _deliveryHour.timestamp;

      widget.onDeliveryModeChange(context, _deliveryTime);
    });
  }

  void _changeDeliveryHour(deliveryTime) {
    setState(() {
      _deliveryHour = _deliveryHours.firstWhere(
          (element) => element.timestamp.toString() == deliveryTime,
          orElse: () => null);

      _deliveryTime = _deliveryHour.timestamp;

      widget.onDeliveryModeChange(context, _deliveryTime);
    });
  }

  @override
  void initState() {
    _deliveryTime = widget.deliveryTime;

    _savedDeliveryTime = widget.deliveryTime;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _initDeliveryTime(_deliveryTime);
    if (_deliveryTime != null) {}
    super.didChangeDependencies();
  }

  ValueChanged<String> _valueChangedHandler() {
    return (value) => setState(() => _groupValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: (MediaQuery.of(context).size.width - 80) * 0.48,
                child: DropdownButtonFormField(
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
                )),
            Container(
              width: (MediaQuery.of(context).size.width - 80) * 0.48,
              child: DropdownButtonFormField(
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
            ),
            SizedBox(
              width: (MediaQuery.of(context).size.width - 80) * 0.02,
            ),
          ],
        ),
      ),

      // DateTimeField(
      //   format: format,
      //   decoration: InputDecoration(
      //      prefixIcon: const Icon(
      //             Icons.timer,
      //             color: Colors.grey,
      //           ),
      //            hintText: 'Nom',
      //           border: OutlineInputBorder(
      //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
      //           ),
      //         ),
      //           initialValue: DateTime.now(),
      //        // controller: controllerAddress,
      //         onSaved: (value) {
      //           debugPrint(value.toString());
      //         },
      //         onShowPicker: (context, currentValue) async {
      //     final time = await showTimePicker(
      //       context: context,
      //       initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
      //     );
      //     return DateTimeField.convert(time);
      //   },
      //   ),
    ]);
  }
}
