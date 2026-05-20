require('dotenv').config();
const db = require('../src/config/db');

async function main() {
    try {
        const [cols1] = await db.promise().query('DESCRIBE student_applications');
        const hasAppCol = cols1.some(c => c.Field === 'spouse_has_language_test');
        console.log('student_applications has spouse_has_language_test:', hasAppCol);

        const [cols2] = await db.promise().query('DESCRIBE student_registrations');
        const hasRegCol = cols2.some(c => c.Field === 'spouse_has_language_test');
        console.log('student_registrations has spouse_has_language_test:', hasRegCol);
    } catch (err) {
        console.error('Error:', err);
    }
    process.exit(0);
}

main();
