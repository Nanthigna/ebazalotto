const pool = require('../database/mysql.db');
const helper = require('../database/helper');
const config = require('config');

// ============ DEPOSIT ============
async function getDeposits() {
    const rows = await pool.callSpFetchDeposits('sp_fetch_deposits');
    const data = helper.emptyOrRows(rows);

    return {
        data
    }
}

async function filterDeposits(filter) {
    const rows = await pool.callSpFilterDeposits(filter, 'sp_fetch_filter_deposits');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function searchDeposit(id) {
    const rows = await pool.callSpSearchDeposit(id, 'sp_search_deposit');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function updateDeposit(id) {
    const rows = await pool.callSpUpdateDeposit(id, 'sp_confirm_deposit');
    const result = helper.emptyOrRows(rows);

    let message = 'Error in updating record';

    if (result.affectedRows) {
        message = 'Record updated successfully';
    }

    return { message };
}

async function updateBatchDeposit(ids) {
    const rows = await pool.callSpBatchConfirmDeposit(ids, 'sp_confirm_batch_deposit');
    const result = helper.emptyOrRows(rows);

    let message = 'Error in updating record';

    if (result[0][0].affectedRows) {
        message = 'Record updated successfully';
    }

    return { message };
}

// ============ WITHDRAWAL ============
async function getWithdrawals() {
    const rows = await pool.callSpFetchWithdrawals('sp_fetch_withdrawals');
    const data = helper.emptyOrRows(rows);

    return {
        data
    }
}

async function filterWithdrawals(filter1, filter2) {
    const rows = await pool.callSpFilterWithdrawals(filter1, filter2, 'sp_fetch_filter_withdrawals');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function searchWithdrawal(id) {
    const rows = await pool.callSpSearchWithdrawal(id, 'sp_search_withdrawals');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function updateWithdrawal(id) {
    const rows = await pool.callSpUpdateWithdrawal(id, 'sp_confirm_withdrawal');
    const result = helper.emptyOrRows(rows);

    let message = 'Error in updating record';

    if (result.affectedRows) {
        message = 'Record updated successfully';
    }

    return { message };
}

async function updateBatchWithdrawal(ids) {
    const rows = await pool.callSpBatchConfirmWithdrawal(ids, 'sp_confirm_batch_withdrawal');
    const result = helper.emptyOrRows(rows);

    let message = 'Error in updating record';

    if (result[0][0].affectedRows) {
        message = 'Record updated successfully';
    }

    return { message };
}

// ============ TRANSFER ============
async function getTransfers() {
    const rows = await pool.callSpFetchTransfers('sp_fetch_transfers');
    const data = helper.emptyOrRows(rows);

    return {
        data
    }
}

async function filterTransfers(filter) {
    const rows = await pool.callSpFilterTransfers(filter, 'sp_fetch_filter_transfers');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function searchTransfer(id) {
    const rows = await pool.callSpSearchTransfer(id, 'sp_search_transfer');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function updateTransfer(id) {
    const rows = await pool.callSpUpdateTransfer(id, 'sp_confirm_transfer');
    const result = helper.emptyOrRows(rows);

    let message = 'Error in updating record';

    if (result.affectedRows) {
        message = 'Record updated successfully';
    }

    return { message };
}

async function updateBatchTransfer(ids) {
    const rows = await pool.callSpBatchConfirmTransfer(ids, 'sp_confirm_batch_transfer');
    const result = helper.emptyOrRows(rows);

    let message = 'Error in updating record';

    if (result[0][0].affectedRows) {
        message = 'Record updated successfully';
    }

    return { message };
}

// ============ TRANSACTION ============
async function getTXHistory(membername, paginate1, paginate2) {
    const rows = await pool.callSpFetchTXHistory(membername, paginate1, paginate2, 'sp_fetch_tx_history');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function getFilterTXHistory(membername, txType, paginate1, paginate2) {
    const rows = await pool.callSpFetchFilterTXHistory(membername, txType, paginate1, paginate2, 'sp_fetch_filter_tx_history');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function createDeposit(field1, field2) {
    const rows = await pool.callSpCreateDeposit(field1, field2, 'sp_add_deposit');
    const result = helper.emptyOrRows(rows);

    let message = 'Error in creating record';

    if (result.affectedRows) {
        message = 'Record created successfully';
    }

    return { message };
}

async function createWithdrawal(field1, field2) {
    const rows = await pool.callSpCreateWithdrawal(field1, field2, 'sp_add_withdrawal');
    const result = helper.emptyOrRows(rows);

    let message = 'Error in creating record';

    if (result.affectedRows) {
        message = 'Record created successfully';
    }

    return { message };
}

async function createTransfer(field1, field2, field3) {
    const rows = await pool.callSpCreateTransfer(field1, field2, field3, 'sp_add_transfer');
    const result = helper.emptyOrRows(rows);

    let message = 'Error in creating record';

    if (result.affectedRows) {
        message = 'Record created successfully';
    }

    return { message };
}

// ===== accounting profile =====
async function getAccountBalance(filter) {
    const rows = await pool.callSpGetAccountBalance(filter, 'sp_get_cur_balance');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

module.exports = {
    getDeposits,
    filterDeposits,
    searchDeposit,
    updateDeposit,
    updateBatchDeposit,

    getWithdrawals,
    filterWithdrawals,
    searchWithdrawal,
    updateWithdrawal,
    updateBatchWithdrawal,

    getTransfers,
    filterTransfers,
    searchTransfer,
    updateTransfer,
    updateBatchTransfer,

    getTXHistory,
    getFilterTXHistory,
    createDeposit,
    createWithdrawal,
    createTransfer,

    getAccountBalance
}