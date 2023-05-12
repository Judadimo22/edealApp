const UserModel = require("../models/User");
const jwt = require("jsonwebtoken");

class UserServices{
 
    static async registerUser(email,password,code,name, lastName, phone, tipoCedula, emisionCedula, cedula, fechaNacimiento){
        try{
                console.log("-----Email --- Password-----",email,password);
                
                const createUser = new UserModel({email,password,code,name, lastName, phone, tipoCedula, emisionCedula, cedula, fechaNacimiento});
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

    static async checkUser(email){
        try {
            return await UserModel.findOne({email});
        } catch (error) {
            throw error;
        }
    }

    static async generateAccessToken(tokenData,JWTSecret_Key,JWT_EXPIRE){
        return jwt.sign(tokenData, JWTSecret_Key, { expiresIn: JWT_EXPIRE });
    }

    // static async updateUserCredit(userId, credit) {
    //     try {
    //       const user = await UserModel.findById(userId);
      
    //       if (!user) {
    //         throw new Error("Usuario no encontrado");
    //       }
    //       user.credit = credit;
    
    //       await user.save();
    //     } catch (err) {
    //       throw err;
    //     }
    //   }
}

module.exports = UserServices;