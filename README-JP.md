[English](https://github.com/aromajoin/controller-sdk-ios) / [日本語](README-JP.md)

# ControllerSDK - iOS版

[![License](https://img.shields.io/badge/license-Apache%202-4EB1BA.svg?style=flat-square)](https://www.apache.org/licenses/LICENSE-2.0.html)

**[Aroma Shooter](https://aromajoin.com/hardware/shooters/aroma-shooter-1)との通信に使用されるAromaShooterController SDKのiOS版です。**  

# 目次
1. [対応デバイス](#対応デバイス)
2. [前提条件](#前提条件)
3. [インストール](#インストール)
4. [使用法](#使用法)
    * [デバイスの接続](#デバイス接続)
    * [接続されたデバイス](#接続されたデバイス)
    * [香りを噴射する](#香りを噴射する)
5. [ライセンス](#ライセンス)

## 対応デバイス
* Aroma Shooter Bluetoothタイプ

## 前提条件
* iOS版: >= 8.0
* Swift版: >= 3.0

## インストール  
* [リリースページのフレームワークファイル](https://github.com/aromajoin/controller-sdk-ios/releases)をダウンロードする。
* プロジェクトにドラッグしてドロップします。 （プロジェクトのターゲットページの*Embedded Binariesセクション*に追加されていることを確認してください）。

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

### デバイスの接続  
選択が二つございます。
* `sample`アプリケーションの内部にある既存の接続画面（ConnectionViewController）を使用してください。 これは簡単で推奨です。
   * このリポジトリをチェックして、プロジェクトに入れるために `ConnectionViewController.swift`ファイルを取得してください。
   * 詳細については、`sample`アプリケーションを見てください。  
* APIを使って独自の接続画面を作成してください。
   * AromaShooterデバイスをスキャンする
   ```swift
   controller.startScanning()
   ```  
   * ビューコントローラが消えるとスキャンが停止することを確認してください。
   ```swift
    override func viewWillDisappear(_ animated: Bool) {
        // Stop searching
        controller.stopScanning()
    }
   ```  
   * 接続する
   ```swift
   controller.connect(aromaShooters: devices)
   ```  
   * 切断する
   ```swift
   controller.disconnect(aromaShooter: device)
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
* 特定のデバイスに香りを拡散する。
```swift
controller.diffuse(aromaShooters: devices, duration: 3000, booster: true, port: [1, 2, 3])
```  

**詳細については、このリポジトリをチェックアウトし、
[サンプルプロジェクト](https://github.com/aromajoin/controller-sdk-ios/tree/master/sample)を参照してください。**  
**問題が発生したり、新機能が必要な場合は、[新しい問題](https://github.com/aromajoin/controller-sdk-ios/issues)を作成してください。**

## ライセンス
[こちら](https://github.com/aromajoin/controller-sdk-ios/blob/master/LICENSE.md)を参照してください。
