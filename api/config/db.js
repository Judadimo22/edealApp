const mongoose = require('mongoose');
require("dotenv").config(); 

const connection = mongoose.createConnection(
    process.env.MONGO_URI)
    .on('open',()=>{console.log("MongoDB Connected");}).on('error',()=>{
    console.log("MongoDB Connection error");
});

module.exports = connection;