const express = require("express");
const dotenv = require("dotenv");
const mongoose = require("mongoose");
const userRouter = require("./routes/user");
const bodyParser = require('body-parser');

const app = express();

dotenv.config();

mongoose.connect(process.env.MONGO_URL)
    .then(() => { console.log("Success") })
    .catch((err) => console.error(err));

app.use(bodyParser.json());

//router
app.use("/v1/user" , userRouter);


app.listen(process.env.PORT, () => {
    console.log("Server is running...")
})