import 'package:flutter/material.dart';
import 'package:mycar/Language/appLocalizations.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

// import '../../generated/l10n.dart';
// import '../../helpers/app_media_query.dart';
// import '../../widgets/DeliveryModeToggleWidget.dart';
// import '../../widgets/bottomSheets/DeliveryTimeWidget.dart';
import 'DeliveryTimeWidget.dart';

class ScheduleDeliveryBottomSheetWidget extends StatefulWidget {
  final bool delivery;
  final int deliveryTime;
  final Future Function(BuildContext, int) onSave;
  final Future Function(BuildContext, bool) onDeliveryModeChange;
  final void Function(BuildContext context, dynamic error) onError;

  ScheduleDeliveryBottomSheetWidget({
     this.deliveryTime,
     this.delivery,
     this.onSave,
     this.onDeliveryModeChange,
     this.onError
  });

  @override
  _ScheduleDeliveryBottomSheetWidgetState createState() => _ScheduleDeliveryBottomSheetWidgetState();
}

class _ScheduleDeliveryBottomSheetWidgetState extends State<ScheduleDeliveryBottomSheetWidget> {

  var _deliveryTime;
   bool _delivery;
  bool _savingSchedule = false;

  Future<void> _applyChanges() async {
    try {
      setState(() {
        _savingSchedule= true;
      });

      await widget.onSave(context, _deliveryTime);

      Navigator.of(context).pop();

    } catch(e) {
      if (widget.onError == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of('error_occurred')),
        ));
      } else {
        widget.onError(context, e);
      }
      print(e);
    }

    if (mounted) {
      setState(() {
        _savingSchedule = false;
      });
    }

  }

  @override
  void initState() {
    _delivery = widget.delivery;
    _deliveryTime = widget.deliveryTime;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.4),
              blurRadius: 30,
              offset: Offset(0, -30)),
        ],
      ),
      child: Stack(
        children: <Widget>[


          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 20, bottom: 40, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    // child: DeliveryModeToggleWidget(
                    //   delivery: _delivery,
                    //   onChange: widget.onDeliveryModeChange,
                    // ),
                  ),

                  DeliveryTimeWidget(
                    deliveryTime: _deliveryTime,
                    onDeliveryTimeChanged: (deliveryTime) {
                      setState(() {
                        _deliveryTime = deliveryTime;
                      });
                    },
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: _deliveryTime != null ? 10 : 12),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: MaterialButton(
                        elevation: 4,
                        focusElevation: 0,
                        highlightElevation: 0,
                        onPressed: _savingSchedule ? null : _applyChanges,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        color: Theme.of(context).colorScheme.secondary,
                        disabledColor: Theme.of(context).focusColor.withOpacity(0.5),
                        shape: StadiumBorder(),
                        child: Text(
                          AppLocalizations.of('context'),
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 30,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                vertical: 13, 
               // AppMediaQuery(context).appWidth(42)
                ),
            decoration: BoxDecoration(
              color: Theme.of(context).focusColor.withOpacity(0.05),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(22), topLeft: Radius.circular(22)),
            ),
            child: Container(
              width: 30,
              decoration: BoxDecoration(
                color: Theme.of(context).focusColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(3),
              ),
              //child: SizedBox(height: 1,),
            ),
          ),
        ],
      ),
    );
  }
}
