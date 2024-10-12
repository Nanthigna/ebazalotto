const pool = require('../database/mysql.db');
const helper = require('../database/helper');
const config = require('config');

async function getMultiple(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const sql = `SELECT * FROM member_revenues LIMIT ${offset},${config.listPerPage}`;
    const [rows, fields] = await pool.query.execute(sql);

    const data = helper.emptyOrRows(rows);
    const meta = { page };

    return {
        data,
        meta
    }
}

async function create(record) {
    const sql = `INSERT INTO member_revenues (memberid, sales, royalties) VALUES (${record.memberid}, ${record.sales}, ${record.royalties})`;
    const result = await pool.query.execute(sql);

    let message = 'Error in creating record';

    if (result.affectedRows) {
        message = 'Record created successfully';
    }

    return { message };
}

async function update(id, record) {
    const sql = `UPDATE member_revenues SET memberid = ${record.memberid}, sales = ${record.sales}, royalties = ${record.royalties} WHERE id = ${id}`;
    const result = await pool.query.execute(sql);

    let message = 'Error in updating record';

    if (result.affectedRows) {
        message = 'Record updated successfully';
    }

    return { message };
}

async function remove(id) {
    const sql = `DELETE FROM member_revenues WHERE id = ${id}`;
    const result = await pool.query.execute(sql);

    let message = 'Error in deleting record';

    if (result.affectedRows) {
        message = 'Record deleted successfully';
    }

    return { message };
}

async function search(id) {
    const rows = await pool.callSpSearch(id, 'sp_search_member_revenue_by_id');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function getCurrentRevenues(filter1, filter2, filter3) {
    const rows = await pool.callSpFetchCurrentRevenues(filter1, filter2, filter3, 'sp_fetch_revenues_members');
    const data = helper.emptyOrRows(rows);

    const newData = [{
        "draw_date": data[0][0].draw_date,
        "sales_comm_perc": data[1][0].sales_comm_perc,
        "royalty_perlevel": data[1][0].royalty_perlevel,
        "deposits": data[1][0].deposits,
        "transfers_in": data[1][0].transfers_in,
        "transfers_out": data[1][0].transfers_out,
        "remittances": data[1][0].remittances,
        "withdrawals": data[1][0].withdrawals,
        "private_sales": {
            "recent": {
                "sales": data[0][0].recent_sales,
                "commissions": data[0][0].recent_commissions
            },
            "cumulative": {
                "sales": data[1][0].sales,
                "commissions": data[1][0].commissions
            },
        },
    }];

    newData[0]['team_sales_recent'] = data[2];
    newData[0]['team_sales_cumulative'] = data[3];
    data.shift();
    data[0] = newData;

    return {
        data
    }
}

async function getLineageRevenues(filter) {
    const rows = await pool.callSpFetchLineageRevenues(filter, 'sp_cte_members_rvn_cum_with_path');
    const data = helper.emptyOrRows(rows);

    // ===== METHOD 1 - With reduce function (popular but disrupts the order of array) =====
    /*const newData = data[0].reduce((acc, { id, membername, path, LEVEL, sales, royalty }) => {
        acc[id] = acc[id] || { id, membername, path, LEVEL, sales: 0, royalty: 0 };
        acc[id].sales += sales;
        acc[id].royalty += royalty;
        return acc;
    }, {});
    
    const transData = [...Object.values(newData)];
    const rvnConsol = [];
    transData.forEach((elem, index, array) => {
        rvnConsol.push(Object.assign({ 'No': index + 1 }, elem));
    });

    data[0] = rvnConsol;
    */

    // ===== METHOD 2 - Grouping and summing (to eliminate duplicate ids and membernames) temporary table on db server =====
    const newData = data[0];
    const transData = [...Object.values(newData)];
    const rvnConsol = [];
    transData.forEach((elem, index, array) => {
        rvnConsol.push(Object.assign({ 'No': index + 1 }, elem));
    });

    data[0] = rvnConsol;

    return {
        data
    }
}

async function getCurrentSysRevenues(filter1, filter2, filter3) {
    const rows = await pool.callSpFetchCurrentSysRevenues(filter1, filter2, filter3, 'sp_fetch_sys_revenues_members');
    const data = helper.emptyOrRows(rows);

    const newData = [{
        "draw_date": data[0][0].draw_date,
        "royalty_perlevel": data[1][0].royalty_perlevel,
    }];

    newData[0]['recent'] = data[0];
    newData[0]['cumulative'] = data[1];
    data.shift();
    data[0] = newData;

    return {
        data
    }
}

async function getLineageSysRevenues(filter) {
    const rows = await pool.callSpFetchLineageSysRevenues(filter, 'sp_cte_members_sys_rvn_cum_with_path');
    const data = helper.emptyOrRows(rows);

    var newData = data[0];

    const transData = [...Object.values(newData)];
    const rvnConsol = [];
    transData.forEach((elem, index, array) => {
        rvnConsol.push(Object.assign({ 'No': index + 1 }, elem));
    });

    data[0] = rvnConsol;

    return {
        data
    }
}

async function getBatchChartRevenues(filter1, filter2, filter3) {
    const rows = await pool.callSpFetchBatchChartRevenues(filter1, filter2, filter3, 'sp_fetch_batch_chart_revenues');
    const data = helper.emptyOrRows(rows);
    const newDataPkg = data.slice(0, -1);

    data[0] = newDataPkg;

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

    getCurrentRevenues,
    getLineageRevenues,
    getCurrentSysRevenues,
    getLineageSysRevenues,

    getBatchChartRevenues
}