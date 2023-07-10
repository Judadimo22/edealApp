import 'dart:async';
import 'dart:convert';
import 'package:edeal/views/creditoScreen2.dart';
import 'package:edeal/views/creditoScreen3.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:math';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:edeal/widgets/barraSeleccion.dart';
import 'package:edeal/widgets/sliderPalabras.dart';
import 'package:edeal/widgets/subtitulo.dart';
import 'package:edeal/widgets/seleccion.dart';
import 'package:edeal/widgets/sliderMeses.dart';
import 'package:edeal/widgets/input.dart';


class CreditoScreen extends StatefulWidget {
  final String token;

  CreditoScreen({required this.token, Key? key}) : super(key: key);

  @override
  State<CreditoScreen> createState() => _CreditoScreenState();
}

class _CreditoScreenState extends State<CreditoScreen> {
  late String userId;
  Map<String, dynamic> userData = {};

  final _formKey = GlobalKey<FormState>();
  TextEditingController _newDataController = TextEditingController();
  TextEditingController _montoCreditoController = TextEditingController();
  TextEditingController _otroTipoSeguroController = TextEditingController();
  TextEditingController _otraCompraController = TextEditingController();

  String _creditoPara = 'Me gustaría un crédito para:';
  String _tarjetaCredito = 'Tengo tarjeta de crédito:';
  String _banco = 'Con cual banco:';
  String _plazoCredito = 'Plazo del crédito en meses';
  String _tipoSeguro = 'Tipo de seguro';
  String _tipoCompra = 'Que tipo de compra';
  String _dondeViajar = 'A donde quisiera viajar';
  String _cuandoViajar = 'Cuando quisiera viajar';

  bool _mostrarCampoBanco = false;
  bool _mostrarTarjetaCredito = false;
  bool _mostrarSeguro = false;
  bool _mostrarRealizarCompra = false;
  bool _mostrarViajar = false;
  bool _mostrarComprarUsd = false;
  bool _mostrarOtroTipoSeguro = false;
  bool _mostrarOtraCompra = false;

