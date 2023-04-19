const jwt = require("jsonwebtoken");
const User = require("../models/user");

const admin = async (req, res, next) => {
  try {
    const type = req.headers("X-auth-token");

    if (!token)
      return res.status(401).json({ msg: "No Auth Token Access Denied" });

    const verified = jwt.verify(token, "passwordkey");

    if (!token)
      return res
        .status(401)
        .json({ msg: "Token Verification failed Access Denied" });

    const user = await User.findById(verified.id);

    // validating by type

    if (user.type == "user" || user.type == "seller") {
      return res.status(401).json({ msg: "You are not an admin! :(" });
    }

    req.user = verified.id;
    req.token = token;
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = admin;
