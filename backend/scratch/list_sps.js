const mysql = require('mysql2');
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root123',
    database: 'internationaldb'
});

db.connect(err => {
    if (err) {
        console.error(err);
        process.exit(1);
    }
    db.query('SHOW PROCEDURE STATUS WHERE Db = "internationaldb"', (err, rows) => {
        if (err) {
            console.error(err);
        } else {
            console.log(rows.filter(r => r.Name.includes('Registration')).map(r => r.Name));
        }
        db.end();
    });
});
