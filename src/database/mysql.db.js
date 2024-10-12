const mysql = require('mysql2/promise');
const config = require('config');

const DB_HOST = config.db.get('DB_HOST');
const DB_PORT = config.db.get('DB_PORT');
const DB_NAME = config.db.get('DB_NAME');
const DB_USERNAME = config.db.get('DB_USERNAME');
const DB_USERNAME_PASSWORD = config.db.get('DB_USERNAME_PASSWORD');
const DB_CONNECT_TIMEOUT = config.db.get('DB_CONNECT_TIMEOUT');
const DB_MULTIPLE_STATEMENTS = config.db.get('DB_MULTIPLE_STATEMENTS');

const connectionOptions = {
    host: DB_HOST,
    port: DB_PORT,
    database: DB_NAME,
    user: DB_USERNAME,
    password: DB_USERNAME_PASSWORD,
    connectTimeout: DB_CONNECT_TIMEOUT,
    connectionLimit : 1000,
    multipleStatements: DB_MULTIPLE_STATEMENTS,
    //debug: true,
    /*waitForConnections: true,
    connectionLimit: 10,
    maxIdle: 10,
    idleTimeout: 60000,
    queueLimit: 0,*/
    /*waitForConnections    : true,
    connectionLimit       : 3,
    maxIdle               : 3, // max idle connections, the default value is the same as `connectionLimit`
    idleTimeout           : 60000, // idle connections timeout, in milliseconds, the default value 60000
    queueLimit            : 0,
    enableKeepAlive       : true,
    keepAliveInitialDelay : 0,*/
};

// ===== mysql2 =====
const pool = mysql.createPool(connectionOptions);

const connectToMySQL = async () => {
    try {
        await pool.getConnection();

        console.log('MySQL database connected!');
    } catch (err) {
        console.log('MySQL database connection error!');
        console.log(err);

        process.exit(1);
    }
};

connectToMySQL().then();

async function callSpSearch(id, spName) {
    const connection = await mysql.createConnection(connectionOptions);
    const [results,] = await connection.query('CALL ' + spName + '(' + id + ')');

    return results;
}

// ============ MEMBERS ============
async function callSpFetchMembers(spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}()`);

        return results;
    } catch (err) {
        console.error(`Error while getting records`, err.message);
        return {};
    }
}

async function callSpSearchMembername(membername, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query('CALL ' + spName + '("' + membername + '")');

        return results;
    } catch (err) {
        console.error(`Error while searching member`, err.message);
        return {};
    }
}

async function callSpSearchMembernames(membername, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query('CALL ' + spName + '("' + membername + '")');

        return results;
    } catch (err) {
        console.error(`Error while querying members`, err.message);
        return {};
    }
}


async function callSpCreateMemberWithSignup(fieldSet, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}('${JSON.stringify(fieldSet)}')`);

        return results;
    } catch (err) {
        console.error(`Error while creating member`, err.message);
        return {};
    }

}

async function callSpCreateMemberFromBlank(fieldSet, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}('${JSON.stringify(fieldSet)}')`);

        return results;
    } catch (err) {
        console.error(`Error while creating member`, err.message);
        return {};
    }
}

async function callSpFilterMemberStatus(filter, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}(${filter})`);

        return results;
    } catch (err) {
        console.error(`Error while querying members`, err.message);
        return {};
    }
}

async function callSpUpdateUserForMember(fieldSet, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}('${JSON.stringify(fieldSet)}')`);

        return results;
    } catch (err) {
        console.error(`Error while updating member`, err.message);
        return {};
    }
}

async function callSpApproveRegistration(membername, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query('CALL ' + spName + '("' + membername + '")');

        return results;
    } catch (err) {
        console.error(`Error while processing member approval`, err.message);
        return {};
    }
}

async function callSpBatchApproval(memberids, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}('${memberids}')`);

        return results;
    } catch (err) {
        console.error(`Error while processing batch member approval`, err.message);
        return {};
    }
}

// ============ MEMBER PROFILES ============
async function callSpSearchProfile(membername, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query('CALL ' + spName + '("' + membername + '")');

        return results;
    } catch (err) {
        console.error(`Error while searching member profile`, err.message);
        return {};
    }
}

async function callSpSearchProfiles(membername, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query('CALL ' + spName + '("' + membername + '")');

        return results;
    } catch (err) {
        console.error(`Error while querying member profiles`, err.message);
        return {};
    }
}


async function callSpCreateMemberProfile(fieldSet, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}('${JSON.stringify(fieldSet)}')`);

        return results;
    } catch (err) {
        console.error(`Error while creating member profile`, err.message);
        console.error(`Error`, err.id);
        return {};
    }
}

async function callSpUpdateMemberProfile(fieldSet, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}('${JSON.stringify(fieldSet)}')`);

        return results;
    } catch (err) {
        console.error(`Error while updating member profile`, err.message);
        return {};
    }
}

