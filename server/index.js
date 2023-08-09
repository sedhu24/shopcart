// Imports from Packeges
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

// Import from Other Files
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");
// InIt
const PORT = 3000;
const DB =
  "mongodb+srv://sedhu:7h39r0xy@cluster0.aitf1ok.mongodb.net/?retryWrites=true&w=majority";

const app = express();

// midleWare
app.use(express.json());
app.use(cors());
app.use(authRouter);
app.use(adminRouter);
app.use(userRouter);
app.use(productRouter);
// CLIENT -> MidleWare -> Server -> CLIENT

// connection
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successfull");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Connect To Port ${PORT}`);
});
