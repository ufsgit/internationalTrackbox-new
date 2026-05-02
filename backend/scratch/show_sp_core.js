const db = require('../src/config/db');

async function showSP() {
    try {
        await new Promise((resolve, reject) => {
            db.query("SHOW CREATE TABLE application_admission_tests", (err, results) => {
                if (err) return reject(err);
                console.log(results[0]['Create Table']);
                resolve();
            });
        });
        process.exit(0);
    } catch(err) {
        console.error(err);
        process.exit(1);
    }
}
showSP();