// ============ USERS ============
async function callSpAuthenticate(username, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query('CALL ' + spName + '("' + username + '")');

        return results;
    } catch (err) {
        console.error(`Error while authenticating`, err.message);
        return {};
    }
}

async function callSpRegisterFromReferral(fieldSet, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}('${JSON.stringify(fieldSet)}')`);

        return results;
    } catch (err) {
        console.error(`Error while registering member`, err.message);
        return {};
    }
}

async function callSpSearchUsername(username, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query('CALL ' + spName + '("' + username + '")');

        return results;
    } catch (err) {
        console.error(`Error while searching user`, err.message);
        return {};
    }
}

async function callSpSearchUsernames(username, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query('CALL ' + spName + '("' + username + '")');

        return results;
    } catch (err) {
        console.error(`Error while querying users`, err.message);
        return {};
    }
}


async function callSpCreateMember(fieldSet, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}('${JSON.stringify(fieldSet)}')`);

        return results;
    } catch (err) {
        console.error(`Error while creating member`, err.message);
        return {};
    }
}

// ============ DEPOSIT (tx_type = 1) ============
async function callSpFetchDeposits(spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}(1)`);

        return results;
    } catch (err) {
        console.error(`Error while getting deposits`, err.message);
        return {};
    }
}

async function callSpSearchDeposit(id, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}(${id}, 1)`);

        return results;
    } catch (err) {
        console.error(`Error while searching deposit`, err.message);
        return {};
    }
}

async function callSpFilterDeposits(filter, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}(${filter}, 1)`);

        return results;
    } catch (err) {
        console.error(`Error while querying deposits`, err.message);
        return {};
    }
}

async function callSpUpdateDeposit(id, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}(${id})`);

        return results;
    } catch (err) {
        console.error(`Error while processing deposit confirmation`, err.message);
        return {};
    }
}

async function callSpBatchConfirmDeposit(ids, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}('${ids}')`);

        return results;
    } catch (err) {
        console.error(`Error while processing batch deposit confirmation`, err.message);
        return {};
    }
}

// ============ WITHDRAWAL (tx_type = 2) ============
async function callSpFetchWithdrawals(spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}(2)`);

        return results;
    } catch (err) {
        console.error(`Error while getting withdrawals`, err.message);
        return {};
    }
}

async function callSpSearchWithdrawal(id, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}(${id}, 2)`);

        return results;
    } catch (err) {
        console.error(`Error while searching withdrawal`, err.message);
        return {};
    }
}

async function callSpFilterWithdrawals(filter1, filter2, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}(${filter1}, ${filter2}, 2)`);

        return results;
    } catch (err) {
        console.error(`Error while querying withdrawals`, err.message);
        return {};
    }
}

async function callSpUpdateWithdrawal(id, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}(${id}, 2)`); //Personal Expenses

        return results;
    } catch (err) {
        console.error(`Error while processing withdrawal confirmation`, err.message);
        return {};
    }
}

async function callSpBatchConfirmWithdrawal(ids, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}('${ids}')`);

        return results;
    } catch (err) {
        console.error(`Error while processing batch withdrawal confirmation`, err.message);
        return {};
    }
}

// ============ TRANSFER (tx_type = 3) ============
async function callSpFetchTransfers(spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}`);

        return results;
    } catch (err) {
        console.error(`Error while getting transfers`, err.message);
        return {};
    }
}

async function callSpSearchTransfer(id, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}(${id})`);

        return results;
    } catch (err) {
        console.error(`Error while searching transfer`, err.message);
        return {};
    }
}


async function callSpFilterTransfers(filter, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}(${filter})`);

        return results;
    } catch (err) {
        console.error(`Error while querying transfers`, err.message);
        return {};
    }
}

async function callSpUpdateTransfer(id, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}(${id})`);

        return results;
    } catch (err) {
        console.error(`Error while processing transfer confirmation`, err.message);
        return {};
    }
}

async function callSpBatchConfirmTransfer(ids, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}('${ids}')`);

        return results;
    } catch (err) {
        console.error(`Error while processing batch transfer confirmation`, err.message);
        return {};
    }
}

async function callSpUpdateTransfer(id, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}(${id})`);

        return results;
    } catch (err) {
        console.error(`Error while processing transfer confirmation`, err.message);
        return {};
    }
}

async function callSpBatchConfirmTransfer(ids, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}('${ids}')`);

        return results;
    } catch (err) {
        console.error(`Error while processing batch transfer confirmation`, err.message);
        return {};
    }
}

// ============ TRANSACTION ============
async function callSpFetchTXHistory(membername, paginate1, paginate2, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}("${membername}", ${paginate1}, ${paginate2})`);

        return results;
    } catch (err) {
        console.error(`Error while querying transaction history`, err.message);
        return {};
    }
}

async function callSpFetchFilterTXHistory(membername, txType, paginate1, paginate2, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}("${membername}", ${txType}, ${paginate1}, ${paginate2})`);

        return results;
    } catch (err) {
        console.error(`Error while querying transaction history`, err.message);
        return {};
    }
}

async function callSpCreateDeposit(field1, field2, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}("${field1}", ${field2})`);

        return results;
    } catch (err) {
        console.error(`Error while creating deposit in history`, err.message);
        return {};
    }
}

