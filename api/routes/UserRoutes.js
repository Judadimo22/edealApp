const router = require("express").Router();
const UserController = require('../controllers/UserController');
const {getUsers, register, login, getUserById, putCredit, putAhorro, reenviar, confirmarCuenta,putInfoPersonal,putIngresos,putAhorros,putGastosHogar,putGastosTransporte,putGastosEntretenimiento, putGastosFinancieros,putGastosVacaciones,putGastosImpuestos,putGastosCredito, putMetasFinancieras,putObjetivosSalud, putObjetivosEducacion, putObjetivosRetiro, putPerfilRiesgo, putFuentesAdicionales, putAhorro2, putAhorro3, putCredit2} = require('../controllers/UserController');
const { updateUserCredit } = require("../services/UserServices");

router.post("/register", (req,res,next) => {
    register(req,res,next)
});

router.post("/login", (req,res, next) => {
    login(req,res,next)
});


router.get("/users", (req, res) => {
    getUsers(req, res);
  });

router.get("/user/:id", (req, res) => {
    getUserById(req, res);
  });

router.put('/credit/:id', (req, res, next) => {
  putCredit(req,res, next)
})

router.put('/credit2/:id', (req, res, next) => {
  putCredit2(req,res, next)
})


router.put('/ahorro/:id', (req, res, next) => {
  putAhorro(req,res, next)
})

router.put('/ahorro2/:id', (req, res, next) => {
  putAhorro2(req,res, next)
})

router.put('/ahorro3/:id', (req, res, next) => {
  putAhorro3(req,res, next)
})

router.put('/confirmar/:id', (req, res, next) => {
  confirmarCuenta(req,res, next)
})

router.put('/reenviar/:id/:email', (req, res) => {
  reenviar(req,res)
})

router.put('/infoPersonal/:id', (req, res, next) => {
 putInfoPersonal(req,res,next)
})

router.put('/ingresos/:id', (req, res, next) => {
  putIngresos(req,res,next)
})

router.put('/ahorros/:id', (req, res, next) => {
  putAhorros(req,res,next)
})

router.put('/gastosHogar/:id', (req, res, next) => {
  putGastosHogar(req,res,next)
})

router.put('/gastosTransporte/:id', (req, res, next) => {
  putGastosTransporte(req,res,next)
})

router.put('/gastosEntretenimiento/:id', (req, res, next) => {
  putGastosEntretenimiento(req,res,next)
})

router.put('/gastosFinancieros/:id', (req, res, next) => {
  putGastosFinancieros(req,res,next)
})

router.put('/gastosVacaciones/:id', (req, res, next) => {
  putGastosVacaciones(req,res,next)
})

router.put('/gastosImpuestos/:id', (req, res, next) => {
  putGastosImpuestos(req,res,next)
})

router.put('/gastosCredito/:id', (req, res, next) => {
  putGastosCredito(req,res,next)
})

router.put('/metasFinancieras/:id', (req, res, next) => {
  putMetasFinancieras(req,res,next)
})

router.put('/objetivosSalud/:id', (req, res, next) => {
  putObjetivosSalud(req,res,next)
})

router.put('/objetivosEducacion/:id', (req, res, next) => {
  putObjetivosEducacion(req,res,next)
})

router.put('/objetivosRetiro/:id', (req, res, next) => {
  putObjetivosRetiro(req,res,next)
})

router.put('/perfilRiesgo/:id', (req, res, next) => {
  putPerfilRiesgo(req,res,next)
})

router.put('/fuentesAdicionales/:id', (req, res, next) => {
  putFuentesAdicionales(req,res,next)
})






module.exports = router;