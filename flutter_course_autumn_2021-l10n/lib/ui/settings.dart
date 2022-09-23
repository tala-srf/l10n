import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course_autumn_2021/bloc/local_bloc/local_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _local = 'en';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalBloc, LocalState>(
      builder: (context, state) {
        _local = state.local;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              ListTile(
                title: Text('arabic'),
                leading: Radio(
                    value: 'ar',
                    groupValue: _local,
                    onChanged: (value) {
                      BlocProvider.of<LocalBloc>(context)
                          .add(ChangeLocal(value.toString()));
                      setState(() {
                        _local = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: Text('spanish'),
                leading: Radio(
                    value: 'es',
                    groupValue: _local,
                    onChanged: (value) {
                      BlocProvider.of<LocalBloc>(context)
                          .add(ChangeLocal(value.toString()));
                      setState(() {
                        _local = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: Text('english'),
                leading: Radio(
                    value: 'en',
                    groupValue: _local,
                    onChanged: (value) {
                      BlocProvider.of<LocalBloc>(context)
                          .add(ChangeLocal(value.toString()));
                      setState(() {
                        _local = value.toString();
                      });
                    }),
              )
            ],
          ),
        );
      },
    );
  }
}
