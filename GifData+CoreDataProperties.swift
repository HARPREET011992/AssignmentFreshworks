//
//  GifData+CoreDataProperties.swift
//  FreshWorksAssignment
//
//  Created by Happy on 2021-08-08.
//
//

import Foundation
import CoreData


extension GifData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GifData> {
        return NSFetchRequest<GifData>(entityName: "GifData")
    }

    @NSManaged public var url: String?

}

extension GifData : Identifiable {

}
