const router = require("express").Router();
const UserController = require('../controllers/UserController');
const {getUsers, register, login, getUserById} = require('../controllers/UserController')

router.post("/register", (req,res,next) => {
    register(req,res,next)
});

router.post("/login", (req,res) => {
    login(req,res)
});


router.get("/users", (req, res) => {
    getUsers(req, res);
  });

  router.get("/user/:id", (req, res) => {
    getUserById(req, res);
  });



module.exports = router;