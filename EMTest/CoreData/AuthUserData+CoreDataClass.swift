//
//  AuthUserData+CoreDataClass.swift
//  EMTest
//
//  Created by Сергей Никитин on 23.03.2023.
//
//

import UIKit
import CoreData

@objc(AuthUserData)
public class AuthUserData: NSManagedObject {

    static func checkUser(withLogin email: String, completion: @escaping (Bool, String?) -> Void) {
        
        let fetch: NSFetchRequest<AuthUserData> = AuthUserData.fetchRequest()
                                
        do {
            let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetch) { (results) -> Void in
                
                guard let users = results.finalResult else {
                    completion(false, nil)
                    return
                }
                
                guard let user = users.filter({ $0.email.lowercased() == email.lowercased() }).first else {
                    completion(false, nil)
                    return
                }
                
                completion(true, user.userId)
            }
                            
            try context.execute(asynchronousFetchRequest)
        } catch {
            completion(false, nil)
        }
    }
    
    static func addUser(firstName: String, lastName: String, email: String, completion: @escaping (String?) -> Void) {
        
        let fetch: NSFetchRequest<AuthUserData> = AuthUserData.fetchRequest()
                                
        do {
            let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetch) { (results) -> Void in
                
                let user = AuthUserData(context: context)
                user.setValue(UUID().uuidString, forKey: #keyPath(AuthUserData.userId))
                user.setValue(firstName, forKey: #keyPath(AuthUserData.firstName))
                user.setValue(lastName, forKey: #keyPath(AuthUserData.lastName))
                user.setValue(email, forKey: #keyPath(AuthUserData.email))
                user.setValue(nil, forKey: #keyPath(AuthUserData.photoData))
                
                AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
                completion(user.userId)
            }
                            
            try context.execute(asynchronousFetchRequest)
        } catch {
            completion(nil)
        }
    }
    
    static func getUser(withUserId userId: String, completion: @escaping (AuthUserData?) -> Void) {
        
        let fetch: NSFetchRequest<AuthUserData> = AuthUserData.fetchRequest()
                                
        do {
            let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetch) { (results) -> Void in
                
                guard let user = results.finalResult?.filter({ $0.userId == userId }).first else {
                    completion(nil)
                    return
                }
                
                completion(user)
            }
                            
            try context.execute(asynchronousFetchRequest)
        } catch {
            completion(nil)
        }
    }
    
    static func setUserPhoto(_ image: UIImage, forUser userId: String, completion: @escaping (Bool) -> Void) {
        
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            completion(false)
            return
        }
        
        let fetch: NSFetchRequest<AuthUserData> = AuthUserData.fetchRequest()
                                
        do {
            let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetch) { (results) -> Void in
                
                guard let user = results.finalResult?.filter({ $0.userId == userId }).first else {
                    completion(false)
                    return
                }
                
                user.setValue(data, forKey: #keyPath(AuthUserData.photoData))
                AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
                
                completion(true)
            }
                            
            try context.execute(asynchronousFetchRequest)
        } catch {
            completion(false)
        }
    }
    
    var photo: UIImage {
        guard let data = self.photoData, let image = UIImage(data: data) else {
            return UIImage(named: "default-user-icon")!
        }
        
        return image
    }
}
