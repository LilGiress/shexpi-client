// import 'package:asktatchop/generated/l10n.dart';
// import 'package:asktatchop/models/delivery_date.dart';
// import 'package:asktatchop/providers/search.dart';
import 'package:flutter/material.dart';
import 'package:mycar/Language/appLocalizations.dart';

import 'date_selector.dart';

class DeliveryTimeWidget extends StatefulWidget {
  final int deliveryTime;
  final Function(int deliveryDate) onDeliveryTimeChanged;

  DeliveryTimeWidget({
     this.deliveryTime,
     this.onDeliveryTimeChanged,
  });

  @override
  _DeliveryTimeWidgetState createState() => _DeliveryTimeWidgetState();
}

class _DeliveryTimeWidgetState extends State<DeliveryTimeWidget> {

  var _deliveryTime;
  var _savedDeliveryTime;

   DeliveryDate _deliveryDate;
   DeliveryHour _deliveryHour;
  List<DeliveryDate> _deliveryDates = [];
  List<DeliveryHour> _deliveryHours = [];


  void _initDeliveryTime(deliveryTime) {

    setState(() {
      _deliveryDates = DateSelector.getDeliveryDates(context);

      _deliveryDate = deliveryTime != null ?
      DateSelector.getDeliveryDate(context, deliveryTime) : _deliveryDates.first;

      _deliveryHours = _deliveryDate.hours;

      _deliveryHour = (deliveryTime != null ?
      DateSelector.getDeliveryHour(context, deliveryTime) : _deliveryHours.first);

      _deliveryTime = _deliveryHour.timestamp;
    });

  }
  void _changeDeliveryDate(deliveryDate) {

    setState(() {
      _deliveryDate = _deliveryDates.firstWhere((element) => element.date == deliveryDate, orElse: () => null);

      _deliveryHours = _deliveryDate.hours;

      _deliveryHour = _deliveryHours.first;

      _deliveryTime = _deliveryHour.timestamp;

      widget.onDeliveryTimeChanged(_deliveryTime);
    });
  }

  void _changeDeliveryHour(deliveryTime) {
    setState(() {
      _deliveryHour = _deliveryHours.firstWhere((element) => element.timestamp.toString() == deliveryTime, orElse: ()=> null);

      _deliveryTime = _deliveryHour.timestamp;

      widget.onDeliveryTimeChanged(_deliveryTime);

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
    // if (_deliveryTime != null) {
    //   _initDeliveryTime(_deliveryTime);
    // }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _savedDeliveryTime = _deliveryTime;
                _deliveryTime = null;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                    width: (MediaQuery.of(context).size.width - 40) * 0.1,
                    child: Icon(Icons.flash_on)
                ),

                Container(
                  width: (MediaQuery.of(context).size.width - 40) * 0.8,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    AppLocalizations.of('as_soon_as_possible'),
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .color,
                        fontSize: 14
                    ),

                  ),
                ),

                Container(
                  width: (MediaQuery.of(context).size.width - 40) * 0.1,
                  child: Radio(
                      toggleable: true,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _deliveryTime = null;
                          });
                        }
                      },
                      value: true,
                      groupValue: _deliveryTime == null
                  ),

                )
              ],

            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: GestureDetector(
            onTap: () => _initDeliveryTime(_savedDeliveryTime),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                    width: (MediaQuery.of(context).size.width - 40) * 0.1,
                    child: Icon(Icons.schedule)
                ),

                Container(
                  width: (MediaQuery.of(context).size.width - 40) * 0.8,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    AppLocalizations.of('schedule_for_later'),
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .color,
                        fontSize: 14
                    ),

                  ),
                ),

                Container(
                  width: (MediaQuery.of(context).size.width - 40) * 0.1,
                  child: Radio(
                      toggleable: true,
                      onChanged: (value) {
                        if (value != null) {
                          _initDeliveryTime(_deliveryTime);
                        }
                      },
                      value: true,
                      groupValue: _deliveryTime != null
                  ),

                )
              ],

            ),
          ),
        ),

        if (_deliveryTime != null)
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: (MediaQuery.of(context).size.width - 80) * 0.02,),
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

                    )
                ),

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
                SizedBox(width: (MediaQuery.of(context).size.width - 80) * 0.02,),

              ],

            ),
          ),
      ],
    );
  }
}
