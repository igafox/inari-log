# 稲荷ログ(途中)
[![DeployDev](https://github.com/igafox/inari-log/actions/workflows/deploy_dev.yml/badge.svg)](https://github.com/igafox/inari-log/actions/workflows/deploy_dev.yml)

稲荷神社の参拝ログを管理するSNSサイト  
https://dev.inarilog.app (プレビュー版)

## 構成
・FlutterWeb  
・FirebaseFirestore  
・FirebaseHosting  
・GitHubActions(自動Hosting反映)  


## アーキテクチャ
MVVM+Repositoryパターン(RiverPod + RiverHook)

## 実行
```
flutter run -d chrome
```
