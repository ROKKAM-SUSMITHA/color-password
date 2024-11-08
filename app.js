const express=require('express');
const mongoose=require('mongoose');
const bodyParser=require("body-parser");
const port=process.env.port || 8080;
const homeRouter=require('./router/homeRouter');
const app=express();
const path=require('path');
// app.get('/',(err,res)=>{
//     res.send("hello");
// })
app.use(bodyParser.urlencoded({extended:false}))
app.use(bodyParser.json())
app.use('/',homeRouter);

mongoose.connect('mongodb://root:root@192.168.3.233:27017/registration?authSource=admin&directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.3.3',{useNewUrlParser:true})
const db=mongoose.connection;
// console.log('Connected to database:', mongoose.connection.db.databaseName);

db.on("error",()=>{console.log("error in connection");});
db.once('open',()=>{
    console.log('Connected to database:', mongoose.connection.db.databaseName);
    console.log("successfull");
});
app.set('view engine','ejs')
app.use(express.static('public'));
app.listen(port);
