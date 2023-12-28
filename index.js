import express from 'express';
// import { urlencoded, json } from 'body-parser';
// import helmet from 'helmet';
// import morgan from 'morgan';
// import cors from 'cors';
import mongoose from 'mongoose';
import UserRouter from './routes/user_routes.js';
// const express = require('express');
import bodyParser from 'body-parser';
import categoryRoutes from './routes/category_routes.js';
// const helmet = require('helmet');
// const morgan = require('morgan');
// const cors = require('cors');
// const mongoose = require('mongoose');


const app = express();
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
// app.use(helmet());
// app.use(morgan('dev'));
// app.use(cors());

// encode padssword if contains special characters  (: / ? # [ ] @)
mongoose.connect("mongodb+srv://shivani123:shivi%40123@cluster0.hvm8wx5.mongodb.net/NODEBACKEND?retryWrites=true&w=majority").then(
    () => console.log('Connected to MongoDB'),
    err => console.log(err)
);


app.use("/api/user", UserRouter);
app.use("/api/category", categoryRoutes);

app.get('/', (req, res) => {
    res.send('Hello World!');
   // res.json({s: true, msg: "jsgdjhs"});
});

app.listen(3000, () => console.log('Server started at port 3000!'));



//api key --> PMAK-658bc352c2f1a9717ac7a9f8-d3d24345995b52f2657b25c30af8fd479b