  double _montoTarjetaCredito = 0;
  double _tasaAnualTarjetaCredito = 0;



  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    fetchUserData();
  }

  void fetchUserData() async {
    var response = await http.get(Uri.parse('https://edeal-app.onrender.com/user/$userId'));

    if (response.statusCode == 200) {
      setState(() {
        userData = jsonDecode(response.body);
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

void saveUserData() async {
  if (_formKey.currentState!.validate()) {
    if (_montoCreditoController.text.isEmpty ||
        _plazoCredito == 'Plazo del crédito en meses' ||
        _tarjetaCredito == 'Tengo tarjeta de crédito:' ||
        _creditoPara == 'Me gustaría un crédito para:'
    ) {
      String errorMessage = '';

      if (_creditoPara == 'Me gustaría un crédito para:') {
        errorMessage = 'Por favor, selecciona una opción en Me gustaría un crédito para';
      } else if (_tarjetaCredito == 'Tengo tarjeta de crédito:') {
        errorMessage = 'Por favor, selecciona una opción en Tengo tarjeta de crédito';
      } else if (_montoCreditoController.text.isEmpty) {
        errorMessage = 'Por favor, ingresa el monto del crédito';
      } else if (_plazoCredito == 'Plazo del crédito en meses') {
        errorMessage = 'Por favor, selecciona una opción en Plazo del crédito';
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Campos incompletos'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
    } else {
      var newData = _newDataController.text;

      var response = await http.put(
        Uri.parse('https://edeal-app.onrender.com/credit/$userId'),
        body: {
          'credito': _creditoPara,
          'tarjetaDeCredito': _tarjetaCredito,
          'bancoCredito': _banco,
          'montoCredito': _montoCreditoController.text,
          'plazoCredito': _plazoCredito
          },
      );

      if (response.statusCode == 200) {
        setState(() {
          userData['credit'] = _creditoPara;
          userData['tarjetaDeCredito'] = _tarjetaCredito;
          userData['bancoCredito'] = _banco;
          userData['montoCredito'] = _montoCreditoController.text;
          userData['plazoCredito'] = _plazoCredito;
        });
          showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Información actualizada'),
              content: Text('Tu información se almacenó correctamente.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Aceptar'),
                ),
              ],
            ) ;
          },
        )
      ;
        setState(() {
         _creditoPara = 'Me gustaría un crédito para:';
         _tarjetaCredito = 'Tengo tarjeta de crédito:';
         _banco = 'Con cual banco:';
         _plazoCredito = 'Plazo del crédito en meses';
         _montoCreditoController.text = '';
      });
      } else {
        print('Error al actualizar la información: ${response.statusCode}');
      }
    }
  }
  }
  void updateSelectedOption(String? newValue) {
    setState(() {
      _creditoPara = newValue!;
    });
    if(newValue == 'Pagar mi tarjeta de credito'){
      _mostrarTarjetaCredito = true;
      _mostrarSeguro = false;
      _mostrarRealizarCompra = false;
      _mostrarViajar = false;
      _mostrarComprarUsd = false;
    }
    else if(newValue == 'Comprar un seguro'){
      _mostrarSeguro = true;
      _mostrarTarjetaCredito = false;
      _mostrarRealizarCompra = false;
      _mostrarViajar = false;
      _mostrarComprarUsd = false;

    }
    else if(newValue == 'Realizar una compra'){
      _mostrarRealizarCompra = true;
      _mostrarSeguro = false;
      _mostrarTarjetaCredito = false;
      _mostrarViajar = false;
      _mostrarComprarUsd = false;
    }
    else if(newValue == 'Viajar'){
      _mostrarViajar = true;
      _mostrarRealizarCompra = false;
      _mostrarSeguro = false;
      _mostrarTarjetaCredito = false;
      _mostrarComprarUsd = false;
    }
    else if(newValue == 'Comprar USD'){
      _mostrarComprarUsd = true;
      _mostrarRealizarCompra = false;
      _mostrarSeguro = false;
      _mostrarTarjetaCredito = false;
      _mostrarViajar = false;
    }
    else {
      _mostrarTarjetaCredito = false;
      _mostrarComprarUsd = false;
      _mostrarRealizarCompra = false;
      _mostrarSeguro = false;
      _mostrarTarjetaCredito = false;
      _mostrarViajar = false;
    }
  }

  void updateTarjetaOption(String? newTarjeta){
    setState(() {
    _tarjetaCredito = newTarjeta!;
      if (newTarjeta == 'Si') {
        _mostrarCampoBanco = true;
      } else {
        _mostrarCampoBanco = false;
      }
    });
  }

  void updateTipoSeguro(String? newTipoSeguro){
    setState(() {
    _tipoSeguro = newTipoSeguro!;
      if (newTipoSeguro == 'Otro') {
        _mostrarOtroTipoSeguro = true;
      } else {
        _mostrarOtroTipoSeguro = false;
      }
    });
  }

  void updateTipoCompra(String? newTipoCompra){
    setState(() {
    _tipoCompra = newTipoCompra!;
      if (newTipoCompra == 'Otro') {
        _mostrarOtraCompra = true;
      } else {
        _mostrarOtraCompra = false;
      }
    });
  }

  void updateBancoOption(String? newBanco){
    setState(() {
    _banco = newBanco!;
    });
  }

    void updateplazoCreditoOption(String? newPlazoCredito){
    setState(() {
    _plazoCredito = newPlazoCredito!;
    });
  }

  void updateDondeViajar(String? newDondeViajar){
    setState(() {
    _dondeViajar = newDondeViajar!;
    });
  }

  void updateCuandoViajar(String? newCuandoViajar){
    setState(() {
    _cuandoViajar = newCuandoViajar!;
    });
  }



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.075),
          child: Column(
            children: [
              Text(
                'Quiero un                       ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              Text(
                'crédito                            ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
            CustomTextWidget(
              text: 'Quiero un crédito para: ', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomDropdownWidget(
              value: _creditoPara, 
              onChanged: updateSelectedOption, 
              items: const [
                'Me gustaría un crédito para:',
                'Pagar mi tarjeta de credito',
                'Comprar un seguro',
                'Realizar una compra',
                'Viajar',
                'Comprar USD'

              ]
              ),
            if(_mostrarTarjetaCredito)
            Column(
              children: [
                CustomTextWidget(
              text: 'Con cual banco', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
              CustomDropdownWidget(
                value: _banco, 
                onChanged: updateBancoOption, 
                items: const[
                  'Con cual banco:',
                        'Banco de Bogotá',
                        'Banco Popular',
                        'Coorbanca',
                        'Bancolombia',
                        'Banco CITIBANK',
                        'HSBC Colombia',
                        'Banco GNB Sudameris',
                        'BBVA Colombia ',
                        'Helm Bank',
                        'MULTIBANCA COLPATRIA',
                        'Banco de Occidente',
                        'Banco Caja Social ',
                        'Banco Davivienda',
                        'Banco AV Villas',
                        'Fiduciaria Skandia',
                        'Banco Pichincha S.A',
                        'Banco Coomeva S.A.',
                        'Banco Procredit',
                        'Banco Falabella',
                        'Coltefinanciera',
                        'Coopcentral'
                ]
                ),
              CustomTextWidget(
              text: 'Monto', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
              CustomSliderWidget(
                value: _montoTarjetaCredito, 
                min: 0, 
                max: 20000000, 
                divisions: 20, 
                onChanged: (value) {
                    setState(() {
                      _montoTarjetaCredito = value;
                    });
                } 
                ),
              CustomTextWidget(
              text: 'Tasa anual (si la sabe)', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
              CustomSliderWidget(
                value: _tasaAnualTarjetaCredito, 
                min: 0, 
                max: 20000000, 
                divisions: 20, 
                onChanged: (value) {
                    setState(() {
                      _tasaAnualTarjetaCredito = value;
                    });
                } 
                ),
              ],
            ),
           if(_mostrarSeguro)
           Column(
            children: [
              CustomTextWidget(
              text: 'Tipo de seguro', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
              CustomDropdownWidget(
                value: _tipoSeguro, 
                onChanged: updateTipoSeguro, 
                items: const[
                  'Tipo de seguro',
                  'Seguro de vehículo',
                  'Seguro de vida',
                  'Seguro de salud',
                  'Otro'
                ]
                ),
              if(_mostrarOtroTipoSeguro)
              Column(
                children: [
                  CustomTextWidget(
                    text: 'Ingresa otro tipo de seguro', 
                    fontSize: MediaQuery.of(context).size.height * 0.016, 
                    fontWeight: FontWeight.w500
                    ),
                  CustomTextField(
                controller: _otroTipoSeguroController, 
                keyboardType: TextInputType.text,
                hintText: 'Ingresa el tipo de seguro '
                )
                ],
              )
            
            ],
           ),
           if(_mostrarRealizarCompra)
           Column(
            children: [
              CustomTextWidget(
              text: 'Que tipo de compra', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
              CustomDropdownWidget(
                value: _tipoCompra, 
                onChanged: updateTipoCompra, 
                items: const[
                  'Que tipo de compra',
                  'Un celular',
                  'Una computadora',
                  'Seguro de salud',
                  'Otro'
                ]
                ),
              if(_mostrarOtraCompra)
              Column(
                children: [
                  CustomTextWidget(
                    text: 'Ingresa otro tipo de compra', 
                    fontSize: MediaQuery.of(context).size.height * 0.016, 
                    fontWeight: FontWeight.w500
                    ),
                  CustomTextField(
                controller: _otraCompraController, 
                keyboardType: TextInputType.text,
                hintText: 'Ingresa el tipo de compra '
                )
                ],
              )
            
            ],
           ),
           if(_mostrarViajar)
           Column(
            children: [
              CustomTextWidget(
                    text: 'A donde quisiera viajar', 
                    fontSize: MediaQuery.of(context).size.height * 0.016, 
                    fontWeight: FontWeight.w500
              ),
              CustomDropdownWidget(
                value: _dondeViajar, 
                onChanged: updateDondeViajar, 
                items: const[
                  'A donde quisiera viajar',
                  'Francia',
                  'España',
                  'Suecia',
                  'Marruecos',
                  'Islandia',
                  'Mexico'
                ]
                ),
              CustomTextWidget(
                    text: 'Cuando quisiera viajar', 
                    fontSize: MediaQuery.of(context).size.height * 0.016, 
                    fontWeight: FontWeight.w500
              ),
              CustomDropdownWidget(
                value: _cuandoViajar, 
                onChanged: updateCuandoViajar, 
                items: const[
                  'Cuando quisiera viajar',
                  'Este año',
                  'El próximo año',
                  'En los 2 próximos años',
                  'Aún no lo sé'
                ]
                ),
              
            ],
           ),
           if(_mostrarComprarUsd)
           Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.035) ,
                child: Text(
                'Proximamente',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              ),
              CustomTextWidget(
                    text: 'Hacer un pre registro para recibir información del lanzamiento de este producto', 
                    fontSize: MediaQuery.of(context).size.height * 0.016, 
                    fontWeight: FontWeight.w500
              ),
              
            ],
           ),
           Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030, bottom:MediaQuery.of(context).size.height * 0.020,),
                      child: ElevatedButton(
                        onPressed: (){
                          if (_creditoPara == 'Me gustaría un crédito para:') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Completa todos los campos antes de continuar'),
            content: Text('Por favor completa todos los campos antes de continuar'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        } ,
      );
    } else {
      saveUserData();
    }
                        } ,
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            )
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF0C67B0)
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.20, vertical: MediaQuery.of(context).size.height * 0.005),
                          ),
                        ),
                         child: Text(
                              'Solicitar crédito', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                      )
                    ),
                  ),
           
            ],
          ),
        ),
      )
    );
    }
}


