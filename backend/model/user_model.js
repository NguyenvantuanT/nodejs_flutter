
const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const userSchema = new Schema({
  name : {type: String},
  age : {type: String},
});

let UserModel = mongoose.model('User', userSchema );
module.exports =  { UserModel };