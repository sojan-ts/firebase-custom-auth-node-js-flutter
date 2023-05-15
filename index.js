const admin = require('firebase-admin');
const serviceAccount = require('./keys/skilink-d54d9-firebase-adminsdk-g1t4y-13e5d544d0.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const uid = '9895644945sojantsuid';
const isPremiumAccount = true;

admin.auth().createCustomToken(uid, { premium_account: isPremiumAccount })
  .then(customToken => {
    console.log(customToken);
  })
  .catch(error => {
    console.error('Error creating custom token:', error);
  });
