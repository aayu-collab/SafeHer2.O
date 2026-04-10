const jwt = require("jsonwebtoken");//impoting JWT library JWT means JSON  Web Token

module.exports = (req, res, next) => {// creating middleware function Next() means ->  go next step(controller)
  const token = req.header("Authorization");//getting token from request header

  if (!token) return res.status(401).json({ msg: "No token" });//if token is not present ->user is not logged in

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);//verryfying if token using sceret key 
    req.user = decoded;//attaching user data to request
    next();//move to next function(controller)
  } catch (err) {
    res.status(401).json({ msg: "Invalid token" });//if token is expire -> reject request
  }
};

