const pool = require('../database/mysql.db');
const helper = require('../database/helper');
const config = require('config');

async function getMultiple(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const sql = `SELECT * FROM grades LIMIT ${offset},${config.listPerPage}`;
    const [rows, fields] = await pool.query.execute(sql);

    const data = helper.emptyOrRows(rows);
    const meta = { page };

    return {
        data,
        meta
    }
}

async function create(record) {
    const sql = `INSERT INTO grades (title) VALUES ("${record.title}")`;
    const result = await pool.query.execute(sql);

    let message = 'Error in creating record';

    if (result.affectedRows) {
        message = 'Record created successfully';
    }

    return { message };
}

async function update(id, record) {
    const sql = `UPDATE grades SET title = "${record.title}" WHERE id = ${id}`;
    const result = await pool.query.execute(sql);

    let message = 'Error in updating record';

    if (result.affectedRows) {
        message = 'Record updated successfully';
    }

    return { message };
}

async function remove(id) {
    const sql = `DELETE FROM grades WHERE id = ${id}`;
    const result = await pool.query.execute(sql);

    let message = 'Error in deleting record';

    if (result.affectedRows) {
        message = 'Record deleted successfully';
    }

    return { message };
}

async function search(id) {
    const rows = await pool.callSpSearch(id, 'sp_search_grade_by_id');
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