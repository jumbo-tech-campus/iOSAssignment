//
//  DiskCacheCartManager.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 20/12/2022.
//

import Foundation

class DiskCacheCartManager: CartManager, CartManagerDiskProtocol {
    private let base: URL
    
    override init() {
        let documets = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        base = documets[0].appendingPathExtension("Cart")
    }
    
    // Save data and write to the file
    func save() {
        do {
            let data = try PropertyListEncoder().encode(products)
            try data.write(to: base, options: .atomic)
        } catch {
            print(error)
        }
    }
    
    // Load if data exist in the file
    func load() {
        if let data = try? Data(contentsOf: base),
           let savedProducts = try? PropertyListDecoder().decode([String: CartDetails].self, from: data)
              {
            self.products = savedProducts
        } else {
            products = [:]
        }
    }
    
    
}
