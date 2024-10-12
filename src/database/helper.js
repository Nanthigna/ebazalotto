//const crypto = require('crypto');

function getOffset(currentPage = 1, listPerPage) {
    return (currentPage - 1) * [listPerPage];
}

function emptyOrRows(rows) {
    if (!rows) {
        return [];
    }
    return rows;
}

function encryptPassword(plainPassword) {
    // Promise pattern to generate salt and hash
    const bcrypt = require('bcrypt');
    const workFactor = 10;

    bcrypt
        .genSalt(workFactor)
        .then(salt => {
            console.log(`Salt: ${salt}`);
            return bcrypt.hash(plainPassword, salt);
        })
        .then(hash => {
            console.log(`Hash: ${hash}`);
            return hash;
        })
        .catch(err => console.error(err.message));

    // Without promise pattern - Seperate function to generate salt and hash
    /*const bcrypt = require('bcrypt');
    const workFactor = 10;

    bcrypt.genSalt(workFactor, function (err, salt) {
        bcrypt.hash(plainPassword, salt, function (err, hash) {
            console.log(`Hash: ${hash}`);
            return hash;
        });
    });*/
}

// Compare hash and password using the compare method
function verifyPassword(userProvidedPassword, storedHash) {
    const bcrypt = require('bcrypt');

    if (!storedHash.includes(':')) {
        bcrypt.compare(userProvidedPassword, storedHash, function (err, result) {
            if (err) throw err;
            // Password matched
            if (result) {
                console.log("Password verified");
            }
            // Password not matched
            else {
                console.log("Password not verified");
            }
        });
    }
}

module.exports = {
    getOffset,
    emptyOrRows,
    encryptPassword,
    verifyPassword
}