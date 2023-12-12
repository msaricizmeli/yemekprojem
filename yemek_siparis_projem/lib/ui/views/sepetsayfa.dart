import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis_projem/data/entity/sepetyemekler.dart';
import 'package:yemek_siparis_projem/ui/cubit/sepetsayfacubit.dart';
import 'package:yemek_siparis_projem/ui/views/anasayfa.dart';

class SepetSayfa extends StatefulWidget {
  const SepetSayfa({Key? key}) : super(key: key);


  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SepetsayfaCubit>().sepetYemekler();
  }

  Future<bool> anasayfaDonus(BuildContext context) async{
    Navigator.of(context).popUntil((route) => route.isFirst);
    return true;
  }
  void butonShowDiolog(){
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text("Siparişiniz Hazırlanıyor."),icon: Icon(Icons.check_circle),
      actions: [
        TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Anasayfa()));
        },
            child: Text("Menüye Dön")),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: ()=> anasayfaDonus(context),
      child: Scaffold(
        appBar: AppBar(title: Text("Sepetim"),centerTitle: true,
          backgroundColor: Colors.redAccent,
          leading: IconButton(onPressed: (){
            Navigator.of(context).popUntil((route) => route.isFirst);
          },icon: Icon(Icons.clear))),
        body: BlocBuilder<SepetsayfaCubit,List<SepetYemekler>>(
          builder: (context, sepetYemekListesi){
            if(sepetYemekListesi.isNotEmpty){
              var toplam = 0;
              for(var sepetYemek in sepetYemekListesi){
                toplam += int.parse(sepetYemek.yemek_fiyat) * int.parse(sepetYemek.yemek_siparis_adet);
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: ListView.builder(
                    itemCount: sepetYemekListesi.length,
                    itemBuilder: (context, index) {
                      var yemek = sepetYemekListesi[index];

                      return Card(
                        child: SizedBox(height: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(yemek.yemek_adi,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                    Text("Fiyat : ${yemek.yemek_fiyat} ₺",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                    Text("Adet : ${yemek.yemek_siparis_adet} "),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(onPressed: (){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("${yemek.yemek_adi} Sepetten Çıkartılsın Mı?"),
                                        action: SnackBarAction(
                                          label: "Evet", onPressed: (){
                                          context.read<SepetsayfaCubit>().sil(yemek.sepet_yemek_id, "mert");
                                          context.read<SepetsayfaCubit>().sepetYemekler();
                                        },
                                        ),
                                      ),
                                    );
                                  },
                                      icon: Icon(Icons.delete)
                                  ),
                                  Text("${(int.parse(yemek.yemek_fiyat)*int.parse(yemek.yemek_siparis_adet))} ₺".toString()),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  ),
                  Container(height: 100,child: Text("Sepet Toplam : $toplam ₺",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),),
                ],
              );
            } else {
              return Center( child: Text("Sepetiniz Boş"));
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, floatingActionButton: Container(height: 50,
        margin: const EdgeInsets.all(1), child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          onPressed: butonShowDiolog,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: const Center(
              child: Text('SEPETİMİ ONAYLA',style: TextStyle(fontSize: 20,color: Colors.white),),
            ),
          ),
        ),
      ),
      ),
    );
  }
}
