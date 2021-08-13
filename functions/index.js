const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp()
const spawn = require('child-process-promise').spawn;
const path = require('path');
const os = require('os');
const fs = require('fs');
const { storage, firestore } = require('firebase-admin');

const express = require('express')
const basicAuth = require('basic-auth-connect')
const app = express()

//basic認証
app.all('/*', basicAuth(function(user, password) {
 return user === 'iga' && password === 'lioleus';
}));
//webディレクト設定
app.use(express.static(__dirname + '/web/'));
//全てのリクエストをindex.htmlへ
app.all('*', (req, res, next) => {
  res.sendFile(path.resolve(__dirname, 'web/index.html'));
})
exports.app = functions.region("us-central1").https.onRequest(app);

// exports.createUserData = functions.region("asia-northeast1").auth
//   .user()
//   .onCreate((user) => {
//     const userId = user.uid;
//     functions.logger.log('create user${userId};');
//   });

// exports.deleteUserData = functions.region("asia-northeast1").auth
//   .user()
//   .onDelete((user) => {
//     const userId = user.uid;
//     functions.logger.log('delete user${userId};');
//   });

// exports.deletePostImage = functions.region("asia-northeast1").firestore
//   .document('post/{postId}')
//   .onDelete((snap, context) => {
//     const deletedValue = snap.data();
//   });


exports.resizeImage = functions.region("asia-northeast1").storage
  .object()
  .onFinalize(async (object) => {
    const fileBucket = object.bucket;
    const filePath = object.name;
    const fileName = path.basename(filePath);
    const contentType = object.contentType;
    const metageneration = object.metageneration;

    //画像のみリサイズ
    if (!contentType.startsWith('image/')) {
      return functions.logger.log('Skip:This is not an image.');
    }

    //オリジナル画像はリサイズしない
    if (fileName.endsWith('.orig')) {
      return functions.logger.log('Skip:This is original image.')
    }

    const fileMetadata = await admin.storage().bucket(fileBucket).file(filePath).getMetadata();
    functions.logger.log(fileMetadata[0]);
    const metadata = fileMetadata[0];
    const isConverted = metadata.metadata.isConverted;
    //変換済チェック
    if (isConverted) {
      return functions.logger.log('${file.name} is already converted.');
    }

    //画像を一時ダウンロード
    const bucket = admin.storage().bucket(fileBucket);
    const tempFilePath = path.join(os.tmpdir(), fileName);
    await bucket.file(filePath).download({ destination: tempFilePath });
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
        metadata: {
          isConverted: true
        }
      },
    });
    functions.logger.log('complete upload resized image:${file.name}');

    return fs.unlinkSync(tempFilePath);
  });

