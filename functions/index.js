const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp()
const spawn = require('child-process-promise').spawn;
const path = require('path');
const os = require('os');
const fs = require('fs');
const { storage } = require('firebase-admin');

exports.generateThumbnail = functions.region("asia-northeast1").storage.object().onFinalize(async (object) => {

  
  const fileBucket = object.bucket; // The Storage bucket that contains the file.
  const filePath = object.name;
  const fileName = path.basename(filePath); // File path in the bucket.
  const contentType = object.contentType; // File content type.
  const metageneration = object.metageneration; // Number of times metadata has been generated. New objects have a value of 1.

  //画像のみリサイズ
  if (!contentType.startsWith('image/')) {
    return functions.logger.log('Skip:This is not an image.');
  }
  
  //オリジナル画像はリサイズしない
  if(fileName.endsWith('.orig')) {
        return functions.logger.log('Skip:This is original image.')
      }

  const fileMetadata = await admin.storage().bucket(fileBucket).file(filePath).getMetadata();
  functions.logger.log(fileMetadata[0]);
  const metadata = fileMetadata[0];
  const isConverted = metadata.metadata.isConverted;
  //変換済チェック
  if(isConverted) {
    return functions.logger.log('${file.name} is already converted.');
  }

  //画像を一時ダウンロード
  const bucket = admin.storage().bucket(fileBucket);
  const tempFilePath = path.join(os.tmpdir(), fileName);
  await bucket.file(filePath).download({destination: tempFilePath});
  functions.logger.log('Image downloaded locally to', tempFilePath);

  //オリジナル画像をバックアップ
  const backupFileName = `${fileName}.orig`
  const backupFilePath = path.join(path.dirname(filePath), backupFileName);
  await bucket.upload(tempFilePath, {
    destination: backupFilePath,
    metadata: { contentType: contentType },
  });
  functions.logger.log('complete upload backup image:${file.name}');
  
  //画像リサイズ
  await spawn('convert', [tempFilePath, '-thumbnail', '700x700>', tempFilePath]);
  functions.logger.log('complete image rezie:${file.name}');

  //リサイズ画像を上書き
  await bucket.upload(tempFilePath, {
    destination: filePath,
    metadata: { 
      contentType: contentType,
      metadata :{
        isConverted:true
      }
    },
  });
  functions.logger.log('complete upload resized image:${file.name}');
  
  // Once the thumbnail has been uploaded delete the local file to free up disk space.
  return fs.unlinkSync(tempFilePath);
  // [END thumbnailGeneration]
});
// [END generateThumbnail]
