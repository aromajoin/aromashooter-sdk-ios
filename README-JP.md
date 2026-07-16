[English](https://github.com/aromajoin/aromashooter-sdk-ios) / [日本語](README-JP.md)

# Aroma Shooter SDK (iOS)

[![Version](https://img.shields.io/badge/version-2.0.0-blue.svg?style=flat-square)](https://github.com/aromajoin/aromashooter-sdk-ios/releases)
[![License](https://img.shields.io/badge/license-Apache%202-4EB1BA.svg?style=flat-square)](https://www.apache.org/licenses/LICENSE-2.0.html) 
[![Join the community on Spectrum](https://withspectrum.github.io/badge/badge.svg)](https://spectrum.chat/aromajoin-software/)

**[Aroma Shooter](https://aromajoin.com/products/aroma-shooter)との通信に使用されるAromaShooterController SDKのiOS版です。**  

> **v2.0.0は破壊的変更を含むリリースです。** `diffuse*` メソッドは `shoot*` に、モデル `CartridgePort` は `AromaChamber`（`intensityPercent` → `concentration`）に、`booster`/`fan` パラメータは `internalBooster`/`externalBooster` に名称変更されました。

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
* iOS版: >= 12.0
* Swift版: >= 5.0

## インストール  
* [リリースページの `AromaShooterSwiftSDK.xcframework`](https://github.com/aromajoin/aromashooter-sdk-ios/releases)をダウンロードする。
* プロジェクトにドラッグ＆ドロップし、ターゲットの*General → Frameworks, Libraries, and Embedded Content*で**Embed & Sign**に設定してください。

このプロセスの[デモビデオ](https://youtu.be/MepAhofA9PE)をご覧ください。

## 使用法

### Bluetoothの使用法の説明を`Info.plist`ファイルに追加する
iOS 13以降では、Bluetoothの使用法の説明を追加する必要があります。追加しない場合、アプリがクラッシュします。
キーとその値をアプリの `Info.plist`ファイルに追加してください。
```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>The app uses Bluetooth to connect to Aroma Shooter</string>
```

また、XCode 12.3で「TargetIntegrity」を取得した場合は、ソリューション[こちら](https://github.com/aromajoin/aromashooter-sdk-ios/issues/5)を確認してください。

### Controllerリファレンスを取得する
* Controllerモジュールのインポート
```swift
import AromaShooterSwiftSDK
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

#### 手動接続（カスタムUI）
組み込みの接続画面の代わりに独自のデバイス一覧を作る場合は、スキャン・接続を直接呼び出し、結果を `AromaShooterDelegate` で受け取ります。
```swift
class MyManager: AromaShooterDelegate {
  let controller = AromaShooterController.sharedInstance

  init() { controller.delegate = self }

  func startDiscovery() { controller.startScanning() }
  func stopDiscovery()  { controller.stopScanning() }

  // AromaShooterDelegate
  func aromaShooter(didDiscoverDevice device: AromaShooter) { /* 一覧に追加 */ }
  func aromaShooter(didConnectDevice device: AromaShooter) { /* UI更新 */ }
  func aromaShooter(didDisconnectDevice device: AromaShooter) { /* UI更新 */ }
}

// 発見したデバイスの接続 / 切断
controller.connect(aromaShooters: [device])
controller.disconnect(aromaShooter: device)
```

### 接続されたデバイス
```swift
let connectedDevices = controller.connectedDevices
```  
### 香りを噴射する
> **注意:** 香りが出るには内部ブースターを有効にする必要があります — `internalBooster: true`（シンプル）または `internalBoosterIntensity > 0`（強度指定）を指定してください。オフの場合は何も噴射されません。外部ブースター（`externalBoosterIntensity`、旧「fan」）はAS3のみに存在します。

**シンプルモード（AS1 / AS2）** — チャンバーのオン/オフのみ、強度指定なし:
```swift
/**
 * @param duration        噴射持続時間（ミリ秒）。
 * @param internalBooster 内部ブースターを有効にするかどうか。(true: より強く噴射する, false: より弱く噴射する)
 * @param chambers        噴射するチャンバー番号。値：1 ~ 6.
 */
// 接続中の全デバイス・複数チャンバー
controller.shootAllSimple(duration: 3000, internalBooster: true, chambers: [1, 2, 3])

// 特定のデバイス・複数チャンバー
controller.shootSimple(aromaShooters: devices, duration: 3000, internalBooster: true, chambers: [1, 2, 3])

// 単一チャンバー（1台または複数台）
controller.shootSimple(aromaShooter: device, duration: 3000, internalBooster: true, chamber: 1)
controller.shootSimple(aromaShooters: devices, duration: 3000, internalBooster: true, chamber: 1)

// 1台・複数チャンバー
controller.shootSimple(aromaShooter: device, duration: 3000, internalBooster: true, chambers: [1, 2])
```

**強度指定モード（AS2 / AS3）** — チャンバーごとの濃度 + 内部/外部ブースター（外部ブースターはAS3のみ）:
```swift
// 接続中の全デバイス
controller.shootAllWithIntensity(durationInMilli: 1000, internalBoosterIntensity: 50, externalBoosterIntensity: 50, chambers: [AromaChamber(number: 3, concentration: 100)])

// 特定のデバイス
controller.shootWithIntensity(aromaShooters: controller.connectedDevices, durationInMilli: 1000, internalBoosterIntensity: 50, externalBoosterIntensity: 40, chambers: [AromaChamber(number: 3, concentration: 100)])
```

### 噴射を止める
噴射中のデバイスの全チャンバーを停止します。
```swift
// シンプルモード — 全デバイス / 特定デバイス
controller.stopAllSimple()
controller.stopSimple(aromaShooter: device)

// 強度指定モード（AS2 / AS3）— 全デバイス / 特定デバイス
controller.stopAllWithIntensity()
controller.stopWithIntensity(aromaShooter: device)
```

**詳細については、このリポジトリをチェックアウトし、
[サンプルプロジェクト](https://github.com/aromajoin/aromashooter-sdk-ios/tree/master/sample)を参照してください。**  
**問題が発生したり、新機能が必要な場合は、[新しい問題](https://github.com/aromajoin/aromashooter-sdk-ios/issues)を作成してください。**

## ライセンス
[こちら](https://github.com/aromajoin/aromashooter-sdk-ios/blob/master/LICENSE.md)を参照してください。
