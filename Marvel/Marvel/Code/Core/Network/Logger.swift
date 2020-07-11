//
//  Logger.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 11/07/2020.
//

import Foundation

func print(_ object: Any) {
    #if DEBUG
        Swift.print(object)
    #endif
}

class Logger {

    func logService(request: URLRequest?, statusCode: NSInteger?, data: Data?, error: Error?) {
        var log = ""
        log += "\n🏁 *** Service: *** 🏁\n"
        
        if let request = request {
            log += String(format: "🔗 %@ | %@\n", request.httpMethod ?? "{httpMethod}", request.url?.absoluteString ?? "{url}")
            
            if let body = request.httpBody {
                let params = String(data: body, encoding: .utf8) ?? "{httpBody}"
                log += String(format: "📂 Params: %@\n", params)
            }
        }
        
        let responseOK = 200 ... 299 ~= (statusCode ?? 0)
        log += String(format: "%@ Status Code: %ld\n", (responseOK ? "✅" : "❌"), (statusCode ?? 0))

        if let e = error {
            log += String(format: "📕 Error: %@\n", e.localizedDescription)
        }
        
        if let data = data {
            let book = error != nil ? "📙" : "📘"
            let dataString = String(data: data, encoding: .utf8)
            if let text = dataString, text != "" {
                if text.count > 1024 {
                    let beginning = text.index(text.startIndex, offsetBy: 512)
                    let ending = text.index(text.startIndex, offsetBy: text.count - 512)
                    log += String(format: "%@ Data response:\n%@\n[...]\n%@\n", book,  String(text[..<beginning]), String(text[ending...]))
                } else {
                    log += String(format: "%@ Data response:\n%@\n", book, text)
                }
            }
        }
        
        print(log)
    }
    
}
