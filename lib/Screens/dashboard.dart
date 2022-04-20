import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Models/Finance.dart';
import 'package:untitled/Provider/financeProvider.dart';
import 'package:untitled/Widgets/textfieldwidgets.dart';
import 'package:untitled/constants.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController amountController = new TextEditingController();
  Color dropDownTextColor = Colors.white;
  Color inputIconColor = Colors.green;
  IconData inputIcon = Icons.arrow_downward;
  int totalIncome = 0;
  int totalExpense = 0;
  int saving = 0;
  bool isOpen=false;
  late String dropDownValue;
    late List <String>list;

  @override
  void initState(){
    super.initState();
    list=<String>["Income","Expenses"];
    dropDownValue=list[0];

  }
  Widget? showBottomSheet(){
    if(isOpen){
      return Form(
        key: formKey,
        child: BottomSheet(
         builder: (context){
           return Container(
             decoration: BoxDecoration(
               color: primaryColor,
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(defaultRadius),
                 topRight: Radius.circular(defaultRadius)
               )
             ),
             height: 250,
             width: MediaQuery.of(context).size.width,
             child: Padding(
               padding: const EdgeInsets.all(defaultPadding),
               child: Column(
                 children: [
                   DropdownButtonHideUnderline(
                     child: Container(
                       width: MediaQuery.of(context).size.width/2,
                       margin:EdgeInsets.only(left: defaultPadding,right: defaultPadding),
                       child: DropdownButton(
                         icon: Icon(
                           Icons.keyboard_arrow_down,
                           color: secondaryColor,
                         ),
                         value: dropDownValue,
                           items: list.map<DropdownMenuItem<String>>((value){
                             return DropdownMenuItem<String>(
                               value: value,
                               child: Text(value,style: TextStyle(
                                 color: secondaryColor
                               ),)
                             );
                       }).toList(),
                         onChanged: (String? value) {
                           setState(() {
                             dropDownValue = value!;
                             amountController.text="";
                             if(dropDownValue == "Income"){
                               inputIconColor = Colors.green;
                               inputIcon = Icons.arrow_upward;
                             }else{
                               inputIconColor = Colors.redAccent;
                               inputIcon = Icons.arrow_downward;
                             }
                           });
                         },
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                     child: TextFormField(
                       controller: amountController,
                       keyboardType: TextInputType.number,
                       inputFormatters: [
                         LengthLimitingTextInputFormatter(10)
                       ],
                       validator: (input){
                         if(input?.length == 0){
                           return "Please enter an amount ";
                         }
                         return null;
                       },
                       style: Theme.of(context).textTheme.labelSmall,
                       decoration: InputDecoration(
                         prefixIcon: Icon(
                           inputIcon,
                           color: inputIconColor,
                         ),
                         prefixText: "Rs ",
                         prefixStyle: Theme.of(context).textTheme.labelSmall,
                         focusedBorder: borders(),
                         enabledBorder: borders(),
                         errorBorder: errorBorders(),
                         focusedErrorBorder: errorBorders()
                       ),
                     ),
                   ),
                   ElevatedButton(
                       onPressed: (){
                         if(formKey.currentState!.validate()){
                           setState(() {
                             isOpen = false;

                             // if(dropDownValue=="Income"){
                             //   totalIncome = totalIncome + int.parse(amountController.text.toString());
                             // }else{
                             //   totalExpense = totalExpense + int.parse(amountController.text.toString());
                             // }
                             // saving = totalIncome - totalExpense;

                           });
                           final providers = Provider.of<FinanceProvider>(context,listen:false);
                           providers.updateFinancialRecords(Finance(
                               type: dropDownValue,
                               amount: int.parse(amountController.text.toString())
                           ));
                           totalIncome = providers.totalIncome;
                           totalExpense = providers.totalExpense;
                           saving = providers.savings;
                           amountController.text="";
                           //providers.setFinancialRecords(financialRecords)
                         }
                       },
                       style: ElevatedButton.styleFrom(

                         primary: secondaryColor
                       ),
                       child: Container(
                         width: MediaQuery.of(context).size.width/2,
                         child: Center(
                           child: Text(
                             "Add $dropDownValue"
                           ),
                         ),
                       )
                   )
                 ],
               ),
             ),
           );
         }, onClosing: () {  },
        ),
      );
    }else{
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FinanceProvider>(context,listen:true);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomSheet: showBottomSheet(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
       onPressed: () {
          setState(() {
            isOpen=true;
          });
       },
       child: Icon(
         Icons.add,
       ),
      ),
      appBar: AppBar(
        title: Text(
          "Finance App"
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Consumer<FinanceProvider>(
                builder: (context,data,_){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding/2),
                          child: Column(
                            children: [
                              Text(
                                "Total Income:",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text(
                                "Rs ${data.totalIncome}",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding/2),
                          child: Column(
                            children: [
                              Text(
                                "Total Expenses:",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text(
                                "Rs ${data.totalExpense}",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: defaultPadding/2, horizontal: defaultPadding),
                          child: Column(
                            children: [
                              Text(
                                "Savings:",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text(
                                "Rs ${data.savings}",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: false,
                  itemCount: provider.allFinancialRecords.length,
                  itemBuilder: (BuildContext context,int index) {
                    log("provider.allFinancialRecords= "+provider.allFinancialRecords.length.toString());

                    return ListTile(
                      style: Theme.of(context).listTileTheme.style,
                      title: Text(provider.allFinancialRecords[index].type),
                      leading: Icon(
                        provider.allFinancialRecords[index].type=="Income"?Icons.arrow_upward:Icons.arrow_downward,
                        color: provider.allFinancialRecords[index].type=="Income"?Colors.green:Colors.red,
                      ),
                      trailing: Text(provider.allFinancialRecords[index].type=="Income"?"Rs "+provider.allFinancialRecords[index].amount.toString():"Rs ("+provider.allFinancialRecords[index].amount.toString()+")",style: TextStyle(
                        color: provider.allFinancialRecords[index].type=="Income"?Colors.green:Colors.red,
                      ),),
                );
                  }
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
