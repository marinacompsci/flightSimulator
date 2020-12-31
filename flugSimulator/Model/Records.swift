//
//  Records.swift
//  flugSimulator
//
//  Created by Marina Beatriz Santana de Aguiar on 29.12.20.
//

import UIKit

struct Records: Codable {
    
    let key = "records"
    
    var records =  [Record]()
    
    public func getAllRecords() -> [Record]? {
        let defaults = UserDefaults.standard
        
        //PROBLEM HERE getAllRecords returns NIL
        if let recordData = defaults.object(forKey: key) as? Data {
            if let records = try? PropertyListDecoder().decode([Record].self, from: recordData) {
                return records
            }
        }
        
        return nil
    }
    
    public func setRecord(record: Record) {
        let defaults = UserDefaults.standard
        //let encoder = JSONEncoder()
        var allRecords = getAllRecords()
        
        if allRecords != nil {
            allRecords!.append(record)
            
            defaults.setValue(allRecords, forKey: key)
            return
        }
        
        // UserDefaults has no record -- very first record being set
        var recordsArray = [Record]()
        recordsArray.append(record)
        defaults.setValue(try? PropertyListEncoder().encode(recordsArray), forKey: key)
        //defaults.setValue(recordsArray, forKey: key)
        
    }
    
}
