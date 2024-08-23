import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late Timer _timer;
  Duration _remainingTime = Duration.zero;
  DateTime? _dateTime;
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _loadDateTime();
  }
  Future<void> _clearSavedDateTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('selected_date');
    await prefs.setBool('is_timer_running', false); // Ensure the flag is set to false
  }
  Future<void> _saveDateTime(DateTime dateTime) async {
    final prefs = await SharedPreferences.getInstance();
    // Convert the DateTime to a string
    final dateString = dateTime.toIso8601String();
    await prefs.setString('selected_date', dateString);
    await prefs.setBool('is_timer_running', _isTimerRunning);
  }
  Future<void> _loadDateTime() async {
    final prefs = await SharedPreferences.getInstance();
    final dateString = prefs.getString('selected_date');
    if (dateString != null) {
      setState(() {
        _dateTime = DateTime.parse(dateString);
        _isTimerRunning = prefs.getBool('is_timer_running') ?? false;
      });
      if (_isTimerRunning) {
        _startTimer();
      }
    }
  }


  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_dateTime != null) {
        final newRemainingTime = _dateTime!.difference(DateTime.now());

          setState(() {
            _remainingTime = newRemainingTime;
            _isTimerRunning = true;

          });
        }

    });
  }
  void _stopTimer() {
    _timer.cancel();
    setState(() {
      _remainingTime = Duration.zero;
      _dateTime = null;
      _isTimerRunning = false;
    });
    _clearSavedDateTime();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime(2025,6,13),
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime(2026),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.deepPurple,
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime = value;
          _saveDateTime(_dateTime!);
          _startTimer(); // Restart the timer when a new date is selected
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final months = (_remainingTime.inDays / 30).floor();
    final days = (_remainingTime.inDays % 30).toString().padLeft(2, '0');
    final hours = (_remainingTime.inHours % 24).toString().padLeft(2, '0');
    final minutes = (_remainingTime.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (_remainingTime.inSeconds % 60).toString().padLeft(2, '0');

    final dateFormat = DateFormat('dd-MM-yyyy');
    final formattedDate = _dateTime != null
        ? dateFormat.format(_dateTime!)
        : '';

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.5,
                child: SvgPicture.asset('assets/images/timer.svg', fit: BoxFit.cover,),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.10,),
              if (_dateTime != null)
                Text(
                  'عدد الأشــهر الـمتبقية: $months\n'
                      'عدد الأيــام الــمتبقيـة: $days\n'
                      'عدد الساعات المتبقية: $hours\n'
                      'عدد الدقائق المتبقية  : $minutes\n'
                      'عدد الثـواني الـمتبقية  : $seconds',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.right,
                ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
              if (_isTimerRunning)
                Text(
                  'تاريخ البكالوريا هو: $formattedDate',
                  style: TextStyle(fontSize: 20,fontWeight:FontWeight.w500 ),


                  textAlign: TextAlign.right,
                ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.7, 60),
                ),
                onPressed: () {
                  if (_isTimerRunning) {
                    _stopTimer();
                  } else {
                    _showDatePicker();
                  }
                },
                child:  Text(
                  _isTimerRunning ? 'ايقاف المؤقت' : 'اضافة تاريخ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
