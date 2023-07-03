//
//  DatabaseStorageManager.swift
//  TestATASKApp
//
//  Created by Jeri Purnama on 29/06/23.
//

import CoreData

class DatabaseStorageManager {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "YourDataModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                // Handle error
            }
        })
        return container
    }()

    func saveResult(_ result: ExpressionResult) {
        let context = persistentContainer.viewContext

        // Membuat instance entitas baru
        let entity = NSEntityDescription.entity(forEntityName: "ExpressionResultEntity", in: context)!
        let expressionResultObject = NSManagedObject(entity: entity, insertInto: context)

        // Mengisi nilai properti dengan data yang diberikan
        expressionResultObject.setValue(result.expression, forKey: "expression")
        expressionResultObject.setValue(result.result, forKey: "result")

        // Menyimpan perubahan ke basis data
        do {
            try context.save()
        } catch {
            // Handle error
        }
    }

    func loadResults() -> [ExpressionResult] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ExpressionResultEntity")

        // Mengambil data dari basis data
        do {
            let fetchedResults = try context.fetch(fetchRequest) as! [NSManagedObject]
            var results: [ExpressionResult] = []

            for expressionResultObject in fetchedResults {
                let expression = expressionResultObject.value(forKey: "expression") as? String ?? ""
                let result = expressionResultObject.value(forKey: "result") as? Double ?? 0.0

                let expressionResult = ExpressionResult(expression: expression, result: result)
                results.append(expressionResult)
            }

            return results
        } catch {
            // Handle error
            return []
        }
    }
}

//// Contoh penggunaan
//let databaseStorage = DatabaseStorageManager()
//let result = ExpressionResult(expression: "2+2", result: 4.0)
//databaseStorage.saveResult(result)
//let loadedResults = databaseStorage.loadResults()
//print(loadedResults)

