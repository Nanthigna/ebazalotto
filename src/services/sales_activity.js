const pool = require('../database/mysql.db');
const helper = require('../database/helper');
const config = require('config');

async function getMultiple(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const sql = `SELECT * FROM sales_activities LIMIT ${offset},${config.listPerPage}`;
    const [rows, fields] = await pool.query.execute(sql);

    const data = helper.emptyOrRows(rows);
    const meta = { page };

    return {
        data,
        meta
    }
}

async function create(record) {
    const sql = `INSERT INTO sales_activities (drawid, memberid, sales, commissions) 
                VALUES (${record.drawid}, ${record.memberid}, ${record.sales}, ${record.commissions})`;
    const result = await pool.query.execute(sql);

    let message = 'Error in creating record';

    if (result.affectedRows) {
        message = 'Record created successfully';
    }

    return { message };
}

async function update(id, record) {
    const sql = `UPDATE sales_activities SET drawid = ${record.drawid}, memberid = ${record.memberid}, sales = ${record.sales}, commissions = ${record.commissions} WHERE id = ${id}`;
    const result = await pool.query.execute(sql);

    let message = 'Error in updating record';

    if (result.affectedRows) {
        message = 'Record updated successfully';
    }

    return { message };
}

async function remove(id) {
    const sql = `DELETE FROM sales_activities WHERE id = ${id}`;
    const result = await pool.query.execute(sql);

    let message = 'Error in deleting record';

    if (result.affectedRows) {
        message = 'Record deleted successfully';
    }

    return { message };
}

async function search(id) {
    const rows = await pool.callSpSearch(id, 'sp_search_sales_activity_by_id');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

// ===== Tickets Payments =====
async function payTickets(field1, field2, field3, field4) {
    const rows = await pool.callSpPayTickets(field1, field2, field3, field4, 'sp_tickets_payment');
    const result = helper.emptyOrRows(rows);

    let message = 'Error in creating record';

    if (result.affectedRows) {
        message = 'Record created successfully';
    }

    return { message };
}

async function getRemittances() {
    const rows = await pool.callSpFetchRemittances('sp_fetch_remittances');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function getCurrentRemittance() {
    const rows = await pool.callSpFetchCurrentRemittance('sp_fetch_unpaid_remittance');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function addRemittance() {
    const rows = await pool.callSpAddRemittance('sp_add_remittance');
    const result = helper.emptyOrRows(rows);

    let message = 'Error in updating record';

    if (result[0][0].affectedRows) {
        message = 'Record updated successfully';
    }

    return { message };
}

module.exports = {
    getMultiple,
    create,
    update,
    remove,
    search,

    payTickets,
    getRemittances,
    getCurrentRemittance,
    addRemittance
}