const { UserModel } = require("../model/user_model");

const UserController = {

    // ADD USER
    addUser: async (req, res) => {
        try {
            const newUser = new UserModel(req.body);
            await newUser.save();
            res.status(201).json(newUser);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },
    
    
    //GET USER
    getUser: async (req , res) => {
        try {
           const user = await UserModel.find();
           res.json(user);
        } catch (e) {
            res.json(e);
        }
    },

    //DELETE USER
    deleteUser: async (req , res) => {
        try {
            const user = await UserModel.findByIdAndDelete(req.params.id);
            res.json("Delete success");
         } catch (e) {
             res.json(e);
         }
    },

    //UPDATE USER
    updateUser: async (req , res) => {
        try {
            const user = await UserModel.findById(req.params.id);
            await user.updateOne({$set : req.body});
            res.json(user);
         } catch (e) {
             res.json(e);
         }
    }
    

};


module.exports = UserController;