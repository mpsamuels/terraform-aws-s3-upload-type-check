const AWS = require('aws-sdk');
AWS.config.update({ region: process.env.REGION });
const s3 = new AWS.S3({region: '${region}', signatureVersion: 'v4'});

exports.handler = async (event) => {
    let Key = event.detail.object.key;
    
    // Get File Content-Type
    let params = {
        Bucket: '${bucket}',
        Key: `$${Key}`
    };
    const metaData = await s3.headObject(params).promise()
    const type = metaData.ContentType;

    //If  Content-Type = Image
    if (type.includes('image')) { 
      console.log('image');
      console.log(`$${Key}`);
      var AWS = require('aws-sdk');
  
      var stepfunctions = new AWS.StepFunctions();
  
      let params = {
        stateMachineArn: '${image_state_machine}',
        input: "{\"detail\" : { \"object\" : { \"key\" : \"" + Key + "\"}}}"
      };
      await stepfunctions.startExecution(params).promise();
    }

    //If  Content-Type = Video
    if (type.includes('video')) { 
      console.log('video');
      var AWS = require('aws-sdk');
  
      var stepfunctions = new AWS.StepFunctions();
  
      let params = {
        stateMachineArn: '${video_state_machine}',
        input: "{\"detail\" : { \"object\" : { \"key\" : \"" + Key + "\"}}}"
      };
      await stepfunctions.startExecution(params).promise();
    }
}