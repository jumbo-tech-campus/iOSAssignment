//
//  DiskCacheCartManager.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 20/12/2022.
//

import Foundation

class DiskCacheCartManager: CartManager, CartManagerDiskProtocol {
    private var url: URL?
    
    override init() {
        super.init()
        url = getDocumentsDirectory()
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0].appendingPathComponent("cart.txt")
    }
    
    // Save data and write to the file
    func save() {
        guard let url = url else { return  }
        do {
            let data = try PropertyListEncoder().encode(products)
            try data.write(to: url, options: .atomic)
        } catch {
            print(error)
        }
    }
    
    // Load if data exist in the file
    func load() {
        guard let url = url else { return  }
        if let data = try? Data(contentsOf: url),
           let savedProducts = try? PropertyListDecoder().decode([String: CartDetails].self, from: data)
              {
            self.products = savedProducts
        } else  {
            products = [:]
        }
    }
}
