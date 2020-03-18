const mysql = require('mysql')  //cnpm install --save mysql
const pool = require('../config/dbconfig.js')

let query = function( sql, values ) {
  return new Promise(( resolve, reject ) => {
    pool.getConnection(function(err, connection) {
      if (err) {
        reject( err )
      } else {
        connection.query(sql, values, ( err, rows) => {
          if ( err ) {
            reject( err )
          } else {
            resolve( rows )
          }
          connection.release()
        })
      }
    })
  })
}

async function getData( ) {
  let sql = 'SELECT * FROM runoob_tbl'
  let data = await query( sql )
  console.log(data)
}
getData()
// 原文链接：https://blog.csdn.net/buppt/article/details/81268874
