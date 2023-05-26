import 'dart:async';
import 'dart:convert';
import 'package:edeal/views/homeScreen.dart';
import 'package:edeal/views/planeacionScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:velocity_x/velocity_x.dart';

class FuentesAdicionales extends StatefulWidget {
  final String token;

  FuentesAdicionales({required this.token, Key? key}) : super(key: key);

  @override
  State<FuentesAdicionales> createState() => _FuentesAdicionalesState();
}

class _FuentesAdicionalesState extends State<FuentesAdicionales> {
  late String userId;
  Map<String, dynamic> userData = {};

  final _formKey = GlobalKey<FormState>();

  String _habilidadEspecial = 'Habilidad para generar ingresos';
  String _desarrollarHabilidades = 'Desarrollar habilidades';
  String _generarIngresos = 'Enumere la opcion';
  String _viviendaPropia = 'Tiene vivienda propia';
  String _productosGustaria= 'Productos que me gustaria tener';
  String _analisisAsegurabilidad = 'Analisis de asegurabilidad';
  String _migracion = 'Migracion (estoy pensando migrar)';
  String _planHerencia = 'Plan de herencia';


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


  void updateHabilidadEspecial(String? newHabilidadEspecial) {
    setState(() {
      _habilidadEspecial = newHabilidadEspecial!;
    });
  }

  void updateDesarrollarHabilidades(String? newDesarrollarHabilidades) {
    setState(() {
      _desarrollarHabilidades = newDesarrollarHabilidades!;
    });
  }

  void updateGenrarIngresos(String? newGenerarIngresos) {
    setState(() {
      _generarIngresos = newGenerarIngresos!;
    });
  }

  void updateViviendaPropia(String? newViviendaPropia) {
    setState(() {
      _viviendaPropia = newViviendaPropia!;
    });
  }

  void updateProductosGustaria(String? newProductosGustaria) {
    setState(() {
      _productosGustaria = newProductosGustaria!;
    });
  }

  void updateAnalisisAsegurabilidad(String? newAnalisiAsegurabilidad) {
    setState(() {
      _analisisAsegurabilidad = newAnalisiAsegurabilidad!;
    });
  }

  void updateMigracion(String? newMigracion) {
    setState(() {
      _migracion = newMigracion!;
    });
  }

  void updatePlanHerencia(String? newPlanHerencia) {
    setState(() {
      _planHerencia = newPlanHerencia!;
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
                      margin: EdgeInsets.only(bottom: 50, left: 20, right: 20),
                      child: Text(
                        'Paso 5: Fuentes adicionales de ingresos',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white
                        ),
                      ),
                    ),
                     Container(
                      margin: EdgeInsets.only(bottom: 50, left: 10, right: 10),
                      child: Text(
                        'Si sus activos actuales y sus fuentes de ingresos no alcanzan sus objetivos, exploremos algunas formas en las que podría compensar la diferencia.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                   Container(
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: const Text(
                'Por favor enumere (1 al 3)  cual de las siguientes opciones  para aumentar ingresos.  1 la opcion mas viable al 3 la menos viable',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),
              ),
            ),
            Row(
              children: [
                   Container(
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: const Text(
                'Trabajar más',
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
                'Ahorrar más',
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
                'Gastar menos',
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
                    SizedBox(height: 150),
                Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _habilidadEspecial,
                        onChanged: updateHabilidadEspecial,
                        items: <String>[
                          'Habilidad para generar ingresos',
                          'Si',
                          'No',
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
                        value: _desarrollarHabilidades,
                        onChanged: updateDesarrollarHabilidades,
                        items: <String>[
                          'Desarrollar habilidades',
                          'Si',
                          'No'
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
                        value: _viviendaPropia,
                        onChanged: updateViviendaPropia,
                        items: <String>[
                          'Tiene vivienda propia',
                          'Si',
                          'No',
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
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: const Text(
                'Consideraciones especiales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),
              ),
            ),
                Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(top: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _productosGustaria,
                        onChanged: updateProductosGustaria,
                        items: <String>[
                          'Productos que me gustaria tener',
                          'Cuenta en USD',
                          'Plan de ahorros en USD',
                          'Tarjeta de credito en USD',
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
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(top: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _analisisAsegurabilidad,
                        onChanged: updateAnalisisAsegurabilidad,
                        items: <String>[
                          'Analisis de asegurabilidad',
                          'Seguro de vida',
                          'Seguro medico',
                          'Long Term Care Analysis',
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
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(top: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _migracion,
                        onChanged: updateMigracion,
                        items: <String>[
                          'Migracion (estoy pensando migrar)',
                          'Estados Unidos',
                          'Panama',
                          'Europa',
                          'Canada'
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
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(top: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _planHerencia,
                        onChanged: updatePlanHerencia,
                        items: <String>[
                          'Plan de herencia',
                          'Formas de heredar mi patrimonio',
                          'Estrategia para heredar mi patrimonio',
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
                    MaterialPageRoute(builder: (context) => Home(token: widget.token,),
        ));
                      },
                      child: Text('Finalizar', style: TextStyle(fontSize: 18)),
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