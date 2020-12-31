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
        
        if let recordData = defaults.object(forKey: key) as? Data {
            if let records = try? PropertyListDecoder().decode([Record].self, from: recordData) {
                return records
            }
        }
        
        return nil
    }
    
    public func setRecord(record: Record) {
        let defaults = UserDefaults.standard
        var allRecords = getAllRecords()
        
        if allRecords != nil {
            // Replace an old highscore with new one
            // in case there is already 10 entries of highscore saved
            if allRecords!.count == 10 {
                let recordIsHighscore = isHighscore(record: record)
                guard recordIsHighscore != nil, recordIsHighscore == true else { return}
                
                if let index = allRecords?.lastIndex(where: {record.distance >= $0.distance && record.speed >= $0.speed }) {
                    allRecords![index] = record
                    defaults.setValue(try? PropertyListEncoder().encode(allRecords), forKey: key)
                    return
                }
            }
            
            allRecords!.append(record)
            defaults.setValue(try? PropertyListEncoder().encode(allRecords), forKey: key)
            return
        }
        
        // UserDefaults has no record -- very first record being set
        var recordsArray = [Record]()
        recordsArray.append(record)
        
        // Cannot save custom type([Record])
        // Transforming [Record] into Data
        defaults.setValue(try? PropertyListEncoder().encode(recordsArray), forKey: key)
    }
    
    public func isHighscore(record: Record) -> Bool? {
        let allRecords = getAllRecords()
        
        if let isHighscore = allRecords?.contains(where: { record.distance >= $0.distance  && record.speed >= $0.speed}) {
            return isHighscore
        }
        
        return nil        
    }
    
}
