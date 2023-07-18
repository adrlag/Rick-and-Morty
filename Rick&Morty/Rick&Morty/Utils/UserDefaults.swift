//
//  UserDefaults.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 15/7/23.
//


import Foundation

enum UserDefaultsKeys: String {
    case imgSaved
}

extension UserDefaults {
    
    
    func saveString(value: String, key: String) {
        set(value, forKey: key)
        synchronize()
    }
    
    func saveInt(value: Int, key: String){
        set(value, forKey: key)
        synchronize()
    }
    
    func saveIntArray(value: [Int], key: String){
        set(value, forKey: key)
        synchronize()
    }
    
    func saveInt64(value: Int64, key: String){
        set(value, forKey: key)
        synchronize()
    }
    
    func saveBool(value: Bool, key: String) {
        set(value, forKey: key)
        synchronize()
    }
    
    func saveObject(value: Data, key: String) {
        set(value, forKey: key)
        synchronize()
    }
    
    func saveDate(value: Date, key: String) {
        set(value, forKey: key)
        synchronize()
    }
    
    func delete(key: String) {
        removeObject(forKey: key)
        synchronize()
    }
    
    
    // MARK: - LAST DOG
    func setImages(data: [ImgSaved]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: UserDefaultsKeys.imgSaved.rawValue)
        }
    }
    
    func addImage(data: ImgSaved) {
        var savedImgs = getImages()
        if(!savedImgs.contains(where: {$0.id == data.id})) {
            savedImgs.append(data)
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(savedImgs) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: UserDefaultsKeys.imgSaved.rawValue)
            }
        }
    }
    
    func getImages() -> [ImgSaved] {
        let defaults = UserDefaults.standard
        if let savedValue = defaults.object(forKey: UserDefaultsKeys.imgSaved.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let value = try? decoder.decode([ImgSaved].self, from: savedValue) {
                return value
            } else {
                return []
            }
        } else {
            return []
        }
    }
    
}
