//
//  SwitchItem.swift
//  CompareApp
//
//  Created by Karsten Bruns on 29/08/15.
//  Copyright © 2015 bruns.me. All rights reserved.
//

import UIKit



public struct SwitchItem : DeltaTableViewItem, SelectableTableViewItem  {
    
    public typealias ValueHandler = (value: Bool) -> ()
    
    public let id: String
    public let reuseIdentifier = "Switch"
    
    public let title: String
    public let value: Bool
    public let valueHandler: ValueHandler
    public let selectionHandler: SelectionHandler?
    
    public init(id: String, title: String, value: Bool, valueHandler: ValueHandler, selectionHandler: SelectionHandler? = nil) {
        self.id = id
        self.title = title
        self.value = value
        self.valueHandler = valueHandler
        self.selectionHandler = selectionHandler
    }
}



extension SwitchItem : ComparableItem {

    public var uniqueIdentifier: Int { return id.hash }
    
    public func compareTo(other: ComparableItem) -> ComparisonLevel {
        guard other.uniqueIdentifier == self.uniqueIdentifier else { return .Different }
        guard let otherRow = other as? SwitchItem else { return .Different }
        
        if otherRow.title == self.title && otherRow.value == self.value && otherRow.id == self.id {
            return .Same
        } else {
            return .Changed([:])
        }
    }

}