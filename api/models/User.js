
const bcrypt = require("bcrypt");
const mongoose = require('mongoose');
const userSchema = mongoose.Schema({
    email: {
        type: String,
        lowercase: true,
        required: [true, "Email can't be empty"],
        // @ts-ignore
        match: [
            /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/,
            "userName format is not correct",
        ],
        unique: true,
    },
    password: {
        type: String,
        required: [true, "password is required"],
    },
    code: {
        type: String
    },
    name: {
        type: String,
        required: [true, "Name is required"],
    },
    lastName: {
        type: String,
        required: [true, "Last name is required"],
    },
    phone: {
        type: String,
        required: [true, "Phone is required"],
    },
    tipoCedula: {
        type: String,
        required: [true, "Tipo de cedula is required"],
    },
    cedula: {
        type: String,
        required: [true, "cedula is required"],
    },
    emisionCedula: {
        type: String,
        required: [true, "Emisión cedula is required"],
    },
    fechaNacimiento: {
        type: String,
        required: [true, "Fecha nacimiento is required"],
    },
    credito: {
        type: String,
    },
    tarjetaDeCredito:{
        type: String
    },
    bancoCredito: {
        type: String
    },
    ahorroPara: {
        type: String
    },
    valorAhorro: {
        type: String
    },
    plazoAhorro: {
        type: String
    },
    metaAhorro: {
        type: String
    },
    cuentaConfirmada: {
        type: String,
        default: 'No'
    },
    montoCredito: {
        type: String
    },
    plazoCredito: {
        type: String
    }
},{timestamps:true});
// used while encrypting user entered password
userSchema.pre("save",async function(){
    var user = this;
    if(!user.isModified("password")){
        return
    }
    try{
        const salt = await bcrypt.genSalt(10);
        const hash = await bcrypt.hash(user.password,salt);
        user.password = hash;
    }catch(err){
        throw err;
    }
});
//used while signIn decrypt
userSchema.methods.comparePassword = async function (candidatePassword) {
    try {
        console.log('----------------no password',this.password);
        // @ts-ignore
        const isMatch = await bcrypt.compare(candidatePassword, this.password);
        return isMatch;
    } catch (error) {
        throw error;
    }
};

module.exports = mongoose.model("user", userSchema);