//
//  AuthUserData+CoreDataProperties.swift
//  EMTest
//
//  Created by Сергей Никитин on 23.03.2023.
//
//

import Foundation
import CoreData

extension AuthUserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AuthUserData> {
        return NSFetchRequest<AuthUserData>(entityName: "AuthUserData")
    }

    @NSManaged public var userId: String
    @NSManaged public var firstName: String
    @NSManaged public var lastName: String
    @NSManaged public var email: String
    @NSManaged public var photoData: Data?

}

extension AuthUserData : Identifiable {

}
