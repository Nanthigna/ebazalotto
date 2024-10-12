/*
CREATE USER 'ebazasto_root'@'127.0.0.1' IDENTIFIED BY 'Spiderman007';
CREATE USER 'ebazasto_root'@'::1' IDENTIFIED BY 'Spiderman007';
FLUSH PRIVILEGES;

GRANT ALL PRIVILEGES ON *.* TO 'ebazasto_root'@'127.0.0.1'
GRANT ALL PRIVILEGES ON *.* TO 'ebazasto_root'@'::1'
FLUSH PRIVILEGES
*/

module.exports = {
    db: {
        /* don't expose password or any sensitive info, done only for demo */
        // TEMP
        PORT: process.env.PORT || 3000,
        DB_HOST: process.env.DB_HOST || 'localhost', // server306.orangehost.com
        DB_PORT: process.env.DB_PORT || '3306',
        DB_USERNAME: process.env.DB_USERNAME || 'root', //ebazasto_root
        DB_USERNAME_PASSWORD: process.env.DB_USERNAME_PASSWORD || 'root', // @Spiderman007
        DB_NAME: process.env.DB_NAME || 'sabuydy', // ebazalottery  //ebazasto_ebazalottery
        DB_CONNECT_TIMEOUT: 60000,
        DB_MULTIPLE_STATEMENTS: true
    },
    listPerPage: 10,
};
