const UserServices = require('../services/UserServices');
const userSchema = require("../models/User");
const { eMail } = require('../nodemailer/mailer');
const { reenviarCorreo } = require('../nodemailer/reenviarCorreo');

const register = async (req, res, next) => {
  try {
    console.log("---req body---", req.body);
    const { email, password, name, lastName, phone, tipoCedula, emisionCedula, cedula, fechaNacimiento } = req.body;
    const code = Math.round(Math.random() * 999999);
    const confirmarCuenta = 'No'
    const duplicate = await UserServices.getUserByEmail(email);
    if (duplicate) {
      throw new Error(`UserName ${email}, Already Registered`);
    }
    const user = await UserServices.registerUser(email, password, code, name, lastName, phone, tipoCedula, emisionCedula, cedula, fechaNacimiento,confirmarCuenta);
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
    next(error);
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
  
    const { credito, tarjetaDeCredito, bancoCredito } =
      req.body;
  
    userSchema
      .updateOne(
        { _id: id },
        {
          $set: {
            credito,
            tarjetaDeCredito,
            bancoCredito
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
  

module.exports ={
    getUsers,
    register,
    login,
    getUserById,
    putCredit,
    putAhorro,
    reenviar,
    confirmarCuenta
}