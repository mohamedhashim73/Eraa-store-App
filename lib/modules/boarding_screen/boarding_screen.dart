import 'package:flutter/material.dart';
import '../../models/boardingModel.dart';
import '../../shared/components/constants.dart';
import '../../shared/components/defaultButtons.dart';
import '../../shared/components/defaultPackages.dart';
import '../../shared/local/cacheHelper.dart';

class BoardingScreen extends StatefulWidget {
  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final _pageController = PageController();
  bool lastItem = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 40,),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin : const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment:Alignment.bottomRight,
              margin: const EdgeInsets.only(bottom: 10),
              child: DefaultTextButton(
                  text: const Text("Skip",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 18.5),),
                  onTap: (){
                    CacheHelper.SaveData(key: 'boardingShown', value: true).then((value){
                      if(value == true) {
                        Navigator.pushReplacementNamed(context,'loginScreen');
                      }
                    });
                  }),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index)
                {
                  setState(() {
                    // to be able to go Login after click on Next((Button)).
                    if(index == BoardingItems.length-1) {
                      setState(() {
                        lastItem = true;
                      });
                    }
                  });
                },
                physics: const BouncingScrollPhysics(),
                itemCount: BoardingItems.length,
                  itemBuilder: (context,i){
                    return buildBoardingView(model: BoardingItems[i]);
                  }),
            ),
            const SizedBox(height: 35,),
            Center(
              child: DefaultSmoothIndicator(controller: _pageController,length: BoardingItems.length, radius: 20,size: 15.0),
            ),
            const SizedBox(height: 50,),
            Container(
                alignment:Alignment.bottomRight,
                margin: const EdgeInsets.only(bottom: 15),
                child: DefaultTextButton(
                    text: const Text("Next",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 20),),
                    onTap: ()
                    {
                      if(lastItem){
                        CacheHelper.SaveData(key: 'boardingShown', value: true).then((value){
                          if(value == true)
                          {
                            print("boardingShown Saved successfully");
                            Navigator.pushReplacementNamed(context,'loginScreen');
                          }
                          });
                        }
                      else {
                        _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInQuad);
                      }
                    }
                ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingView({required BoardingModel model}){
    return Column(
      children:
      [
        Expanded(child: Image.asset(model.image,fit: BoxFit.fill,width: double.infinity)),
        const SizedBox(height: 30,),
        Center(child: Text(model.title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: mainColor),textAlign: TextAlign.center,)),
        const SizedBox(height: 7.5,),
        Center(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(model.description,textAlign:TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.normal,fontSize: 13,color: blackColor.withOpacity(0.5)),),
        )),
      ],
    );
  }
}
