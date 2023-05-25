import 'dart:async';
import 'dart:convert';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:velocity_x/velocity_x.dart';

class PerfilRiesgo extends StatefulWidget {
  final String token;

  PerfilRiesgo({required this.token, Key? key}) : super(key: key);

  @override
  State<PerfilRiesgo> createState() => _PerfilRiesgoState();
}

class _PerfilRiesgoState extends State<PerfilRiesgo> {
  late String userId;
  Map<String, dynamic> userData = {};

  final _formKey = GlobalKey<FormState>();

  String _experienciaInversiones= 'Cual es su nivel de experiencia en inversiones';
  String _poseo = 'He invertido o actualmente poseo algun activo';
  String _generarIngresos = 'Enumere la opcion';
  String _perfil = 'Seleccione perfil';
  String _prioridades = 'Seleccione prioridades';
  String _anosRetiros = 'Seleccione años retiros';
  String _tiempoRetiros = 'Seleccione tiempo retiros';
  // String _valorAhorro = 'Valor del ahorro(millones):';
  String _plazo= 'Plazo(meses):';


  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    fetchUserData();
  }

  void fetchUserData() async {
    var response = await http.get(Uri.parse('http://192.168.1.108:3001/user/$userId'));

    if (response.statusCode == 200) {
      setState(() {
        userData = jsonDecode(response.body);
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

// void saveUserData() async {
//   if (_formKey.currentState!.validate()) {
//     var newData = _newDataController.text;

//     var response = await http.put(
//       Uri.parse('http://192.168.1.108:3001/ahorro/$userId'),
//       body: {
//         'ahorroPara': _ahorroPara == 'Otros' ? newData : _ahorroPara,
//         'valorAhorro': _valorAhorroController.text,
//         'plazoAhorro': _plazo,
//       },
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         userData['ahorroPara'] = _ahorroPara == 'Otros' ? newData : _ahorroPara;
//         userData['valorAhorro'] = _valorAhorroController.text;
//         userData['plazoAhorro'] = _plazo;
//       });

//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Información actualizada'),
//             content: Text('Tu información se almacenó correctamente.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Aceptar'),
//               ),
//             ],
//           );
//         },
//       );

//       setState(() {
//         _ahorroPara = 'Quiero ahorrar para:';
//         // _valorAhorroController = '';
//         _plazo = 'Plazo(meses):';
//       });
//     } else {
//       print('Error al actualizar la información: ${response.statusCode}');
//     }
//   }
// }


  void updateExperienciaInversiones(String? newExperienciaInversiones) {
    setState(() {
      _experienciaInversiones = newExperienciaInversiones!;
    });
  }

  void updatePoseo(String? newPoseo) {
    setState(() {
      _poseo = newPoseo!;
    });
  }

  void updateGenrarIngresos(String? newGenerarIngresos) {
    setState(() {
      _generarIngresos = newGenerarIngresos!;
    });
  }

  void updatePerfil(String? newPerfil) {
    setState(() {
      _perfil = newPerfil!;
    });
  }

  void updatePrioridades(String? newPrioridades) {
    setState(() {
      _prioridades = newPrioridades!;
    });
  }

  void updateAnosRetiros(String? newAnosRetiros) {
    setState(() {
      _anosRetiros = newAnosRetiros!;
    });
  }

  void updateTiempoRetiros(String? newTiempoRetiros) {
    setState(() {
      _tiempoRetiros = newTiempoRetiros!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF524898),
      body: Center(
        child: SingleChildScrollView(
          child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  color: Color(0XFF524898),
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 50),
                      child: Text(
                        'Paso 4: perfil de riesgo',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _experienciaInversiones,
                        onChanged: updateExperienciaInversiones,
                        items: <String>[
                          'Cual es su nivel de experiencia en inversiones',
                          'Alta',
                          'Media',
                          'Baja',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _poseo,
                        onChanged: updatePoseo,
                        items: <String>[
                          'He invertido o actualmente poseo algun activo',
                          'CDT',
                          'Bonos',
                          'Acciones',
                          'Inmuebles'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                   Container(
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: const Text(
                'Pregunta 1: Enumere de 1 al 4 las siguientes objeticos de inversión desde el mas importante (1) al menos improtante (4) para usted',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            ),
            Row(
              children: [
                   Container(
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: const Text(
                'Generar ingresos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15
                ),
              ),
            ),
               Container(
                      padding: EdgeInsets.only(top: 30),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _generarIngresos,
                        onChanged: updateGenrarIngresos,
                        items: <String>[
                          'Enumere la opcion',
                          '1',
                          '2',
                          '3',
                          '4'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),

              ],
            ),
            Row(
              children: [
                   Container(
                    width: 180,
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: const Text(
                'Arriesgar mi capital para tener posibiliades de altas ganancias',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15
                ),
              ),
            ),
               Container(
                      padding: EdgeInsets.only(top: 30),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _generarIngresos,
                        onChanged: updateGenrarIngresos,
                        items: <String>[
                          'Enumere la opcion',
                          '1',
                          '2',
                          '3',
                          '4'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),

              ],
            ),
                        Row(
              children: [
                   Container(
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: const Text(
                'Incrementar patrimonio',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15
                ),
              ),
            ),
               Container(
                      padding: EdgeInsets.only(top: 30),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _generarIngresos,
                        onChanged: updateGenrarIngresos,
                        items: <String>[
                          'Enumere la opcion',
                          '1',
                          '2',
                          '3',
                          '4'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),

              ],
            ),
                        Row(
              children: [
                   Container(
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: const Text(
                'Proteger mi patrimonio',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15
                ),
              ),
            ),
               Container(
                      padding: EdgeInsets.only(top: 30),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _generarIngresos,
                        onChanged: updateGenrarIngresos,
                        items: <String>[
                          'Enumere la opcion',
                          '1',
                          '2',
                          '3',
                          '4'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),

              ],
            ),
                    SizedBox(height: 20),
                                       Container(
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: const Text(
                'Pregunta 2. Seleccione cual perfil considera usted que describe si actitud como inversionista',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            ),
                Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _perfil,
                        onChanged: updatePerfil,
                        items: <String>[
                          'Seleccione perfil',
                          'Especulacion',
                          'Conservador',
                          'Moderado',
                          'Agresivo'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                                        SizedBox(height: 20),
                                       Container(
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: const Text(
                'Pregunta 3. Selecciones cuales son las prioridades financieras que desearia revisar con este analisis',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            ),
                Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _prioridades,
                        onChanged: updatePrioridades,
                        items: <String>[
                          'Seleccione prioridades',
                          'Como aumentar mi patrimonio',
                          'Como crear un Plan de ahorro para mi retiro',
                          'Como cubrir necesidades de familia',
                          'Como invertir en bienes raices en USD',
                          'Filantropia'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
            SizedBox(height: 20),
                                       Container(
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: const Text(
                'Pregunta 4. En aproximadamente cuantos años espera que iniciara retiros para sus principal necesidad financiera a cubrir',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            ),
                Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _anosRetiros,
                        onChanged: updateAnosRetiros,
                        items: <String>[
                          'Seleccione años retiros',
                          'Menos de 2 años',
                          '2–5 Años',
                          '6–10 Años',
                          '11–20 Años',
                          'Más de 20 años'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                                SizedBox(height: 20),
                                       Container(
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: const Text(
                'Preguntas 5. Una vez que comience a retirar fondos para su necesidad financiera principal, ¿durante cuánto tiempo planea que continuarán los retiros?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            ),
                Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _tiempoRetiros,
                        onChanged: updateTiempoRetiros,
                        items: <String>[
                          'Seleccione tiempo retiros',
                          'Menos de 2 años',
                          '2–5 Años',
                          '6–10 Años',
                          '11–20 Años',
                          'Más de 20 años'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),


                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PerfilRiesgo(token: widget.token,),
        ));
                      },
                      child: Text('Crear mi meta de ahorro', style: TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0XFFE8E112),
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                ),
              ),
            ),
          ],
        ),
        )
      ),
    );
  }
}
