const express = require('express');
const router = express.Router();
const memberships = require('../services/membership');

/* GET Memberships */
router.get('/', async function (req, res, next) {
    try {
        res.json(await memberships.getMultiple(req.query.page));
    } catch (err) {
        console.error(`Error while getting memberships `, err.message);
        next(err);
    }
});

/* POST Membership */
router.post('/', async function (req, res, next) {
    try {
        res.json(await memberships.create(req.body));
    } catch (err) {
        console.error(`Error while creating membership`, err.message);
        next(err);
    }
});

/* PUT Membership */
router.put('/:id', async function (req, res, next) {
    try {
        res.json(await memberships.update(req.params.id, req.body));
    } catch (err) {
        console.error(`Error while updating membership`, err.message);
        next(err);
    }
});

/* DELETE Membership */
router.delete('/:id', async function (req, res, next) {
    try {
        res.json(await memberships.remove(req.params.id));
    } catch (err) {
        console.error(`Error while deleting membership`, err.message);
        next(err);
    }
});

/* FIND Membership */
router.get('/:id', async function (req, res, next) {
    try {
        res.json(await memberships.search(req.params.id));
    } catch (err) {
        console.error(`Error while searching membership `, err.message);
        next(err);
    }
});

module.exports = router;