/// <#Brief Description#>
///
/// Created by TWINB00591630 on 2024/7/6.
/// Copyright © 2024 Cathay United Bank. All rights reserved.

import CryptoSwift
import Foundation

extension String {
    var doubleValue: Double? {
        Double(self)
    }
}

// MARK: - 加密
// AES

extension String {
    static let aesKey: [UInt8] = [0xC2, 0x93, 0x81, 0x40, 0xAD, 0x6C, 0x13, 0xE8, 0xA1, 0x81, 0x35, 0x7E, 0x97, 0x28, 0x67, 0x32, 0x96, 0x03, 0x21, 0xA7, 0x1E, 0xB2, 0x7E, 0xA7, 0xD6, 0x76, 0x0A, 0x8B, 0x28, 0x4B, 0x56, 0xB8]

    static let iv: [UInt8] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    func aesEncrypt(key: [UInt8] = aesKey, iv: [UInt8] = iv) -> String? {
        var result = ""

        do {
            let aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)

            // 開始加密
            let encrypted = try aes.encrypt(bytes)
            result = encrypted.toHexString().uppercased()
        } catch {
            print("AES encoding fail, error: \(error)")
        }
        return result
    }

    func aesDecrypt(key: [UInt8] = aesKey, iv: [UInt8] = iv) -> String? {
        var result = ""

        do {
            let aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
            let hexArray = [UInt8].init(hex: self)

            let decrypt = try aes.decrypt(hexArray)
            result = String(data: Data(decrypt), encoding: .utf8) ?? ""
        } catch {
            print("AES decoding fail error: \(error)")
        }
        return result
    }
}

// MARK: - Hex <-> Data

extension String {
    func toBytes() -> Data? {
        let len = count / 2

        guard len > 0 else { return nil }

        var bytes: [UInt8] = []
        let characters = Array(uppercased())

        for index in 0 ..< len {
            var bhASC = Int(characters[index * 2].asciiValue!)
            var blASC = Int(characters[index * 2 + 1].asciiValue!)

            bhASC = bhASC >= 65 ? bhASC - 7 : bhASC
            blASC = blASC >= 65 ? blASC - 7 : blASC

            bytes.append(UInt8(truncatingIfNeeded: ((bhASC - 48) * 16) + (blASC - 48)))
        }

        return Data(bytes)
    }
}
