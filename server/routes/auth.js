const express = require("express");
const User = require('../models/user')
const authRouter = express.Router();
const bcrypt = require('bcryptjs');

//SIGN UP ROUTE
authRouter.post('/api/signup', async (req, res) => {
    const {name, email, password} = req.body;

    const existingUser = await User.findOne( { email } );

    if(existingUser) {
        return res.status(400).json({"msg" : "User with the same email is already exist"})
    }
    if (!name || !email || !password) {
        return res.status(400).json({ message: 'Name, email, and password are required.' });
      }
    const hashedPass =  await bcrypt.hash(password, 8);
    let user = new User(
        {
            name,
            email,
            password : hashedPass,
        }
    )

    user = await user.save();
    res.json(user);
})

module.exports = authRouter;