

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/get_transaction_list_response_model.dart';
// import 'package:uremit/globleitems/colors.dart';

class TreeDesign extends StatefulWidget {
  TreeDesign({required this.statusList, Key? key}) : super(key: key);
  List<StatusList> statusList;

  @override
  _TreeDesignState createState() => _TreeDesignState();
}

class _TreeDesignState extends State<TreeDesign> {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: SizedBox(
        // height: MediaQuery.of(context).size.height * 0.4 - 50,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Container(
            color: Colors.transparent,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.loose,
              children: [
                //vertical line between the date timings and text
                Container(
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Colors.grey),
                  width: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  height:((widget.statusList.length*35)+((widget.statusList.fold(0, (int previousValue, element) => previousValue+element.status.length))*35)).toDouble() ,
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < widget.statusList.length; i++)
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            widget.statusList[i].date,
                                            textAlign: TextAlign.end,
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                            ),
                                          ),
                                          //this is horizontal line right next to date
                                          Container(
                                            margin:
                                            const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            decoration: ShapeDecoration(
                                                shape:
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        5)),
                                                color: Colors.grey),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width /
                                                9,
                                            height: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [],
                                    ),
                                  ),
                                ],
                              ),
                              for (int j = 0;
                              j < widget.statusList[i].status.length;
                              j++)
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        color: Colors.transparent,
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              widget.statusList[i].status[j]
                                                  .time,
                                              style: GoogleFonts.poppins(
                                                fontSize: 8,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white70,
                                              ),
                                              textAlign: TextAlign.end,
                                            ),
                                            _horizontalLine(isTime: true)
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                         _horizontalLine(isText: true),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width /
                                                4,
                                            padding:
                                            const EdgeInsets.symmetric(
                                                vertical: 4,
                                                horizontal: 2),
                                            margin:
                                            const EdgeInsets.symmetric(
                                                vertical: 1.5,
                                                horizontal: 0),
                                            decoration: const BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        5))),
                                            child: Text(
                                              widget.statusList[i].status[j]
                                                  .text,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                fontSize: 6,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(
                                height: 5.h,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );



  }
  Widget _horizontalLine({bool isText=false,bool isTime=false}){
    return  Container(
      margin:  EdgeInsets.only(
          left: 5,right:isText?0: 5),
      decoration: ShapeDecoration(
          shape:
          RoundedRectangleBorder(
              borderRadius:
              BorderRadius
                  .circular(
                  5)),
          color:isTime?null: Colors.grey),
      width: MediaQuery.of(context)
          .size
          .width /
          10,
      height: 1.5,
    );
  }
}

