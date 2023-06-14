import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/controlFinanzas.dart';
import 'package:edeal/formularioPlanFinanciero/paso2/gastos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Creditos extends StatefulWidget {
  final String token;

  const Creditos({required this.token, Key? key}) : super(key: key);

  @override
  State<Creditos> createState() => _CreditosState();
}

class _CreditosState extends State<Creditos> {
  late String userId;
  Map<String, dynamic> userData = {};
  final TextEditingController _montoInicialController = TextEditingController();
  final TextEditingController _fechaAdquisicionController = TextEditingController();
  final TextEditingController _plazoCreditoController = TextEditingController();
  final TextEditingController _saldoActualController = TextEditingController();
  final TextEditingController _interesDeudaController = TextEditingController();
  final TextEditingController _pagoMensualController = TextEditingController();
  DateTime ? selectedDate;

  Future<void> _selectDateAdquisicion(BuildContext context) async {
    final DateTime? picked = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1900),
      maxTime: DateTime.now(),
      locale: LocaleType.es
    );

        if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _fechaAdquisicionController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }



  String _tipoDeuda= 'Tipo de deuda';

  void _updateTipoDeuda (String? newTipoDeuda){
    setState(() {
      _tipoDeuda= newTipoDeuda!;
    });
  }

  String _institucion= 'Institucion';

  void _updateInstitucion (String? newInstitucion){
    setState(() {
      _institucion = newInstitucion!;
    });
  }


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

  void saveGastoCredito() async {

    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/gastosCredito/$userId'),
      body: {
        'tipoDeudaGastosCredito': _tipoDeuda,
        'institucionGastosCredito': _institucion,
        'montoInicialGastosCredito': _montoInicialController.text,
        'fechaAdquisicionGastosCredito': _fechaAdquisicionController.text,
        'plazoCreditoGastosCredito': _plazoCreditoController.text,
        'saldoActualGastosCredito': _saldoActualController.text,
        'interesAnualGastosCredito': _interesDeudaController.text,
        'pagoMensualGastosCredito': _pagoMensualController.text,

      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['tipoDeudaGastosCredito'] = _tipoDeuda;
        userData['institucionGastosCredito'] = _institucion;
        userData['montoInicialGastosCredito'] = _montoInicialController.text;
        userData['fechaAdquisicionGastosCredito'] = _fechaAdquisicionController.text;
        userData['plazoCreditoGastosCredito'] = _plazoCreditoController.text;
        userData['saldoActualGastosCredito'] = _saldoActualController.text;
        userData['interesAnualGastosCredito'] = _interesDeudaController.text;
        userData['pagoMensualGastosCredito'] = _pagoMensualController.text;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Gastos en créditos actualizados'),
            content: Text('Tus gastos en creditos han sido actualizados'),
            actions: [
              TextButton(
                  onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Gastos(token: widget.token)));
                  },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );

}
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: const Color(0XFF524898),
      ),
      backgroundColor: const Color(0XFF524898),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: const Text(
                'Mis créditos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30
                ),
              )
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20 ),
              child: const Text(
                'Enumere los pasivos que tiene actualmente (por ejemplo, hipotecas de viviendas, deudas de tarjetas de crédito, préstamos para automóviles, préstamos para estudiantes, préstamos personales, etc.).',
                style: TextStyle(
                  color: Colors.white,
                ) ,
              ),
            ),
            Container(
              width: 374,
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: DropdownButton<String>(
                dropdownColor: const Color(0XFF524898),
                value: _tipoDeuda,
                onChanged: _updateTipoDeuda,
                 items:<String>[
                  'Tipo de deuda',
                  'Tarjeta de crédito',
                  'Libre inversión',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white
                      ),
                      ),
                  );
                }).toList(),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: 374,
              margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: DropdownButton<String>(
                dropdownColor: const Color(0XFF524898),
                value: _institucion,
                onChanged: _updateInstitucion,
                 items:<String>[
                        'Institucion',
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
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white
                      ),
                      ),
                  );
                }).toList(),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _montoInicialController,
                decoration: const InputDecoration(
                  hintText: 'Monto inicial del crédito',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _fechaAdquisicionController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Fecha de adquisicion',
                  hintStyle: const TextStyle(
                    color: Colors.white
                  ),
                  suffixIcon: IconButton(
                    onPressed: (){
                      _selectDateAdquisicion(context);
                    }, 
                    icon: const Icon(
                      color: Colors.white,
                      Icons.calendar_today
                    ))
                ),
                style: const TextStyle(
                  color: Colors.white
                )
              ) ,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _plazoCreditoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Plazo del crédito (meses)',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _saldoActualController,
                decoration: const InputDecoration(
                  hintText: 'Saldo actual',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _interesDeudaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Interés de la deuda (anual)',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _pagoMensualController,
                 keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Pago mensual (opcional)',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
              child: ElevatedButton(
                onPressed: () =>{
              if (_tipoDeuda == 'Tipo de deuda' ||
              _institucion == 'Institucion' ||
                _montoInicialController.text.isEmpty ||
        _fechaAdquisicionController.text.isEmpty ||
        _plazoCreditoController.text.isEmpty ||
        _saldoActualController.text.isEmpty ||
        _interesDeudaController.text.isEmpty
        ) {
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
        },
      )
    } else {
      saveGastoCredito()
    }
                  
                },
                child: const Text('Continuar')),
            )
          ],
        ),
        )
      ),

    );
  }

  }