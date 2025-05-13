const express = require('express');
const app = express();


app.get('/',(req,res)=>{
    res.sendFile(__dirname + '/index.html');
})

app.listen(3000,(err)=>{
    if(err){
        console.log(err);
    }
    console.log('Server is running on port 3000');
})