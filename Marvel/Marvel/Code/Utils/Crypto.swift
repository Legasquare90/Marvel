//
//  Crypto.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 07/07/2020.
//

import Foundation
import CommonCrypto

func md5Hash(str: String) -> String {
    if let strData = str.data(using: String.Encoding.utf8) {
        var digest = [UInt8](repeating: 0, count:Int(CC_MD5_DIGEST_LENGTH))
        _ = strData.withUnsafeBytes {
            CC_MD5($0.baseAddress, UInt32(strData.count), &digest)
        }
        var md5String = ""
        for byte in digest {
            md5String += String(format:"%02x", UInt8(byte))
        }
        return md5String
    }
    return ""
}
