//
//  Step+CoreDataProperties.swift
//  CoreDataTask
//
//  Created by Tony Chen on 9/5/2023.
//
//

import Foundation
import CoreData


extension Step {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Step> {
        return NSFetchRequest<Step>(entityName: "Step")
    }

    @NSManaged public var name: String?
    @NSManaged public var stepNum: Int16
    @NSManaged public var task: Task?

}

extension Step : Identifiable {

}
