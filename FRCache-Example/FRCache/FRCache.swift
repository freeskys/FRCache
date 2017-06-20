//
//  FRCache.swift
//  FRCache-Example
//
//  Created by Harditya on 6/20/17.
//  Copyright © 2017 Harditya Ramadhan. All rights reserved.
//

import Foundation
import UIKit

struct FRCache {
    
    static let frCacheIdentifier = "com.freeskys.frCache"
    
    /// Load cache
    ///
    /// - Parameters:
    ///   - key: key Cache key
    ///   - success: success Success retrieving cache
    ///   - failure: failure Fail while retrieving cache
    static func loadCache<T>(withKey key: String,
                          success: (_ objects: [T]) -> Void,
                          failure: () -> Void) {
        let tempObjects = FRCache.getCacheArray(withKey: key) as [T]
        
        if tempObjects.count > 0 {
            // If cache exist, use data from cache
            success(tempObjects)
        } else {
            failure()
        }
    }
    
    /// Cache array
    ///
    /// - Parameters:
    ///   - array: array The array to be cached
    ///   - key: key Cache key
    static func cacheArray<T>(array: [T],
                           withKey key: String) {
        // Get file URL
        let fileUrl = cacheDocumentURL(withKey: key)
        
        // Transform array into data and save it into file
        do {
            let data = try JSONSerialization.data(withJSONObject: array,
                                                  options: [])
            try data.write(to: fileUrl,
                           options: [])
            print("FRCache: Create cache with key \(key)")
        } catch {
            print("FRCache: Error: Failed when trying to save array into file: \(error)")
        }
    }
    
    /// Get cache array
    ///
    /// - Parameter key: key Cache key
    /// - Returns: return value Cached array
    static func getCacheArray<T>(withKey key: String) -> [T] {
        // Get file URL
        let fileUrl = cacheDocumentURL(withKey: key)
        
        // Read data from json and return it in array format
        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            guard let personArray = try JSONSerialization.jsonObject(
                with: data,
                options: []) as? [T] else {
                    return [T]()
            }
            
            return personArray
        } catch {
            print("FRCache: Error: Failed when trying to read file: \(error)")
            return [T]()
        }
    }
    
    /// Remove cache
    ///
    /// - Parameter key: key Cache key
    static func removeCache(withKey key: String) {
        // Get file URL
        let fileUrl = cacheDocumentURL(withKey: key)
        
        do {
            let fileManager = FileManager()
            try fileManager.removeItem(at: fileUrl)
        } catch {
            print("FRCache: Error: Failed when trying to delete directory: \(error)")
        }
    }
    
    /// Get cache document directory
    ///
    /// - Parameter key: key Cache key
    /// - Returns: return value Document directory URL
    private static func cacheDocumentURL(withKey key: String) -> URL {
        // Get document directory URL
        guard let documentDirectoryUrl = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else {
                return URL(fileURLWithPath: "")
        }
        
        // Create new file from the document directory URL
        let folderUrl = documentDirectoryUrl.appendingPathComponent("\(frCacheIdentifier)/")
        let fileUrl = folderUrl.appendingPathComponent("\(key).json")
        do {
            let fileManager = FileManager()
            try fileManager.createDirectory(at: folderUrl,
                                            withIntermediateDirectories: false,
                                            attributes: nil)
        } catch {
            print("FRCache: Error: Failed when trying to create directory: \(error)")
        }
        print("FileURL: \(fileUrl)")
        
        return fileUrl
    }
    
}

extension Array {
    
    /// Cache array
    ///
    /// - Parameter key: key Cache key
    func cacheArray(withKey key: String) {
        FRCache.cacheArray(array: self, withKey: key)
    }
    
}
