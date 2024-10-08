console.log("Hello, I am Node Server");

//Import packages
const express = require("express")
const mongoose = require('mongoose')
const cors = require('cors');

//Import form other files
const authRouter = require('./routes/auth')

//Init
const app = express() //Getting express instance
const PORT =  3000
const DB = "mongodb+srv://lankeshmeganathan:amazon%40123@cluster0.izqnv.mongodb.net/Cluster0?retryWrites=true&w=majority&appName=Cluster0";

//Middle ware
app.use(express.json());
app.use(authRouter);
app.use(cors());

//Connecting to MongoDB
mongoose.connect(DB).then(() => {
    console.log("Database Connection is Successfully done")
}).catch((e) => {
    console.log(e);
})
// Connecting to the port address
app.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected at port ${PORT}`);
});

// const EventEmmitter = require('events');

// var event = new EventEmmitter();

// event.on('MyEvent', (text) => {
//     console.log(`Hello $text`);
// });

// event.emit('MyEvent', "Lankesh");