//
//  DataManager.swift
//  MUNZUL
//
//  Created by Sonoma on 22/03/24.
//

import Foundation
import UIKit
import CoreData

class DataManager {
    static let shared = DataManager()
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ProfileDataModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveProfileData(_ profileData: Profile_JSON) {
        let profileEntity = ProfileEntity(context: viewContext)
        profileEntity.userName = profileData.data?.name
        profileEntity.userEmail = profileData.data?.email
        profileEntity.profilePic = profileData.data?.profile_pic
        // Assign other properties as needed
        print("Profile data saved to Core Data")

        saveContext()
    }
    
    func fetchProfileData() -> [ProfileEntity]? {
        let fetchRequest: NSFetchRequest<ProfileEntity> = ProfileEntity.fetchRequest()
        do {
            let profileData = try viewContext.fetch(fetchRequest)
            return profileData
        } catch {
            print("Error fetching profile data: \(error.localizedDescription)")
            return nil
        }
    }

    func saveProfileColor(colorInteger: Int?) {
        guard let colorInteger = colorInteger else {
            print("No color integer provided")
            return
        }
        UserDefaults.standard.set(colorInteger, forKey: "SelectedColorInteger")
        print("Profile frame color saved to UserDefaults")
    }
    func fetchProfileColor() -> Int? {
        return UserDefaults.standard.integer(forKey: "SelectedColorInteger")
    }
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
    }
}
