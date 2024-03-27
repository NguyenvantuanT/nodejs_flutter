const UserController = require("../controller/userController");

const router = require("express").Router();

router.post("/" , UserController.addUser);
router.get("/" , UserController.getUser);
router.delete("/:id" , UserController.deleteUser);
router.put("/:id" , UserController.updateUser);





module.exports = router;