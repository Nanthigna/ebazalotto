const pool = require('../database/mysql.db');
const helper = require('../database/helper');
const config = require('config');

async function getMultiple(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const sql = `SELECT * FROM member_profiles LIMIT ${offset},${config.listPerPage}`;
    const [rows, fields] = await pool.query.execute(sql);

    const data = helper.emptyOrRows(rows);
    const meta = { page };

    return {
        data,
        meta
    }
}

async function create(record) {
    const sql = `INSERT INTO member_profiles (referrerid, memberid, recommendid, gradeid, firstName, firstNameE, lastName, lastNameE, email, phoneno, profile_image, password, geo_long, geo_lat, active, member_fee) 
                VALUES ("${record.referrerid}", ${record.memberid}, "${record.recommendid}", ${record.gradeid}, "${record.firstName}", "${record.firstNameE}", "${record.lastName}", "${record.lastNameE}", ${record.gender}, "${record.email}", "${record.phoneno}", "${record.profile_image}", "${record.password}", ${record.geo_long}, ${record.geo_lat}, ${record.active}, ${record.member_fee})`;
    const result = await pool.query.execute(sql);

    let message = 'Error in creating record';

    if (result.affectedRows) {
        message = 'Record created successfully';
    }

    return { message };
}

async function update(id, record) {
    const sql = `UPDATE member_profiles SET referrerid = "${record.referrerid}", memberid = ${record.memberid}, recommendid = "${record.recommendid}", gradeid = ${record.gradeid}, firstName = "${record.firstName}", firstNameE = "${record.firstNameE}", lastName = "${record.lastName}", lastNameE = "${record.lastNameE}", 
                gender = ${record.gender}, email = "${record.email}", phoneno = "${record.phoneno}", profile_image = "${record.profile_image}", password = "${record.password}", geo_long = ${record.geo_long}, geo_lat = ${record.geo_lat}, active = ${record.active}, member_fee = ${record.member_fee} WHERE id = ${id}`;
    const result = await pool.query.execute(sql);

    let message = 'Error in updating record';

    if (result.affectedRows) {
        message = 'Record updated successfully';
    }

    return { message };
}

async function remove(id) {
    const sql = `DELETE FROM member_profiles WHERE id = ${id}`;
    const result = await pool.query.execute(sql);

    let message = 'Error in deleting record';

    if (result.affectedRows) {
        message = 'Record deleted successfully';
    }

    return { message };
}

async function search(id) {
    const rows = await pool.callSpSearch(id, 'sp_search_member_profile_by_id');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function searchProfile(membername) {
    const rows = await pool.callSpSearchProfile(membername, 'sp_search_profile_by_membername');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function searchProfiles(membername) {
    const rows = await pool.callSpSearchProfiles(membername, 'sp_search_profiles');
    const data = helper.emptyOrRows(rows);
    return {
        data
    }
}

async function createMemberProfile(record) {
    const rows = await pool.callSpCreateMemberProfile(record, 'sp_create_member_profile');
    const result = helper.emptyOrRows(rows);

    let message = 'Error in creating record';

    if (result.affectedRows) {
        message = 'Record created successfully';
    }

    return { message };
}

async function updateMemberProfile(record) {
    const rows = await pool.callSpUpdateMemberProfile(record, 'sp_update_member_profile');
    const result = helper.emptyOrRows(rows);

    let message = 'Error in updating record';

    if (result.affectedRows > 0) {
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
    searchProfile,
    searchProfiles,
    createMemberProfile,
    updateMemberProfile
}