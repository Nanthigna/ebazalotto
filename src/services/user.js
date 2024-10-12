const pool = require('../database/mysql.db');
const helper = require('../database/helper');
const cryptoUtils = require('../database/crypto_utils');
//const consts = require('../constants');
const config = require('config');

async function getMultiple(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const sql = `SELECT id, username, email, phoneno, password, roleid 
                FROM users LIMIT ${offset},${config.listPerPage}`;
    const [rows, fields] = await pool.query.execute(sql);

    const data = helper.emptyOrRows(rows);
    const meta = { page };

    return {
        data,
        meta
    }
}

async function createUser(fieldSet) {
    const rows = await pool.callSpCreateUser(fieldSet, 'sp_create_user');
    const result = helper.emptyOrRows(rows);

    let message = 'Error in creating record';

    if (result.affectedRows) {
        message = 'Record created successfully';
    }

    return { message };
}

async function createFromReferral(fieldSet) {
    var password = fieldSet.password;
    if (password.split(':').length == 1) { // No encryption from front-end
        fieldSet.password = encryptData(password);
        return await postRegisterInfo(fieldSet);
    } else {
        return await postRegisterInfo(fieldSet);
    };
}

function postRegisterInfo(fieldSet) {
    const rows = pool.callSpRegisterFromReferral(fieldSet, 'sp_register_from_referral');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function update(id, record) {
    const sql = `UPDATE users SET username = "${record.username}", email = "${record.email}", phoneno = "${record.phoneno}", password = "${record.password}", roleid = ${record.roleid} WHERE id = ${id}`;
    const result = await pool.query.execute(sql);

    let message = 'Error in updating record';

    if (result.affectedRows) {
        message = 'Record updated successfully';
    }

    return { message };
}

async function remove(id) {
    const sql = `DELETE FROM users WHERE id = ${id}`;
    const result = await pool.query.execute(sql);

    let message = 'Error in deleting record';

    if (result.affectedRows) {
        message = 'Record deleted successfully';
    }

    return { message };
}

async function search(id) {
    const rows = await pool.callSpSearch(id, 'sp_search_user_by_id');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function searchUsername(username) {
    const rows = await pool.callSpSearchUsername(username, 'sp_search_user_by_username');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function searchUsernames(username) {
    const rows = await pool.callSpSearchUsernames(username, 'sp_search_usernames');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function authenticate(urlUsername, urlPassword) {
    const rows = await pool.callSpAuthenticate(urlUsername, 'sp_authenticate');
    var data = helper.emptyOrRows(rows);

    if (data[0].length != 0) {
        var storedPassword = data[0][0]['Bytes'];

        if (urlPassword != '') { // Was password with signup via website
            if (!storedPassword.includes(':')) { // Not Fully Registered with permanent encrypted password schema
                const decryptedPassword = decryptData(storedPassword);
                //console.log(`services: ${urlUsername}`);
                //console.log(`services: ${urlPassword}`);
                //console.log(`services: ${decryptedPassword}`);
                if (decryptedPassword == urlPassword) {
                    data[0][0]['Bytes'] = 'You are welcomed!';
                } else {
                    data[0][0]['Bytes'] = 'No reason to complain!';
                }
            } else {
                data[0][0]['Bytes'] = 'You are welcomed!';
            }
        } else {

            if (storedPassword.includes(':')) {
                // When commented: it is more secure to be left for device to decrypt
                //Data[0][0]['Bytes'] = 'You are welcomed!';
            } else {
                data[0][0]['Bytes'] = 'No reason to complain!';
            }
        }
    } else {
        data[0].push({ 'Bytes': 'No reason to complain!' });
    }

    //console.log(data[0][0]['Bytes']);
    return {
        data
    }
}

module.exports = {
    getMultiple,
    createUser,
    update,
    remove,
    search,
    searchUsername,
    searchUsernames,
    authenticate,
    createFromReferral
}