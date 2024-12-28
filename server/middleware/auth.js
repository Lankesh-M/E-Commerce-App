const jwt  = require('jsonwebtoken');

const auth = async (req, res, next) => {
    try{
        const token = req.header('x-auth-token');

        if(!token) res.status(401).json( {'msg' : 'No auth token, Access Denied'});

        var isVerified = jwt.verify(token, 'passwordKey');

        if(!isVerified) return res.status(401).json( {'msg' : "Token Verificatino Failed, Authorization Denied"});

        req.user = isVerified.id;
        req.token = token;
        next();
    }catch (err) {
        res.status(500).json({error : err.message});
    }
};

module.exports = auth;