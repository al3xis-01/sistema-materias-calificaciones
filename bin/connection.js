
const mysql = require('mysql');

const connection = mysql.createConnection({
    host : 'localhost',
    port:   '4306',
    database : 'sistema_db',
    user : 'sistema_db_usr',
    password : 'H26x5!PnL0LE'
});

connection.connect(function(error){
    if(error)
    {
        throw error;
    }
    else
    {
        console.log('MySQL Database is connected Successfully');
    }
});

module.exports = connection;

