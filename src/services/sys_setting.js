const pool = require('../database/mysql.db');
const helper = require('../database/helper');
const config = require('config');

async function getMultiple(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const sql = `SELECT * 
                FROM sys_settings LIMIT ${offset},${config.listPerPage}`;
    const [rows, fields] = await pool.query.execute(sql);

    const data = helper.emptyOrRows(rows);
    const meta = { page };

    return {
        data,
        meta
    }
}

async function create(record) {
    const sql = `INSERT INTO sys_settings (nos_applied_levels, royalty_perlevel, sys_fee) 
                VALUES (${record.nos_applied_levels}, ${record.royalty_perlevel}, ${record.sys_fee})`;
    const result = await pool.query.execute(sql);

    let message = 'Error in creating record';

    if (result.affectedRows) {
        message = 'Record created successfully';
    }

    return { message };
}

async function update(id, record) {
    const sql = `UPDATE sys_settings SET nos_applied_levels = ${record.nos_applied_levels}, royalty_perlevel = ${record.royalty_perlevel}, sys_fee = ${record.sys_fee} WHERE id = ${id}`;
    const result = await pool.query.execute(sql);

    let message = 'Error in updating record';

    if (result.affectedRows) {
        message = 'Record updated successfully';
    }

    return { message };
}

async function remove(id) {
    const sql = `DELETE FROM sys_settings WHERE id = ${id}`;
    const result = await pool.query.execute(sql);

    let message = 'Error in deleting record';

    if (result.affectedRows) {
        message = 'Record deleted successfully';
    }

    return { message };
}

async function search(id) {
    const rows = await pool.callSpSearch(id, 'sp_search_sys_setting_by_id');
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
    search
}