const jwt = require("jsonwebtoken");
const User = require("../models/user");

const admin = async (req, res, next) => {
  try {
    console.log("admin => middleware => try");
    const token = req.header("x-auth-token");

    if (!token)
      return res.status(401).json({ msg: "No Auth Token Access Denied" });

    const verified = jwt.verify(token, "paswordkey");

    if (!token)
      return res
        .status(401)
        .json({ msg: "Token Verification failed Access Denied" });

    const user = await User.findById(verified.id);

    // validating by type

    if (user.type == "user" || user.type == "seller") {
      return res.status(401).json({ msg: "You are not an admin" });
    }

    req.user = verified.id;
    req.token = token;

    next();
  } catch (error) {
    console.log("admin => middleware => catch");
    res.status(500).json({ error: error.message });
  }
};

module.exports = admin;
