const db = require('../src/config/db.js');
db.query("SHOW TABLES LIKE '%spouse%'", (err, res) => {
    console.log(res);
    process.exit(0);
});
