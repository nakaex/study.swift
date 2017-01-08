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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 作成するテキストファイルの名前
        let textFileName = "test.db"
        
        
        // DocumentディレクトリのfileURLを取得
        if let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            
            // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
            let targetTextFilePath = documentDirectoryFileURL.appendingPathComponent(textFileName)

            do {
                self.text = try Data(contentsOf: targetTextFilePath, options:[])

                print(self.text.base64EncodedString())
            } catch {
                //エラー処理
                print(error)
            }
        }

        let text: String = self.text.base64EncodedString() //"Hello World!!diojqcoiqcoiqoijweqoijOIJOああああiiiii"
        //エンコード
        let data = text.data(using: String.Encoding.utf8)
        let base64Str:String = (data?.base64EncodedString(options: Data.Base64EncodingOptions()))!
        let input = [UInt8](base64Str.utf8)
        let key = [UInt8]("12345678901234567890123456789012".utf8)
        let iv: Array<UInt8> = AES.randomIV(AES.blockSize)
        
        do {
            let encrypted = try AES(key: key, iv: iv, blockMode: .CBC, padding: PKCS7()).encrypt(input)
            print(encrypted)
            print(encrypted.toHexString())
            let encryptBase64:String = encrypted.toHexString()
            print(encryptBase64)
            
            let inputa = [UInt8](encryptBase64.utf8)
            print(inputa)
            
            let encrypted2 = hexStringToUInt8(str: encryptBase64)

            
            let decrypted = try AES(key: key, iv: iv, blockMode: .CBC, padding: PKCS7()).decrypt(encrypted2)
            let result = convertUInt8ToUTF(bytes: decrypted)
            let base64Text = result
            let decodedData = NSData(base64Encoded: base64Text, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
            if let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue) {
                print(decodedString)
            }
            
            // ドキュメントパス
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            // 保存するもの
            let fileObject = encryptBase64
            // ファイル名
            let fileName = "file.txt"
            // 保存する場所
            let filePath = documentsPath + fileName
            
            // 保存処理
            do {
                try fileObject.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                // Failed to write file
            }
            
        } catch {
            print(error)
        }
        

    }
    
    func encrypt(_ data:String) -> String? {
        let bytes = [UInt8](data.utf8)
        print(bytes)
        let key = [UInt8]("12345678901234567890123456789012".utf8)
        let iv:[UInt8] = AES.randomIV(AES.blockSize)
        
        print(iv)
        
        do {
            // AES-256-CBCインスタンスの生成
            let aes = try AES(key: key, iv: iv, blockMode: .CBC) //try AES(key: byteKey, iv: iv, blockMode: .CBC)
            
            let encrypted = try aes.encrypt(bytes)
            print(encrypted)
            let encryptedData = NSData(bytes:encrypted, length:encrypted.count)
            print(encryptedData)
            let sendData = NSMutableData(bytes: iv, length: iv.count)
                    print(iv)
            print(sendData)
            sendData.append(encryptedData as Data)
            let sendDataBase64 = sendData.base64EncodedString(options: NSData.Base64EncodingOptions())
            print(sendDataBase64)
            return sendDataBase64
        } catch {
            return nil
        }
    }
    
    func decrypt(_ encryptedString: String) -> String? {
        let key = [UInt8]("12345678901234567890123456789012".utf8)
        
        let ivRange = NSMakeRange(0, 16)
        let iv = hexStringToUInt8(str: encryptedString)
//        let iv:[UInt8] = AES.randomIV(AES.blockSize)
        
        let dataLength = encryptedString.characters.count - 16
        if dataLength < 0 {
            return nil
        }
        
        let dataRange = NSMakeRange(16, dataLength)
        let data = hexStringToUInt8(str: encryptedString)
        
        do {
            let aes = try AES(key: key, iv: iv, blockMode: .CBC)
            let decrypted = try aes.decrypt(data)
            let result = convertUInt8ToUTF(bytes: decrypted)
            return result
        } catch let error as NSError {
            debugPrint(error)
            return nil
        }
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

