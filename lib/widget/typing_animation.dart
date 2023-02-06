import 'package:flutter/material.dart';

class TypingLoading extends StatefulWidget {
  const TypingLoading({super.key});

  @override
  State<TypingLoading> createState() => _TypingLoadingState();
}

class _TypingLoadingState extends State<TypingLoading> with TickerProviderStateMixin{

  AnimationController? animationController;
  int currentIndex=0;
  @override
  void initState() {
    animationController=AnimationController(vsync:this,duration:Duration(milliseconds:400));
    animationController!.addStatusListener((status) {
      if(status==AnimationStatus.completed){
        currentIndex++;
        if(currentIndex==3){
          currentIndex=0;
        }
        animationController!.reset();
        animationController!.forward();
      }
    });
    animationController!.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (_,child){
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:MainAxisAlignment.center,
          children: List.generate(3,(index){
            return Container(
              margin:EdgeInsets.all(3),
              height: 7,
              width: 7,
              decoration:BoxDecoration(
                  color:index==currentIndex?Colors.redAccent:Colors.grey,
                  shape:BoxShape.circle
              ),
            );
        }),
        );
      },
    );
  }
}