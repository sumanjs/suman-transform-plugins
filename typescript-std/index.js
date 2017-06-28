const fs = require('fs');

exports.getTransformStream = function () {
  return fs.createReadStream(__dirname + '/index.sh');
};