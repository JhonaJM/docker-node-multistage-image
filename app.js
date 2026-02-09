const cron = require('node-cron');
const { syncDB } = require('./tasks/sync-db');

let times = 0;
cron.schedule('1-59/5 * * * * *', syncDB);

console.log("Inicio")