//
//  Split+.swift
//  shic
//
//  Created by Руслан Парастаев on 08.10.2024.
//

import Foundation

extension Array {
    
    func split(into chunkSize: Int = 4) -> [[Element]] {
        var result = [[Element]]()
        var currentChunk = [Element]()

        for element in self {
            currentChunk.append(element)
            if currentChunk.count == chunkSize {
                result.append(currentChunk)
                currentChunk.removeAll()
            }
        }

        if !currentChunk.isEmpty {
            result.append(currentChunk)
        }

        return result
    }
    
}
