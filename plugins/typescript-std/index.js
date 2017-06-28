const fs = require('fs');
const path = require('path');

exports.getTransformStream = function () {
  return fs.createReadStream(__dirname + '/index.sh');
};

exports.getTransformPath = function(){
  return path.resolve(__dirname + '/index.sh');
};