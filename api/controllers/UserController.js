const UserServices = require('../services/UserServices');
const userSchema = require("../models/User");
const { eMail } = require('../nodemailer/mailer');

const register = async (req, res, next) => {
    try {
        console.log("---req body---", req.body);
        const { email, password } = req.body;
        const code = Math.round(Math.random()*999999);
        const duplicate = await UserServices.getUserByEmail(email);
        if (duplicate) {
            throw new Error(`UserName ${email}, Already Registered`)
        }
        const response = await UserServices.registerUser(email, password, code);
        eMail(email,code);

        res.json({ status: true, success: 'User registered successfully' });


    } catch (err) {
        console.log("---> err -->", err);
        next(err);
    }
}

const login = async (req, res, next) => {
    try {

        const { email, password } = req.body;

        if (!email || !password) {
            throw new Error('Parameter are not correct');
        }
        let user = await UserServices.checkUser(email);
        if (!user) {
            throw new Error('User does not exist');
        }

        const isPasswordCorrect = await user.comparePassword(password);

        if (isPasswordCorrect === false) {
            throw new Error(`Username or Password does not match`);
        }

        // Creating Token

        let tokenData;
        tokenData = { _id: user._id, email: user.email };
    

        const token = await UserServices.generateAccessToken(tokenData,"secret","1h")

        res.status(200).json({ status: true, success: "sendData", token: token });
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}

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

module.exports ={
    getUsers,
    register,
    login,
    getUserById
}