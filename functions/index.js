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
app.all('/*', basicAuth(function (user, password) {
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
    if(fileName.startsWith("icon")) {
      await spawn('convert', [tempFilePath, '-thumbnail', '400x400^','-gravity', 'center','-extent', '400x400^' ,tempFilePath]); 
    }
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


// const xss = require('xss')

exports.returnHtmlWithOGP = functions.https.onRequest((req, res) => {
  // // Optional
  // res.set('Cache-Control', 'public, max-age=300, s-maxage=600')
  // // Access URL '/user/{userId}'
  // const userAgent = req.headers['user-agent'].toLowerCase()
  // const path = req.params[0].split('/')
  // const id = path[path.length - 1]

  // const isBot = userAgent.includes('googlebot') ||
  //   userAgent.includes('yahoou') ||
  //   userAgent.includes('bingbot') ||
  //   userAgent.includes('baiduspider') ||
  //   userAgent.includes('yandex') ||
  //   userAgent.includes('yeti') ||
  //   userAgent.includes('yodaobot') ||
  //   userAgent.includes('gigabot') ||
  //   userAgent.includes('ia_archiver') ||
  //   userAgent.includes('facebookexternalhit') ||
  //   userAgent.includes('twitterbot') ||
  //   userAgent.includes('developers\.google\.com') ? true : false

  // if (!isBot) {
  //   res.status(200).send(indexHTML)
  // }

  // if (isBot) {
  //   const firestore = admin.firestore()
  //   const data = await firestore.collection("post").doc(id).get();
  //   const post = data.data()



  //     .then((snapshot) => {

  //       const user = snapshot.data()
  //       const title = xss(user.name)
  //       let description = xss(user.short_description)
  //       indexHTML
  //         .replace(/\<title>.*<\/title>/g, '<title>' + title + '</title>')
  //         .replace(/<\s*meta name="description" content="[^>]*>/g, '<meta name="description" content="' + description + '" />')
  //         .replace(/<\s*meta property="og:title" content="[^>]*>/g, '<meta property="og:title" content="' + title + '" />')
  //         .replace(/<\s*meta property="og:url" content="[^>]*>/g, '<meta property="og:url" content="' + domain + '" />')
  //         .replace(/<\s*meta property="og:description" content="[^>]*>/g, '<meta property="og:description" content="' + description + '" />')


  //       res.status(200).send(indexHTML)
  //     })
  //     .catch(err => {
  //       res.status(404).send(indexHTML)
  //     })
  // }

  const SITEURL = "https://dev.inarilog.app"
  const TITLE = "正一位竹駒稲荷大明神|稲荷ログ"
  const DESCRIPTION = "道の駅天栄の近くにある正一位竹駒稲荷大明神"
  const IMAGE = "https://firebasestorage.googleapis.com/v0/b/oinari-log-dev.appspot.com/o/images%2Fpost%2FVhw70QAve9TWuyyrpyCgDmF9IhC3%2FTiYOvVy1brAFPEhUAZ0T%2FoTxL2GrJvjIlZWN.jpg?alt=media&token=8233c734-9063-4e92-9efd-09e3c774d8b8"

  res.status(200).send(`<!doctype html>
    <head>
      <title>Time</title>
      <meta property="og:title" content="${TITLE}">
      <meta property="og:image" content="${IMAGE}">
      <meta property="og:description" content="${DESCRIPTION}">
      <meta property="og:url" content="https://dev.inarilog.app/post/QIAuaQ0mmROoj8o0YeGx">
      <meta property="og:type" content="website">
      <meta property="og:site_name" content="${TITLE}">
      <meta name="twitter:site" content="〇〇〇〇〇〇">
      <meta name="twitter:card" content="summary_large_image">
      <meta name="twitter:title" content="${TITLE}">
      <meta name="twitter:image" content="${IMAGE}">
      <meta name="twitter:description" content="${DESCRIPTION}">
    </head>
    <body>
    <script type="text/javascript">window.location="https://dev.inarilog.app/post/QIAuaQ0mmROoj8o0YeGx";</script>
    </body>
  </html>`);
});  