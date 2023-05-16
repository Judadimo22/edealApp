const router = require("express").Router();
const UserController = require('../controllers/UserController');
const {getUsers, register, login, getUserById, putCredit, putAhorro, reenviar, confirmarCuenta} = require('../controllers/UserController');
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



module.exports = router;