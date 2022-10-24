const AWS = require('aws-sdk');
AWS.config.update({ region: process.env.REGION });
const s3 = new AWS.S3({region: 'us-east-1', signatureVersion: 'v4'});

exports.handler = async (event) => {
    return(FileType(event));
};

const FileType = async function(event, req, res) {
    console.log(event.detail.object.key);
    let Key = event.detail.object.key;
    // Get File Content-Type
    let params = {
        Bucket: 'ms-serverless-upload-bucket',
        Key: `${Key}`
    };
    console.log(params);
    const metaData = await s3.headObject(params).promise();
    let type = metaData.ContentType.split("/")[0];
    console.log(type);
    return ({"FileName": Key , "Type": type});
};