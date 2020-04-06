import 'package:chamcongapp/blocs/employees_bloc/employees_bloc.dart';
import 'package:chamcongapp/data/model/employeesModel.dart';
import 'package:chamcongapp/screens/empoyees/infoEmployeeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeesPage extends StatefulWidget {
  @override
  _EmployeesPageState createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  // List<Employee> employeesList;

  final _employeeBloc = EmployeesBloc();
  @override
  void dispose() {
    _employeeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        builder: (BuildContext context) =>
            _employeeBloc..add(LoadEmployeesEvent()),
        child: BlocListener<EmployeesBloc, EmployeesState>(
          listener: (context, state) {
            if (state is ErrorState) {
              _diaLog(state.errorTitle, state.errorMessage);
            }
          },
          child: BlocBuilder<EmployeesBloc, EmployeesState>(
            builder: (BuildContext context, EmployeesState state) {
              if (state is LoadingState) {
                return _loadingData(context);
              } else if (state is LoadedState) {
                return _buildList(context, state.employeesList);
              } else {
                return _buildEmptyBody();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _loadingData(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildEmptyBody() {
    return Center(
      child: const Text("</ Không có dữ liệu />"),
    );
  }

  Widget _buildList(BuildContext context, List<Employee> employeeList) {
    List<Employee> employeesList = employeeList;
    return employeesList.length == 0
        ? Center(
            child: Text("</ Danh sách rỗng />"),
          )
        : ListView.builder(
            itemCount: employeesList?.length ?? 0,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Icon(Icons.person_pin_circle,size: 50,),
                    title: Text(
                        employeesList[index]?.username ?? "username not found"),
                    subtitle:
                        Text(employeesList[index]?.name ?? "name not found"),
                    trailing: Icon(Icons.edit),
                    onTap: (){Navigator.push(context,
                MaterialPageRoute(builder: (context) => InfoEmployeePage()));},
                  ),
                ),
              );
            },
          );
  }

  Widget _diaLog(String title, String message) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
    );
  }
}
