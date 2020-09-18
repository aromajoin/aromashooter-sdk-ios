[English](https://github.com/aromajoin/controller-sdk-ios) / [日本語](README-JP.md)

# ControllerSDK - iOS版

[![License](https://img.shields.io/badge/license-Apache%202-4EB1BA.svg?style=flat-square)](https://www.apache.org/licenses/LICENSE-2.0.html)

**[Aroma Shooter](https://aromajoin.com/products/aroma-shooter)との通信に使用されるAromaShooterController SDKのiOS版です。**  

# 目次
1. [対応デバイス](#対応デバイス)
2. [前提条件](#前提条件)
3. [インストール](#インストール)
4. [使用法](#使用法)
    * [デバイスの接続](#デバイスの接続切断)
    * [接続されたデバイス](#接続されたデバイス)
    * [香りを噴射する](#香りを噴射する)
    * [噴射を止める](#噴射を止める)
5. [ライセンス](#ライセンス)

## 対応デバイス
* Aroma Shooter Bluetoothタイプ

## 前提条件
* iOS版: >= 8.0
* Swift版: >= 3.0

## インストール  
* [リリースページのフレームワークファイル](https://github.com/aromajoin/controller-sdk-ios/releases)をダウンロードする。
* プロジェクトにドラッグ＆ドロップします。 （プロジェクトのターゲットページの*Embedded Binariesセクション*に追加されていることを確認してください）。

このプロセスの[デモビデオ](https://youtu.be/MepAhofA9PE)をご覧ください。

## 使用法

### Controllerリファレンスを取得する
* Controllerモジュールのインポート
```swift
import AromaShooterControlerSwift
```
* Controllerクラスのリファレンスを取得する
```swift
var controller = AromaShooterController.sharedInstance
```

### デバイスの接続・切断
接続UI部分が完成しました。2つの方法のいずれかによって、接続ビューコントローラを簡単に開くことができます。
`NavigationController`を使用している場合は、これらのコードを使用してください。
```swift
let connectionVC = controller.getConnectionViewController()
if let connectionVC = connectionVC {
  self.navigationController?.pushViewController(connectionVC, animated: true)
}
```
それ以外の場合は、以下のコードを使用してください。
```swift
let connectionVC = controller.getConnectionViewController()
if let connectionVC = connectionVC {
  self.present(connectionVC, animated: true, completion: nil)
}
```

### 接続されたデバイス
```swift
let connectedDevices = controller.connectedDevices
```  
### 香りを噴射する
* 接続されているすべてのデバイスに香りを噴射する。
```swift
/**
 * @param duration     噴射持続時間（ミリ秒）。
 * @param booster      ブースターが使用されているかどうかを判定する。(true: より強く噴射する, false: より弱く噴射する)
 * @param ports        カートリッジ番号を噴射する。値：1 ~ 6.
 */
controller.diffuseAll(duration: 3000, booster: true, ports: [1, 2, 3])
```  
* 特定のデバイスに香りを噴射する。
```swift
controller.diffuse(aromaShooters: devices, duration: 3000, booster: true, port: [1, 2, 3])
```  

* AS2（Aroma Shooter 2）デバイスのみのディフューザー香りメソッド
```swift
controller.diffuseAll(durationInMilli: 1000, boosterIntensity: 0, fanIntensity: 50, ports: [CartridgePort(number: 3, intensityPercent: 100)])

controller.diffuse(aromaShooters: controller.connectedDevices, durationInMilli: 1000, boosterIntensity: 50, fanIntensity: 40, ports: [CartridgePort(number: 3, intensityPercent: 100)])
``` 

### 噴射を止める
噴射している場合は、接続されているデバイスのすべてのポートを停止します。
```swift
constroller.stopAll()
```

**詳細については、このリポジトリをチェックアウトし、
[サンプルプロジェクト](https://github.com/aromajoin/controller-sdk-ios/tree/master/sample)を参照してください。**  
**問題が発生したり、新機能が必要な場合は、[新しい問題](https://github.com/aromajoin/controller-sdk-ios/issues)を作成してください。**

## ライセンス
[こちら](https://github.com/aromajoin/controller-sdk-ios/blob/master/LICENSE.md)を参照してください。
