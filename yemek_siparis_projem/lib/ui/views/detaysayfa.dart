import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis_projem/data/entity/yemekler.dart';
import 'package:yemek_siparis_projem/ui/cubit/detaysayfacubit.dart';
import 'package:yemek_siparis_projem/ui/cubit/sepetsayfacubit.dart';

class DetaySayfa extends StatefulWidget {

  Yemekler yemek;
  DetaySayfa({required this.yemek});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var adet = 0;
  var toplamFiyat = 0;
  bool tf = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle:true,
          backgroundColor: Colors.redAccent,
        title: Text("Ürün Detayları",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
            icon: Icon(Icons.clear)),
      ),
      body:Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            children: [
              Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),
              Text("${widget.yemek.yemek_adi} ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              Text("${widget.yemek.yemek_fiyat} ₺ ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){
                    setState(() {
                      if(adet<1){adet=0;}
                      else{adet=adet-1;
                      if(adet==0){tf=false;}
                      else{tf=true;}
                      }
                      var fiyat = int.parse(widget.yemek.yemek_fiyat);
                      toplamFiyat = fiyat * adet;
                    });
                  }, icon: Icon(Icons.indeterminate_check_box_rounded)),
                  Text(adet.toString(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  IconButton(onPressed: (){
                    setState(() {
                      adet= adet +1;
                      tf = true;
                      var fiyat = int.parse(widget.yemek.yemek_fiyat);
                      toplamFiyat = fiyat * adet;
                    });
                  }, icon: Icon(Icons.add_box)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Teslimat süresi 10-15 DK "),
                  Text("İndirim %10"),
                ],
              ),
              Text("Toplam Fiyat : $toplamFiyat ₺"),
              Visibility(
                visible: tf,
                child: ElevatedButton(onPressed: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => SepetSayfa(),));
                  context.read<DetaysayfaCubit>().kaydet(widget.yemek.yemek_adi,widget.yemek.yemek_resim_adi,int.parse(widget.yemek.yemek_fiyat), adet, "mert");
                  context.read<SepetsayfaCubit>().sepetYemekler();
                  Navigator.of(context).pop();
                }, child: Text("Sepete Ekle"),
                ),
              ),
            ],
          ),
        ),
      ) ,
    );
  }
}
