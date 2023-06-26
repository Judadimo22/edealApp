const UserModel = require("../models/User");
const jwt = require("jsonwebtoken");
const bcrypt = require('bcrypt');


class UserServices{
 
    static async registerUser(email,password,code,name, lastName, phone, tipoCedula, cedula, fechaNacimiento, confirmarCuenta){
        try{
                console.log("-----Email --- Password-----",email,password);
                
                const createUser = new UserModel({email,password,code,name, lastName, phone, tipoCedula,cedula, fechaNacimiento, confirmarCuenta});
                return await createUser.save();
        }catch(err){
            throw err;
        }
    }

    static async getUserByEmail(email){
        try{
            return await UserModel.findOne({email});
        }catch(err){
            console.log(err);
        }
    }

    static async checkUser(email) {
      try {
        const user = await UserModel.findOne({ email });
        return user;
      } catch (error) {
        throw new Error('Error retrieving user');
      }
    }

    static async generateAccessToken(tokenData,JWTSecret_Key,JWT_EXPIRE){
        return jwt.sign(tokenData, JWTSecret_Key, { expiresIn: JWT_EXPIRE });
    }

    static async removeCodeField (userId) {
        try {
          await UserServices.updateUser(userId, { $unset: { code: "" } });
          console.log("Campo 'code' eliminado");
        } catch (err) {
          console.log("Error al eliminar el campo 'code':", err);
        }
      };

      static async comparePassword(password, hashedPassword) {
        try {
          const isMatch = await bcrypt.compare(password, hashedPassword);
          return isMatch;
        } catch (error) {
          throw new Error('Error comparing passwords');
        }
      }
  

      static async updateUser (userId, updateData) {
        try {
            const updateData = {
              $unset: { code: 1 }, 
            };
        
            await UserModel.updateOne({ _id: userId }, updateData);
            console.log("Campo 'code' eliminado");
        
            const user = await UserModel.findById(userId);
            return user;
          } catch (err) {
            console.log("Error al eliminar el campo 'code':", err);
            throw err;
          }
        };

}

module.exports = UserServices;