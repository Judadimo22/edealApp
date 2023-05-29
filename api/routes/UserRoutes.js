const router = require("express").Router();
const UserController = require('../controllers/UserController');
const {getUsers, register, login, getUserById, putCredit, putAhorro, reenviar, confirmarCuenta,putInfoPersonal,putIngresos,putAhorros,putGastosHogar,putGastosTransporte,putGastosEntretenimiento, putGastosFinancieros,putGastosVacaciones,putGastosImpuestos} = require('../controllers/UserController');
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

router.put('/ahorro/:id', (req, res, next) => {
  putAhorro(req,res, next)
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





module.exports = router;