//
//  ViewController.swift
//  Cryptotest
//
//  Created by 中江洋史 on 2017/01/07.
//  Copyright © 2017年 中江洋史. All rights reserved.
//
import CryptoSwift
import UIKit

class ViewController: UIViewController {
    
    var text:NSData!
    let key = [UInt8]("12345678901234567890123456789012".utf8)
    let fileName = "file.db"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.decrypt()
        self.encrypt()
    }
    
    func encrypt() -> Void {
        var opneData:NSData!

        if let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            let targetFilePath = documentDirectoryFileURL.appendingPathComponent(fileName)
            do {
                opneData = try NSData(contentsOf: targetFilePath, options:[])
            } catch {
                print(error)
            }
        }

        var aBuffer = Array<UInt8>(repeating: 0, count: opneData.length)
        opneData.getBytes(&aBuffer, length: opneData.length)
        
        do {
            let encrypted = try AES(key: key, blockMode: .CBC).encrypt(aBuffer)
            let outData:NSData = NSData.init(bytes: encrypted, length: encrypted.count)
            // ドキュメントパス
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            // ファイル名
            let fileName = self.fileName
            // 保存する場所
            let filePath = documentsPath + "/" + fileName
            
            // 保存処理
            do {
                try outData.write(toFile: filePath, options: [])
            } catch {
                print(error)
            }
            
        } catch {
            print(error)
        }
    }
    
    func decrypt() -> Void {
        var opneData:NSData!
        
        if let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            let targetFilePath = documentDirectoryFileURL.appendingPathComponent(fileName)
            do {
                opneData = try NSData(contentsOf: targetFilePath, options:[])
            } catch {
                print(error)
            }
        }

        do {
            var aBuffer = Array<UInt8>(repeating: 0, count: opneData.length)
            opneData.getBytes(&aBuffer, length: opneData.length)
            let decrypted = try AES(key: key, blockMode: .CBC).decrypt(aBuffer)
            
            let outData:NSData = NSData.init(bytes: decrypted, length: decrypted.count)
            
            // ドキュメントパス
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String

            // ファイル名
            let fileName = self.fileName
            // 保存する場所
            let filePath = documentsPath + "/" + fileName
            
            // 保存処理
            do {
                try outData.write(toFile: filePath, options: [])
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
