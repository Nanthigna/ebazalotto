const express = require('express');
const router = express.Router();
const roles = require('../services/role');

/* GET Roles */
router.get('/', async function (req, res, next) {
    try {
        res.json(await roles.getMultiple(req.query.page));
    } catch (err) {
        console.error(`Error while getting roles `, err.message);
        next(err);
    }
});

/* POST Role */
router.post('/', async function (req, res, next) {
    try {
        res.json(await roles.create(req.body));
    } catch (err) {
        console.error(`Error while creating role`, err.message);
        next(err);
    }
});

/* PUT Role */
router.put('/:id', async function (req, res, next) {
    try {
        res.json(await roles.update(req.params.id, req.body));
    } catch (err) {
        console.error(`Error while updating role`, err.message);
        next(err);
    }
});

/* DELETE Role */
router.delete('/:id', async function (req, res, next) {
    try {
        res.json(await roles.remove(req.params.id));
    } catch (err) {
        console.error(`Error while deleting role`, err.message);
        next(err);
    }
});

/* FIND Role */
router.get('/:id', async function (req, res, next) {
    try {
        res.json(await roles.search(req.params.id));
    } catch (err) {
        console.error(`Error while searching role `, err.message);
        next(err);
    }
});

module.exports = router;