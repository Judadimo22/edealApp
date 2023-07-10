const UserServices = require('../services/UserServices');
const userSchema = require("../models/User");
const { eMail } = require('../nodemailer/mailer');
const { reenviarCorreo } = require('../nodemailer/reenviarCorreo');

const register = async (req, res, next) => {
  try {
    console.log("---req body---", req.body);
    const { email, password, name, lastName} = req.body;
    const code = Math.round(Math.random() * 999999);
    const confirmarCuenta = 'No'
    const duplicate = await UserServices.getUserByEmail(email);
    if (duplicate) {
      throw new Error(`UserName ${email}, Already Registered`);
    }
    const user = await UserServices.registerUser(email, password, code, confirmarCuenta, name, lastName);
    eMail(email, code);

    const tokenData = { _id: user._id, email: user.email };
    const token = await UserServices.generateAccessToken(
      tokenData,
      "secret",
      "1h"
    );

    setTimeout(() => {
      UserServices.removeCodeField(user._id);
    },  60 * 1000);

    res.status(200).json({ status: true, success: "sendData", token: token });
  } catch (err) {
    console.log("---> err -->", err);
    next(err);
  }
};

const reenviar = async (req, res) => {
  try {
    const { email, id } = req.params;
    const newCode = Math.round(Math.random() * 999999);
    
    await userSchema.updateOne(
      { _id: id },
      {
        $set: {
          code: newCode
        }
      }
    );

    reenviarCorreo(email, newCode);
    let user = await UserServices.checkUser(email);
    setTimeout(() => {
      UserServices.removeCodeField(user._id);
    },  60 * 1000);

    
    res.json({ message: 'Correo reenviado y código actualizado en la base de datos' });
  } catch (error) {
    res.status(500).json({ message: 'Error al reenviar el correo y actualizar el código en la base de datos' });
  }
};



const login = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      throw new Error('Parameters are not correct');
    }

    let user = await UserServices.checkUser(email);
    if (!user) {
      throw new Error('User does not exist');
    }

    const isPasswordCorrect = await UserServices.comparePassword(password, user.password);
    if (!isPasswordCorrect) {
      throw new Error('Username or Password does not match');
    }

    let tokenData;
    tokenData = { _id: user._id, email: user.email };

    const token = await UserServices.generateAccessToken(tokenData, "secret", "1h");

    res.status(200).json({ status: true, success: "sendData", token: token });
  } catch (error) {
    console.log(error, 'err---->');
    res.status(500).json({ status: false, message: error.message });
  }
};



