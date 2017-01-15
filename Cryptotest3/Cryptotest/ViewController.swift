//
//  ViewController.swift
//  Cryptotest
//
//  Created by 中江洋史 on 2017/01/07.
//  Copyright © 2017年 中江洋史. All rights reserved.
//
import CryptoSwift
import UIKit

//Alamofire.request("https://my-wordpress-nakaex.c9users.io/wp-webapp/index.php/" + urlstring).responseJSON(completionHandler: { response in
//    //            print(response.request)  // original URL request
//    //            print(response.response) // HTTP URL response
//    //            print(response.data)     // server data
//    //            print(response.result)   // result of response serialization
//    
//    switch response.result {
//    case .success(let value):
//        self.success(value as AnyObject)
//        
//    case .failure(let error):
//        self.failure(error as AnyObject)
//    }
//})

//let delayTime = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
//DispatchQueue.main.asyncAfter(deadline: delayTime) {

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
