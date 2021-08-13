//
//  GifData.swift
//  FreshWorksAssignment
//
//  Created by Happy on 2021-08-09.
//

import Foundation
import UIKit
import CoreData

public class GifData: NSManagedObject{
    @NSManaged var gifUrl: String
    @NSManaged var isFav: Bool
}