const getUsers = async (req, res) => {
    try {
      const { email } = req.query;
      const users = await userSchema.find();
  
      if (email) {
        let userEmail = users.filter((user) => user.email === email);
        userEmail.length
          ? res.status(200).json(userEmail)
          : res.status(201).json("Not found");
      } else {
        res.status(200).json(users);
      }
    } catch (error) {
      res.status(500).json(`Error ${error}`);
    }
  };

  const getUserById = async (req, res) => {
    try {
      const { id } = req.params;
      let user = await userSchema.findById(id);
  
      return res.status(200).json(user);
    } catch (error) {
      res.status(500).json(`Error ${error}`);
    }
  };

  const putCredit = async (req, res) => {
    const { id } = req.params;
  
    const { credito, tarjetaDeCredito, bancoCredito, montoCredito, plazoCredito } =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            credito,
            tarjetaDeCredito,
            bancoCredito,
            montoCredito,
            plazoCredito
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putCredit2 = async (req, res) => {
    const { id } = req.params;
  
    const { credito2, tarjetaDeCredito2, bancoCredito2, montoCredito2, plazoCredito2 } =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            credito2,
            tarjetaDeCredito2,
            bancoCredito2,
            montoCredito2,
            plazoCredito2
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putAhorro2 = async (req, res) => {
    const { id } = req.params;
  
    const { ahorro2Para, valorAhorro2, plazoAhorro2} =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            ahorro2Para,
            valorAhorro2,
            plazoAhorro2,
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putAhorro = async (req, res) => {
    const { id } = req.params;
  
    const { ahorroPara, valorAhorro, plazoAhorro} =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            ahorroPara,
            valorAhorro,
            plazoAhorro,
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putAhorro3 = async (req, res) => {
    const { id } = req.params;
  
    const { ahorro3Para, valorAhorro3, plazoAhorro3} =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            ahorro3Para,
            valorAhorro3,
            plazoAhorro3,
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };



  const putInfoPersonal= async (req, res) => {
    const { id } = req.params;
  
    const { estadoCivilCliente1, situacionLaboralCliente1, lugarResidenciaCLiente1,fechaNacimiento, phone, cuentaConPlanSalud, tipoPlanSalud, porcentajeCoberturaPlan} =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            estadoCivilCliente1,
            situacionLaboralCliente1,
            lugarResidenciaCLiente1,
            fechaNacimiento,
            phone,
            cuentaConPlanSalud,
            tipoPlanSalud,
            porcentajeCoberturaPlan
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putDependiente1= async (req, res) => {
    const { id } = req.params;
  
    const { nombreDependiente, relacionDependiente, fechaNacimientoDependiente} =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            nombreDependiente,
            relacionDependiente,
            fechaNacimientoDependiente,
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putDependiente2= async (req, res) => {
    const { id } = req.params;
  
    const { nombreDependiente2, relacionDependiente2, fechaNacimientoDependiente2} =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            nombreDependiente2,
            relacionDependiente2,
            fechaNacimientoDependiente2,
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putDependiente3= async (req, res) => {
    const { id } = req.params;
  
    const { nombreDependiente3, relacionDependiente3, fechaNacimientoDependiente3} =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            nombreDependiente3,
            relacionDependiente3,
            fechaNacimientoDependiente3,
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putIngresos = async (req, res) => {
    const { id } = req.params;
  
    const { salario, inversionesPesos, inversionesUsd,alquileresInmobiliarios,dividendos,pensiones,otrosIngresos,fondoEmergencia, fondoAhorro, fondoRetiro, inversiones, otrosAhorros} =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            salario,
            inversionesPesos,
            inversionesUsd,
            alquileresInmobiliarios,
            dividendos,
            pensiones,
            otrosIngresos,
            fondoEmergencia,
            fondoAhorro,
            fondoRetiro,
            inversiones,
            otrosAhorros
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putAhorros= async (req, res) => {
    const { id } = req.params;
  
    const { aportesEmergencia, aportesAhorro, aportesRetiro,inversiones,otrosAhorros} =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            aportesEmergencia,
            aportesAhorro,
            aportesRetiro,
            inversiones,
            otrosAhorros,
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putGastos= async (req, res) => {
    const { id } = req.params;
  
    const { alquiler, serviciosPublicos, mercado, otrosGastosHogar, gasolina, mantenimientoVehiculo, transportePublico,viajes, restaurantes, conciertos, cuotaCreditoVivienda, cuotaCreditoVehiculo, cuotaTarjetaCredito, cuotaOtrosCreditos, seguroVehiculo, seguroSalud, seguroVida, creditoUsd, otrosGastosFinancieros, renta, predial, impuestoVehiculos} =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            alquiler,
            serviciosPublicos,
            mercado,
            otrosGastosHogar,
            gasolina,
            mantenimientoVehiculo,
            transportePublico,
            viajes,
            restaurantes,
            conciertos,
            cuotaCreditoVivienda,
            cuotaCreditoVehiculo,
            cuotaTarjetaCredito,
            cuotaOtrosCreditos,
            seguroVehiculo,
            seguroSalud,
            seguroVida,
            creditoUsd,
            otrosGastosFinancieros,
            renta,
            predial,
            impuestoVehiculos
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putGastosHogar= async (req, res) => {
    const { id } = req.params;
  
    const { creditoHipotecario, arriendo, serviciosPublicos,internet,planCelular,mantenimientoHogar,segurosHogar,mercado,otrosGastosHogar} =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            creditoHipotecario,
            arriendo,
            serviciosPublicos,
            internet,
            planCelular,
            mantenimientoHogar,
            segurosHogar,
            mercado,
            otrosGastosHogar
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putGastosTransporte= async (req, res) => {
    const { id } = req.params;
  
    const { cuotaCarro, seguroCarro, gasolina,transportePublico,mantenimientoCarro} =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            cuotaCarro,
            seguroCarro,
            gasolina,
            transportePublico,
            mantenimientoCarro,
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putGastosEntretenimiento= async (req, res) => {
    const { id } = req.params;
  
    const { restaurantes, cine, conciertos,eventosDeportivos,salidasFiestas} =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            restaurantes,
            cine,
            conciertos,
            eventosDeportivos,
            salidasFiestas,
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putGastosFinancieros= async (req, res) => {
    const { id } = req.params;
  
    const { seguroSalud, seguroVida, gastoTarjetaCredito,creditoLibreInversion,creditoUsd} =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            seguroSalud,
            seguroVida,
            gastoTarjetaCredito,
            creditoLibreInversion,
            creditoUsd,
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putGastosVacaciones= async (req, res) => {
    const { id } = req.params;
  
    const { tiquetesAereos, hoteles, gastosViaje} =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            tiquetesAereos,
            hoteles,
            gastosViaje,
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putGastosImpuestos= async (req, res) => {
    const { id } = req.params;
  
    const { renta, predial, impuestoVehiculos} =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            renta,
            predial,
            impuestoVehiculos,
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putGastosCredito= async (req, res) => {
    const { id } = req.params;
  
    const { tipoDeudaGastosCredito, institucionGastosCredito, montoInicialGastosCredito,fechaAdquisicionGastosCredito,plazoCreditoGastosCredito, saldoActualGastosCredito, interesAnualGastosCredito, pagoMensualGastosCredito} =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            tipoDeudaGastosCredito,
            institucionGastosCredito,
            montoInicialGastosCredito,
            fechaAdquisicionGastosCredito,
            plazoCreditoGastosCredito,
            saldoActualGastosCredito,
            interesAnualGastosCredito,
            pagoMensualGastosCredito,
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };






  const confirmarCuenta = async (req, res) => {
    const { id } = req.params;
  

  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            cuentaConfirmada: 'Si'
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putMetasFinancieras= async (req, res) => {
    const { id } = req.params;
  
    const { plazoVacaciones, valorVacaciones, importanciaVacaciones, plazoAutomovil, valorAutomovil, importanciaAutomovil, plazoEducacion, valorEducacion, importanciaEducacion, plazoInmuebleColombia, valorInmuebleColombia, importanciaInmuebleColombia, plazoInmuebleUsa, valorInmuebleUsa, importanciaInmuebleUsa, plazoTratamientosMedicos, valorTratamientosMedicos, importanciaTratamientosMedicos, plazoTecnologia, valorTecnologia, importanciaTecnologia, plazoEntretenimiento, valorEntretenimiento, importanciaEntretenimiento, plazoEventosDeportivos, valorEventosDeportivos, importanciaEventosDeportivos, plazoOtros, valorOtros, importanciaOtros, numeroHijos, nombreEstudiante1, añoIniciara, añosEstudiaria, importanciaEducacionEstudiante1, montoEstimadoEducacion, tipoInstitucionEducativa, ubicacionEstudiante1, nombreInstitucionEducativa } =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            plazoVacaciones,
            valorVacaciones,
            importanciaVacaciones,
            plazoAutomovil,
            valorAutomovil,
            importanciaAutomovil,
            plazoEducacion,
            valorEducacion,
            importanciaEducacion,
            plazoInmuebleColombia,
            valorInmuebleColombia,
            importanciaInmuebleColombia,
            plazoInmuebleUsa,
            valorInmuebleUsa,
            importanciaInmuebleUsa,
            plazoTratamientosMedicos,
            valorTratamientosMedicos,
            importanciaTratamientosMedicos,
            plazoTecnologia,
            valorTecnologia,
            importanciaTecnologia,
            plazoEntretenimiento,
            valorEntretenimiento,
            importanciaEntretenimiento,
            plazoEventosDeportivos,
            valorEventosDeportivos,
            importanciaEventosDeportivos,
            plazoOtros,
            valorOtros,
            importanciaOtros,
            numeroHijos,
            añoIniciara,
            nombreEstudiante1,
            añosEstudiaria,
            importanciaEducacionEstudiante1,
            montoEstimadoEducacion,
            tipoInstitucionEducativa,
            ubicacionEstudiante1,
            nombreInstitucionEducativa

          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putObjetivosSalud= async (req, res) => {
    const { id } = req.params;
  
    const { cuentaConPlanSalud, tipoPlanSalud, porcentajeCoberturaPlan} =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            cuentaConPlanSalud,
            tipoPlanSalud,
            porcentajeCoberturaPlan,
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putObjetivosRetiro= async (req, res) => {
    const { id } = req.params;
  
    const { valorViviendaRetiro, importanciaViviendaRetiro, valorViajesRetiro, importanciaViajesRetiro, valorSaludRetiro, importanciaSaludRetiro, valorDependientesRetiro, importanciaDependientesRetiro, valorOtrosRetiro, importanciaOtrosRetiro } =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            valorViviendaRetiro,
            importanciaViviendaRetiro,
            valorViajesRetiro,
            importanciaViajesRetiro,
            valorSaludRetiro,
            importanciaSaludRetiro,
            valorDependientesRetiro,
            importanciaDependientesRetiro,
            valorOtrosRetiro,
            importanciaOtrosRetiro
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putObjetivosEducacion= async (req, res) => {
    const { id } = req.params;
  
    const { numeroHijos, nombreEstudiante1, añoIniciara, añosEstudiaria, importanciaEducacionEstudiante1, montoEstimadoEducacion, tipoInstitucionEducativa, ubicacionEstudiante1, nombreInstitucionEducativa } =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            numeroHijos,
            nombreEstudiante1,
            añoIniciara,
            añosEstudiaria,
            importanciaEducacionEstudiante1,
            montoEstimadoEducacion,
            tipoInstitucionEducativa,
            ubicacionEstudiante1,
            nombreInstitucionEducativa
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putPerfilRiesgo= async (req, res) => {
    const { id } = req.params;
  
    const {experienciaInversiones, poseoAlgunActivo, generarIngresos, arriesgarMiCapital, incrementarPatrimonio, protegerPatrimonio, perfilActitudInversionista, prioridadesFinancieras, iniciarRetiros, continuarRetiros } =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            experienciaInversiones,
            poseoAlgunActivo,
            generarIngresos,
            arriesgarMiCapital,
            incrementarPatrimonio,
            protegerPatrimonio,
            perfilActitudInversionista,
            prioridadesFinancieras,
            iniciarRetiros,
            continuarRetiros
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };

  const putFuentesAdicionales= async (req, res) => {
    const { id } = req.params;
  
    const {trabajarMas, ahorrarMas, gastarMenos, habilidadGenerarIngresos, desarrollarHabilidades, viviendaPropia, productosGustariaTener, analisisAsegurabilidad, migracion, planHerencia } =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            trabajarMas,
            ahorrarMas,
            gastarMenos,
            habilidadGenerarIngresos,
            desarrollarHabilidades,
            viviendaPropia,
            productosGustariaTener,
            analisisAsegurabilidad,
            migracion,
            planHerencia
          },
        }
      )
      .then((data) => res.json(data))
      .catch((error) => res.status(500).json({ message: `${error} ` }));
  };



  

module.exports ={
    getUsers,
    register,
    login,
    getUserById,
    putCredit,
    putCredit2,
    putAhorro,
    putAhorro2,
    putAhorro3,
    reenviar,
    confirmarCuenta,
    putInfoPersonal,
    putIngresos,
    putAhorros,
    putGastosHogar,
    putGastosTransporte,
    putGastosEntretenimiento,
    putGastosFinancieros,
    putGastosVacaciones,
    putGastosImpuestos,
    putGastosCredito,
    putMetasFinancieras,
    putObjetivosSalud,
    putObjetivosEducacion,
    putObjetivosRetiro,
    putPerfilRiesgo,
    putFuentesAdicionales,
    putDependiente1,
    putDependiente2,
    putDependiente3,
    putGastos
}