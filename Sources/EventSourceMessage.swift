//
//  EventSourceMessage.swift
//  AlamofireEventSource
//
//  Created by Daniel Clelland on 7/08/20.
//

import Foundation

public struct EventSourceMessage {
    
    public var event: String?
    public var id: String?
    public var data: String?
    public var retry: String?
    
}

extension EventSourceMessage {
    
    internal init?(parsing string: String) {
        let fields = string.components(separatedBy: "\n").compactMap(Field.init(parsing:))
        for field in fields {
            switch field.key {
            case .event:
                self.event = self.event.map { $0 + "\n" + field.value } ?? field.value
            case .id:
                self.id = self.id.map { $0 + "\n" + field.value } ?? field.value
            case .data:
                self.data = self.data.map { $0 + "\n" + field.value } ?? field.value
            case .retry:
                self.retry = self.retry.map { $0 + "\n" + field.value } ?? field.value
            }
        }
    }
    
}

extension EventSourceMessage {
    
    internal struct Field {
        
        internal enum Key: String {
            
            case event
            case id
            case data
            case retry
            
        }
        
        internal var key: Key
        internal var value: String
        
        internal init?(parsing string: String) {
            let scanner = Scanner(string: string)
            
            guard let key = scanner.scanUpToString(":").flatMap(Key.init(rawValue:)) else {
                return nil
            }
            
            _ = scanner.scanString(":")
            
            guard let value = scanner.scanUpToString("\n") else {
                return nil
            }
            
            self.key = key
            self.value = value
        }
        
    }
    
}
