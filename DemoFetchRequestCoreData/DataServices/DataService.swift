//
//  DataService.swift
//  DemoFetchRequestCoreData
//
//  Created by Tran Ngoc Nam on 5/9/18.
//  Copyright © 2018 Tran Ngoc Nam. All rights reserved.
//

import Foundation
import CoreData

class DataService {
    
    static let shared: DataService = DataService()
    
    private var _people: [User]?
    var people: [User] {
        get {
            if _people == nil {
                getDataFromCoreData()
            }
            return _people ?? []
        }
        set {
            _people = newValue
        }
    }
    private func getDataFromCoreData() {
        _people = []
        do {
            _people = try AppDelegate.context.fetch(User.fetchRequest())
        } catch  {
            print("Fetch Error")
        }
    }
    func saveDataToCoreData() {
        AppDelegate.saveContext()
        getDataFromCoreData()
    }
    
    func removeData(from indexPath: IndexPath) {
        guard let objectUser = _people else { return }
        AppDelegate.context.delete(objectUser[indexPath.row])
        saveDataToCoreData()
    }
}
