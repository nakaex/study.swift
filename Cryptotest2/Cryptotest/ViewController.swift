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
    
    var text:Data!
    let key = [UInt8]("12345678901234567890123456789012".utf8)
    let fileName = "file.db"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // 作成するテキストファイルの名前
//        let textFileName = "test.db"
//
//        // DocumentディレクトリのfileURLを取得
//        if let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
//            
//            // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
//            let targetTextFilePath = documentDirectoryFileURL.appendingPathComponent(textFileName)
//            //print(documentDirectoryFileURL)
//            do {
//                self.text = try Data(contentsOf: targetTextFilePath, options:[])
//                //print(self.text.base64EncodedString())
//            } catch {
//                //エラー処理
//                print(error)
//            }
//        }
//
//        print(self.text)
//        let text: String = self.text.base64EncodedString() //"Hello World!!diojqcoiqcoiqoijweqoijOIJOああああiiiii"
//        
//        print(text)
//        //エンコード
//        let data = text.data(using: String.Encoding.utf8)
//        let base64Str:String = (data?.base64EncodedString(options: Data.Base64EncodingOptions()))!
//        let input = [UInt8](base64Str.utf8)
//        
//        do {
//            let encrypted = try AES(key: key, blockMode: .CBC).encrypt(input)
//            let encryptHex:String = encrypted.toHexString()
//            let hexEncrypted = hexStringToUInt8(str: encryptHex)
//            let decrypted = try AES(key: key, blockMode: .CBC).decrypt(hexEncrypted)
//            print(hexEncrypted)
//            let result = convertUInt8ToUTF(bytes: decrypted)
//            let base64Text = result
//            print(result)
//            let decodedData = NSData(base64Encoded: base64Text, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
//            if let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue) {
//                print(decodedString)
//            }
//            
//            // ドキュメントパス
//            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//            
//            print(documentsPath)
//            
//            // 保存するもの
//            let fileObject = encryptHex
//            print(fileObject)
//
//            // ファイル名
//            let fileName = self.fileName
//            // 保存する場所
//            let filePath = documentsPath + "/" + fileName
//            
//            // 保存処理
//            do {
//                try fileObject.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
//            } catch {
//                // Failed to write file
//            }
//            
//        } catch {
//            print(error)
//        }

        _ = self.decrypt("")
        _ = self.encrypt("")
    }
    func encrypt(_ data:String) -> String? {
        // DocumentディレクトリのfileURLを取得
        if let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
            let targetTextFilePath = documentDirectoryFileURL.appendingPathComponent(fileName)
            do {
                self.text = try Data(contentsOf: targetTextFilePath, options:[])
            } catch {
                //エラー処理
                print(error)
            }
        }

        let text: String = self.text.base64EncodedString()

        //エンコード
        let data = text.data(using: String.Encoding.utf8)
        let base64Str:String = (data?.base64EncodedString(options: Data.Base64EncodingOptions()))!
        let input = [UInt8](base64Str.utf8)
        
        do {
            let encrypted = try AES(key: key, blockMode: .CBC).encrypt(input)
            let encryptHex:String = encrypted.toHexString()

            // ドキュメントパス
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String

            // 保存するもの
            let fileObject = encryptHex

            // ファイル名
            let fileName = self.fileName
            // 保存する場所
            let filePath = documentsPath + "/" + fileName
            
            // 保存処理
            do {
                try fileObject.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print(error)
            }
            
        } catch {
            print(error)
        }
        
        return ""
    }
    
    func decrypt(_ encryptedString: String) -> String? {
        var encryptHex:String! = ""
        // DocumentディレクトリのfileURLを取得
        if let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
            let targetFilePath = documentDirectoryFileURL.appendingPathComponent(fileName)
            do {
                encryptHex = try String(contentsOf: targetFilePath, encoding: String.Encoding.utf8)
            } catch {
                print(error)
            }
        }

        do {
            let hexEncrypted = hexStringToUInt8(str: encryptHex!)
            let decrypted = try AES(key: key, blockMode: .CBC).decrypt(hexEncrypted)
            let base64Text = convertUInt8ToUTF(bytes: decrypted)
            let decodedData = NSData(base64Encoded: base64Text, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
            
            if let decodedString = String(data: decodedData! as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                // ドキュメントパス
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String

                // 保存するもの
                let fileObject:NSData = NSData(base64Encoded: decodedString, options: NSData.Base64DecodingOptions())!
                // 保存する場所
                let filePath = documentsPath + "/" + fileName

                // 保存処理
                do {
                    try fileObject.write(toFile: filePath, options: [])
                } catch {
                    // Failed to write file
                    print(error)
                }
            }
        } catch {
            print(error)
        }
        
        return ""
    }
    
    func convertUInt8ToUTF(bytes:[UInt8]) -> String {
        var ret = ""
        var decoder = UTF8()
        var generator = bytes.makeIterator()
        var finished = false
        
        repeat {
            let decodingResult = decoder.decode(&generator)
            switch decodingResult {
            case .scalarValue(let char):
                ret.append(char.description)
            case .emptyInput:
                finished = true
                /* ignore errors and unexpected values */
            case .error:
                finished = true
            }
        } while (!finished)
        
        return ret
    }
    
    func hexStringToUInt8(str:String) -> [UInt8] {
        let nsstr:NSString = str as NSString //(str as NSString).substring(with: range) as NSString
        let strLength = String(nsstr).characters.count
        var result:[UInt8] = []
        var i:Int = 0
        
        while i < strLength {
            let r = NSMakeRange(i, 2)
            let substr = nsstr.substring(with: r)
            result.append(UInt8(strtoul(substr, nil, 16)))
            i = i + 2
        }

        return result
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

