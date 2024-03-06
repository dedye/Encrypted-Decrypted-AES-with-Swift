//
//  ViewController.swift
//  decryptGetconfig
//
//  Created by Dedye Irawan on 06/02/24.
//

import UIKit
import CryptoSwift

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let data = try decrypt(cipherText: "RuFQrOMRSDymJ5N9akavvLBYI2G5UEOBz2rK1sdVl+u1VumCAC399/de000K9zxz", aesKey: "72a775b42904ed89ca137de37e0c435f47f58f8ecc706b8e1831eed7dc6e398f|fe238a5b-8439-449d-ab61-67e79f55f976")
            print("data Decrypt : \(data)")
        } catch {
            print("Error : \(error)")
        }
    }
    
    func decrypt(cipherText: String, aesKey: String) throws -> String {
        print("[EncryptionService] ✅ Decryption called")
        do {
            print("Ciphertext: \(cipherText)")
            print("aesKey: \(aesKey)")
            
            
            let inputBytes: [UInt8] = Array(aesKey.bytes)
            let sha256Data = Hash.sha256(inputBytes)
            
            let aes = try AES(key: sha256Data, blockMode: ECB())
            
            print("AES Key size: \(aes.keySize)")
            
            let textData : Data = Data(base64Encoded: cipherText)!
            let decryptedText =  try aes.decrypt(textData.bytes)
            
            return String(bytes: decryptedText, encoding: .utf8) ?? "Could not decrypt"
        }
    }
}