async function callSpCreateWithdrawal(field1, field2, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}("${field1}", ${field2})`);

        return results;
    } catch (err) {
        console.error(`Error while creating withdrawal in history`, err.message);
        return {};
    }
}

async function callSpCreateTransfer(field1, field2, field3, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}("${field1}", ${field2}, "${field3}")`);

        return results;
    } catch (err) {
        console.error(`Error while creating transfer in history`, err.message);
        return {};
    }
}

// ===== accounting profile =====
async function callSpGetAccountBalance(membername, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}("${membername}")`);

        return results;
    } catch (err) {
        console.error(`Error while searching current balance`, err.message);
        return {};
    }
}

// ===== SALES ACTIVITY - Tickets Payments =====
async function callSpPayTickets(field1, field2, field3, field4, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}("${field1}", ${field2}, "${field3}", "${field4}")`);

        return results;
    } catch (err) {
        console.error(`Error while creating tickets payment`, err.message);
        return {};
    }
}


async function callSpFetchRemittances(spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}()`);

        return results;
    } catch (err) {
        console.error(`Error while querying remittances`, err.message);
        return {};
    }
}

async function callSpFetchCurrentRemittance(spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}()`);

        return results;
    } catch (err) {
        console.error(`Error while querying unpaid remittance`, err.message);
        return {};
    }
}

async function callSpAddRemittance(spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}()`);

        return results;
    } catch (err) {
        console.error(`Error while processing adding remittance`, err.message);
        return {};
    }
}


async function callSpFetchCurrentRevenues(filter1, filter2, filter3, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}("${filter1}", "${filter2}", "${filter3}")`);

        return results;
    } catch (err) {
        console.error(`Error while querying revenues`, err.message);
        return {};
    }
}

async function callSpFetchLineageRevenues(filter, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}("${filter}")`);

        return results;
    } catch (err) {
        console.error(`Error while querying revenues`, err.message);
        return {};
    }
}


async function callSpFetchCurrentSysRevenues(filter1, filter2, filter3, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}("${filter1}", "${filter2}", "${filter3}")`);

        return results;
    } catch (err) {
        console.error(`Error while querying revenues`, err.message);
        return {};
    }
}

async function callSpFetchLineageSysRevenues(filter, spName) {
    // ===== For the current version, no need to input 'membername' as parameter (filter)
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}()`); // -> no '"${filter}()"'

        return results;
    } catch (err) {
        console.error(`Error while querying revenues`, err.message);
        return {};
    }
}

async function callSpFetchBatchChartRevenues(filter1, filter2, filter3, spName) {
    try {
        const connection = await mysql.createConnection(connectionOptions);
        const [results,] = await connection.query(`CALL ${spName}("${filter1}", ${filter2}, ${filter3})`);

        return results;
    } catch (err) {
        console.error(`Error while querying revenues`, err.message);
        return {};
    }
}


function isJsonString(str) {
    try {
        JSON.parse(str);
    } catch (e) {
        return false;
    }
    return true;
}

//exports.query = pool; //Equivalent ->
module.exports = pool;
//exports.pool = pool;

module.exports = {
    callSpSearch,

    callSpFetchMembers,
    callSpSearchMembername,
    callSpSearchMembernames,
    callSpCreateMemberWithSignup,
    callSpCreateMemberFromBlank,
    callSpFilterMemberStatus,
    callSpUpdateUserForMember,

    callSpSearchProfile,
    callSpSearchProfiles,
    callSpCreateMemberProfile,
    callSpUpdateMemberProfile,

    callSpAuthenticate,
    callSpRegisterFromReferral,
    callSpSearchUsername,
    callSpSearchUsernames,

    callSpApproveRegistration,
    callSpBatchApproval,

    callSpFetchDeposits,
    callSpSearchDeposit,
    callSpFilterDeposits,
    callSpUpdateDeposit,
    callSpBatchConfirmDeposit,

    callSpFetchWithdrawals,
    callSpSearchWithdrawal,
    callSpFilterWithdrawals,
    callSpUpdateWithdrawal,
    callSpBatchConfirmWithdrawal,

    callSpFetchTransfers,
    callSpSearchTransfer,
    callSpFilterTransfers,
    callSpUpdateTransfer,
    callSpBatchConfirmTransfer,

    callSpFetchTXHistory,
    callSpFetchFilterTXHistory,
    callSpCreateDeposit,
    callSpCreateWithdrawal,
    callSpCreateTransfer,

    callSpGetAccountBalance,

    callSpPayTickets,
    callSpFetchRemittances,
    callSpFetchCurrentRemittance,
    callSpAddRemittance,

    callSpFetchCurrentRevenues,
    callSpFetchLineageRevenues,
    callSpFetchCurrentSysRevenues,
    callSpFetchLineageSysRevenues,

    callSpFetchBatchChartRevenues
}