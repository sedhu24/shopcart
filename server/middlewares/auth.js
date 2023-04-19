const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
  try {
    console.log("auth => middleware => try");
    const token = req.header("x-auth-token");

    if (!token)
      return res.status(401).json({ msg: "No Auth Token Access Denied" });

    const verified = jwt.verify(token, "paswordkey");

    if (!token)
      return res
        .status(401)
        .json({ msg: "Token Verification failed Access Denied" });

    req.user = verified.id;
    req.token = token;

    next();
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = auth;
