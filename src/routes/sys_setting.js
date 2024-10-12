const express = require('express');
const router = express.Router();
const sys_settings = require('../services/sys_setting');

/* GET System Settings */
router.get('/', async function (req, res, next) {
    try {
        res.json(await sys_settings.getMultiple(req.query.page));
    } catch (err) {
        console.error(`Error while getting sys_settings `, err.message);
        next(err);
    }
});

/* POST System Setting */
router.post('/', async function (req, res, next) {
    try {
        res.json(await sys_settings.create(req.body));
    } catch (err) {
        console.error(`Error while creating sys_setting`, err.message);
        next(err);
    }
});

/* PUT System Setting */
router.put('/:id', async function (req, res, next) {
    try {
        res.json(await sys_settings.update(req.params.id, req.body));
    } catch (err) {
        console.error(`Error while updating sys_setting`, err.message);
        next(err);
    }
});

/* DELETE System Setting */
router.delete('/:id', async function (req, res, next) {
    try {
        res.json(await sys_settings.remove(req.params.id));
    } catch (err) {
        console.error(`Error while deleting sys_setting`, err.message);
        next(err);
    }
});

/* FIND System Setting */
router.get('/:id', async function (req, res, next) {
    try {
        res.json(await sys_settings.search(req.params.id));
    } catch (err) {
        console.error(`Error while searching sys_setting `, err.message);
        next(err);
    }
});

module.exports = router;