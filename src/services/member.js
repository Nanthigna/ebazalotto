const pool = require('../database/mysql.db');
const helper = require('../database/helper');
const config = require('config');

async function getMultiple(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const sql = `SELECT membername, parentid, sales_comm_perc 
                FROM members LIMIT ${offset},${config.listPerPage}`;
    const [rows, fields] = await pool.query.execute(sql);

    const data = helper.emptyOrRows(rows);
    const meta = { page };

    return {
        data,
        meta
    }
}

async function getMembers() {
    const rows = await pool.callSpFetchMembers('sp_fetch_members');
    const data = helper.emptyOrRows(rows);

    return {
        data
    }
}

async function create(record) {
    const sql = `INSERT INTO members (membername, parentid, sales_comm_perc) VALUES ("${record.membername}", ${record.parentid}, ${record.sales_comm_perc})`;
    const result = await pool.query.execute(sql);

    let message = 'Error in creating record';

    if (result.affectedRows) {
        message = 'Record created successfully';
    }

    return { message };
}

async function update(id, record) {
    const sql = `UPDATE members SET membername = "${record.membername}", parentid = ${record.parentid}, sales_comm_perc = ${record.sales_comm_perc} WHERE id = ${id}`;
    const result = await pool.query.execute(sql);

    let message = 'Error in updating record';

    if (result.affectedRows) {
        message = 'Record updated successfully';
    }

    return { message };
}

async function updateUserCredentials(record) {
    const rows = await pool.callSpUpdateUserForMember(record, 'sp_update_user_for_member');
    const result = helper.emptyOrRows(rows);

    let message = 'Error in updating record';

    if (result.affectedRows) {
        message = 'Record updated successfully';
    }

    return { message };
}

async function createMemberWithSignup(record) {
    const rows = await pool.callSpCreateMemberWithSignup(record, 'sp_create_member_signup');
    const result = helper.emptyOrRows(rows);

    let message = 'Error in creating record';

    if (result.affectedRows) {
        message = 'Record created successfully';
    }

    return { message };
}

async function createMemberFromBlank(record) {
    const rows = await pool.callSpCreateMemberFromBlank(record, 'sp_create_member_blank');
    const result = helper.emptyOrRows(rows);

    let message = 'Error in creating record';

    if (result.affectedRows) {
        message = 'Record created successfully';
    }

    return { message };
}

async function updateMemberApproval(membername) {
    const rows = await pool.callSpApproveRegistration(membername, 'sp_approve_registration');
    const result = helper.emptyOrRows(rows);

    let message = 'Error in updating record';

    if (result.affectedRows) {
        message = 'Record updated successfully';
    }

    return { message };
}

async function updateBatchApproval(memberids) {
    const rows = await pool.callSpBatchApproval(memberids, 'sp_approve_batch_registration');
    const result = helper.emptyOrRows(rows);

    let message = 'Error in updating record';

    if (result[0][0].affectedRows) {
        message = 'Record updated successfully';
    }

    return { message };
}

async function remove(id) {
    const sql = `DELETE FROM members WHERE id = ${id}`;
    const result = await pool.query.execute(sql);

    let message = 'Error in deleting record';

    if (result.affectedRows) {
        message = 'Record deleted successfully';
    }

    return { message };
}

async function search(id) {
    const rows = await pool.callSpSearch(id, 'sp_search_member_by_id');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}


async function searchMembername(membername) {
    const rows = await pool.callSpSearchMembername(membername, 'sp_search_member_by_membername');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function searchMembernames(membername) {
    const rows = await pool.callSpSearchMembernames(membername, 'sp_search_membernames');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function filterMemberstatus(filter) {
    const rows = await pool.callSpFilterMemberStatus(filter, 'sp_fetch_filter_members');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

module.exports = {
    getMultiple,
    create,
    update,
    remove,
    search,
    getMembers,
    searchMembername,
    searchMembernames,
    filterMemberstatus,
    updateUserCredentials,
    updateMemberApproval,
    updateBatchApproval,
    createMemberWithSignup,
    createMemberFromBlank
}