//
//  FileStorageManager.swift
//  TestATASKApp
//
//  Created by Jeri Purnama on 29/06/23.
//

import Foundation
import CoreData

struct ExpressionResult {
    let expression: String
    let result: Double
}

class FileStorageManager {
    func saveResult(_ result: ExpressionResult, encryptionKey: String) {
        // Mengenkripsi data
        let encryptedExpression = encrypt(result.expression, encryptionKey)
        let encryptedResult = encrypt(String(result.result), encryptionKey)

        // Menyimpan data terenkripsi dalam file
        let data = "\(encryptedExpression),\(encryptedResult)"
        let filePath = "path_to_file"
        writeToFile(data, filePath)
    }

    func loadResults(encryptionKey: String) -> [ExpressionResult] {
        var results: [ExpressionResult] = []
        let filePath = "path_to_file"
        if let data = readFromFile(filePath) {
            let dataArray = data.components(separatedBy: ",")
            for i in stride(from: 0, to: dataArray.count, by: 2) {
                let encryptedExpression = dataArray[i]
                let encryptedResult = dataArray[i + 1]

                // Mendekripsi data
                let expression = decrypt(encryptedExpression, encryptionKey)
                let result = Double(decrypt(encryptedResult, encryptionKey)) ?? 0.0

                let expressionResult = ExpressionResult(expression: expression, result: result)
                results.append(expressionResult)
            }
        }
        return results
    }

    private func encrypt(_ data: String, _ key: String) -> String {
        // Implementasi enkripsi sesuai kebutuhan
        // ...
        return "encryptedData"
    }

    private func decrypt(_ encryptedData: String, _ key: String) -> String {
        // Implementasi dekripsi sesuai kebutuhan
        // ...
        return "decryptedData"
    }

    private func writeToFile(_ data: String, _ filePath: String) {
        // Implementasi penulisan data ke file
        // ...
        
    }

    private func readFromFile(_ filePath: String) -> String? {
        // Implementasi pembacaan data dari file
        // ...
        return "fileData"
    }
}

//// Contoh penggunaan
//let fileStorage = FileStorageManager()
//let result = ExpressionResult(expression: "2+2", result: 4.0)
//fileStorage.saveResult(result, encryptionKey: "encryption_key")
//let loadedResults = fileStorage.loadResults(encryptionKey: "encryption_key")
//print(loadedResults)
