import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis_projem/ui/cubit/anasayfacubit.dart';
import 'package:yemek_siparis_projem/ui/cubit/detaysayfacubit.dart';
import 'package:yemek_siparis_projem/ui/cubit/sepetsayfacubit.dart';
import 'package:yemek_siparis_projem/ui/views/anasayfa.dart';


void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnasayfaCubit(),),
        BlocProvider(create: (context) => SepetsayfaCubit(),),
        BlocProvider(create: (context) => DetaysayfaCubit(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  Anasayfa(),
      ),
    );
  }
}
