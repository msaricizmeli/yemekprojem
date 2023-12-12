import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis_projem/data/entity/yemekler.dart';
import 'package:yemek_siparis_projem/data/repo/yemekler_dao_repo.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>>{
  AnasayfaCubit():super(<Yemekler>[]);
  var mrepo = YemeklerDaoRepository();

  Future<void> yemekleriYukle() async {
    var liste = await mrepo.YemekleriYukle();
    emit(liste);
  }
  Future<void> ara (String aramaKelimesi) async {
    var liste = await mrepo.Ara(aramaKelimesi.toLowerCase());
    emit(liste);
  }
}