const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
require('./database/mysql.db');

const urlencodedParser = bodyParser.urlencoded({ extended: false });
const app = express();
app.use(express.json());
app.set('view engine', 'ejs');

const NODE_ENV = 'production' //process.env.NODE_ENV || 'development';
const whitelist = ['http://localhost:3000', 'http://localhost:80', 'https://ebazas.com'];
const corsOptions = {
    origin: function (callback, origin = 'https://ebazas.com') {
        if (whitelist.indexOf(origin) !== -1) callback(null, true);
        else callback(new Error('Not allowed by CORS'));
    },
    methods: ['GET, POST'],
    allowedHeaders: ['Content-Type'],
};

app.use(NODE_ENV === 'development' ? cors() : cors(corsOptions));
app.get('/', (req, res) => res.json({ message: "OK" }));

app.get('/referral', function (req, res) {
    res.render("index");
});

app.get('/download', function (req, res) {
    res.render("app_download");
});

app.get('/form', function (req, res) {
    res.render("form", { data: req.query });
});

app.post('/form', urlencodedParser, function (req, res) {
    res.render("finish", { data: req.body });
});

app.use(express.static(__dirname + '/public'));

const apiRouterUser = require('./routes/user');
const apiRouterGrade = require('./routes/grade');
const apiRouterRole = require('./routes/role');
const apiRouterLottoDraw = require('./routes/lotto_draw');
const apiRouterMember = require('./routes/member');
const apiRouterMembership = require('./routes/membership');
const apiRouterMemberRevenue = require('./routes/member_revenue');
const apiRouterMemberProfile = require('./routes/member_profile');
const apiRouterTransaction = require('./routes/transaction');
const apiRouterSalesActivity = require('./routes/sales_activity');
const apiRouterSystemSetting = require('./routes/sys_setting');

/* Use middleware */
app.use("/user", apiRouterUser);
app.use("/grade", apiRouterGrade);
app.use("/role", apiRouterRole);
app.use("/lotto_draw", apiRouterLottoDraw);
app.use("/member", apiRouterMember);
app.use("/membership", apiRouterMembership);
app.use("/member_revenue", apiRouterMemberRevenue);
app.use("/member_profile", apiRouterMemberProfile);
app.use("/transaction", apiRouterTransaction);
app.use("/sales_activity", apiRouterSalesActivity);
app.use("/sys_setting", apiRouterSystemSetting);

/* Error handler middleware */
app.use((err, req, res, next) => {
    const statusCode = err.statusCode || 500;
    console.error(err.message, err.stack);
    res.status(statusCode).json({ message: err.message });
    return;
});

module.exports = app;