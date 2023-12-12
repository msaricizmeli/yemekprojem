import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis_projem/data/entity/yemekler.dart';
import 'package:yemek_siparis_projem/ui/cubit/anasayfacubit.dart';
import 'package:yemek_siparis_projem/ui/views/detaysayfa.dart';
import 'package:yemek_siparis_projem/ui/views/sepetsayfa.dart';



class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});


  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaVarMi = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: aramaVarMi ? TextField(decoration: InputDecoration(hintText: "Ara"),
          onChanged: (aramaSonuc){
            context.read<AnasayfaCubit>().ara(aramaSonuc.toLowerCase());
          },
        ) :
        Text("CAFE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),centerTitle: true,
        actions: [
          aramaVarMi ?
          IconButton(onPressed: (){
            setState(() {
              aramaVarMi = false;
            });
            context.read<AnasayfaCubit>().yemekleriYukle();
          }, icon: Icon(Icons.clear)) :
          IconButton(onPressed: (){
            setState(() {
              aramaVarMi = true;
            });
          }, icon: Icon(Icons.search)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SepetSayfa(),));

          },
              icon: Icon(Icons.shopping_basket))

        ],
      ),
      body: BlocBuilder<AnasayfaCubit,List<Yemekler>>(
        builder: (context,yemeklerListesi){
          if(yemeklerListesi.isNotEmpty){
            return GridView.builder(
              itemCount: yemeklerListesi.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.6),
              itemBuilder: (context, index) {
                var yemek = yemeklerListesi[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(yemek: yemek)));
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                        Text(yemek.yemek_adi,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.directions_run),
                              SizedBox(width: 10,),
                              Text("İste Gelsin"),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${yemek.yemek_fiyat} ₺",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                            IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(yemek: yemek),));
                            },
                              icon: Icon(Icons.add_box),iconSize: 25,),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          else {
            return Center();
          }
        },
      ),
    );
  }
}
