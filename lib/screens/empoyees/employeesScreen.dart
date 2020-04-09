import 'package:chamcongapp/blocs/employees_bloc/employees_bloc.dart';
import 'package:chamcongapp/data/model/employeesModel.dart';
import 'package:chamcongapp/screens/empoyees/addEmployeesScreen.dart';
import 'package:chamcongapp/screens/empoyees/infoEmployeeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeesPage extends StatefulWidget {
  @override
  _EmployeesPageState createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  // final Employees employees;

  final _employeeBloc = EmployeesBloc();
  @override
  void dispose() {
    _employeeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddEmployeesPage()));
        },
        child: Icon(Icons.add),
      ),
      body: BlocProvider(
        builder: (BuildContext context) =>
            _employeeBloc..add(LoadEmployeesEvent()),
        child: BlocListener<EmployeesBloc, EmployeesState>(
          listener: (context, state) {
            if (state is ErrorState) {
              _showDialog(context, state.errorTitle, state.errorMessage);
            } 
            // else if (state is DelSuccessState) {
            //   // _showDialog(state.title, state.message);
            //   BlocProvider.of<EmployeesBloc>(context).add(LoadEmployeesEvent());
            // }
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

  Widget _buildList(BuildContext mainContext, List<Employee> employeeList) {
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
                width: MediaQuery.of(mainContext).size.width,
                height: MediaQuery.of(mainContext).size.height * 0.15,
                padding: EdgeInsets.all(10),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    size: 30,
                  ),
                  title: Text(
                        employeesList[index]?.username ?? "username not found"),
                  subtitle:
                      Text(employeesList[index]?.name ?? "name not found"),
            
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InfoEmployeePage(employee: employeesList[index],)));
                  },
                ),
              ));
            },
          );
  }

  _showDialog(BuildContext mainContext, String title, String message) async {
    await showDialog(
      context: mainContext,
      builder: (context) => AlertDialog(
        title: Text("Bạn thực sự muốn xóa?"),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
