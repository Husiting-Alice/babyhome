const mysql = require('mysql')  //cnpm install --save mysql
const pool = mysql.createPool({
  host     :  'localhost',
  user     :  'root',
  password :  'hst168168',
  database :  'babyhomedb'
})

module.exports = pool;
