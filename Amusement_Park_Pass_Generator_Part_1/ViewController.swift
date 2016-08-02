//
//  ViewController.swift
//  Amusement_Park_Pass_Generator_Part_1
//
//  Created by Alex Millius on 29.07.16.
//  Copyright © 2016 TumTum. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    var grantedSound: SystemSoundID = 0
    var deniedSound: SystemSoundID = 0
    
    var people:PeopleType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        laodAllSounds()
        
        do {
            let guestClassic = try createPass(type: .GuestClassic, infos: PeopleInfos()); people = guestClassic
            //vipGuest = try createPass(type: .GuestVIP, infos: PeopleInfos()); people = vipGuest
            //freeChildGuest = try createPass(type: .GuestFreeChild, infos: PeopleInfos(birthday: "22.01.2014"));people = freeChildGuest
            //foodServiceEmployee = try createPass(type: .EmployeeFoodService, infos: PeopleInfos(employeeFirstName: "Armando", lastName: "Qeshua", dateOfBirth: "22.01.2000", streetAdress: "Route de Chiza", city: "Bengladou", zipCode: 1954, state: "NY", socialSecurityNumber: (12, 134, 1245)))
            //rideServiceEmployee = try createPass(type: .EmployeeRideService, infos: PeopleInfos(employeeFirstName: "Bob", lastName: "Smith", dateOfBirth: "22.04.87", streetAdress: "love street", city: "Bourgogne", zipCode: 1456, state: "Ohio", socialSecurityNumber: (123, 45, 678)))
            //maintenanceEmployee = try createPass(type: .EmployeeMaintenance, infos: PeopleInfos(employeeFirstName: "Charly", lastName: "Jacquot" , dateOfBirth: "30.11.1983", streetAdress: "Rue du babouin", city: "Berne", zipCode: 2489, state: "Michigan", socialSecurityNumber: (123, 432, 67)))
            //manager = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: "Marc", lastName: "Antille", dateOfBirth: "05.03.1975", streetAdress: "Boss's Street", city: "Manuver", zipCode: 2348, state: "Nevada", socialSecurityNumber: (34, 567, 2345)))
            //freeChildGuestTooYoung = try createPass(type: .GuestFreeChild, infos: PeopleInfos(birthday: "22.01.2000"))
            //managerFirstNameError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: nil, lastName: "Antille", dateOfBirth: "05.03.1975", streetAdress: "Boss's Street", city: "Manuver", zipCode: 2348, state: "Nevada", socialSecurityNumber: (34, 567, 2345)))
            //managerLastNameError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: "Marc", lastName: nil, dateOfBirth: "05.03.1975", streetAdress: "Boss's Street", city: "Manuver", zipCode: 2348, state: "Nevada", socialSecurityNumber: (34, 567, 2345)))
            //managerBirthdayError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: "Marc", lastName: "Antille", dateOfBirth: nil, streetAdress: "Boss's Street", city: "Manuver", zipCode: 2348, state: "Nevada", socialSecurityNumber: (34, 567, 2345)))
            //managerStreetAdressError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: "Marc", lastName: "Antille", dateOfBirth: "05.03.1975", streetAdress: nil, city: "Manuver", zipCode: 2348, state: "Nevada", socialSecurityNumber: (34, 567, 2345)))
            //managerCityError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: "Marc", lastName: "Antille", dateOfBirth: "05.03.1975", streetAdress: "Boss's Street", city: nil, zipCode: 2348, state: "Nevada", socialSecurityNumber: (34, 567, 2345)))
            //managerZipCodeError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: "Marc", lastName: "Antille", dateOfBirth: "05.03.1975", streetAdress: "Boss's Street", city: "Manuver", zipCode: nil, state: "Nevada", socialSecurityNumber: (34, 567, 2345)))
            //managerStateError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: "Marc", lastName: "Antille", dateOfBirth: "05.03.1975", streetAdress: "Boss's Street", city: "Manuver", zipCode: 2348, state: nil, socialSecurityNumber: (34, 567, 2345)))
            //managerSocialSecurityError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: "Marc", lastName: "Antille", dateOfBirth: "05.03.1975", streetAdress: "Boss's Street", city: "Manuver", zipCode: 2348, state: "Nevada", socialSecurityNumber: nil))
            //managerTierError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .None, firstName: "Marc", lastName: "Antille", dateOfBirth: "05.03.1975", streetAdress: "Boss's Street", city: "Manuver", zipCode: 2348, state: "Nevada", socialSecurityNumber: (34, 567, 2345)))
            //managerDateFormatError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: "Marc", lastName: "Antille", dateOfBirth: "555.44403.441975", streetAdress: "Boss's Street", city: "Manuver", zipCode: 2348, state: "Nevada", socialSecurityNumber: (34, 567, 2345)))
        } catch Error.UnableToCreatePeople {
            print("Unable to create People")
        } catch Error.UnknownType(let error) {
            print(error)
        }
        catch let error {
            print(error)
        }
        
        if let people = people {
            if AmusementParkArea.checkIfAccessGranted(people).granted{playSound(grantedSound)}else{playSound(deniedSound)}
            //if RidesArea.checkIfAccessGranted(people).granted{playSound(grantedSound)}else{playSound(deniedSound)}
            //if RidesControllArea.checkIfAccessGranted(people).granted{playSound(grantedSound)}else{playSound(deniedSound)}
            //if SkipLineArea.checkIfAccessGranted(people).granted{playSound(grantedSound)}else{playSound(deniedSound)}
            //if MaintenanceArea.checkIfAccessGranted(people).granted{playSound(grantedSound)}else{playSound(deniedSound)}
            //if KitchenArea.checkIfAccessGranted(people).granted{playSound(grantedSound)}else{playSound(deniedSound)}
            //if OfficeArea.checkIfAccessGranted(people).granted{playSound(grantedSound)}else{playSound(deniedSound)}
            //if FoodDiscountCheck.checkIfAccessGranted(people).granted{playSound(grantedSound)}else{playSound(deniedSound)}
            //if MerchandiseDiscountCheck.checkIfAccessGranted(people).granted{playSound(grantedSound)}else{playSound(deniedSound)}
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createPass(type type:TypesOfPeople, infos:PeopleInfos) throws -> PeopleType {
        
        var people:PeopleType?
        
        do {
            people = try createNewPeople(type: type, firstName: infos.firstName, lastName: infos.lastName, dateOfBirth: infos.dateOfBirth, streetAdress: infos.streetAdress, city: infos.city, zipCode: infos.zipCode, state: infos.state, socialSecurityNumber: infos.socialSecurityNumber, managementTier: infos.managementTier)
        } catch ErrorMissingInfo.FirstNameMissing(let error){
            print("Please enter a \(error)")
        } catch ErrorMissingInfo.LastNameMissing(let error){
            print("Please enter a \(error)")
        } catch ErrorMissingInfo.DateOfBirthMissing(let error){
            print("Please enter a \(error)")
        } catch ErrorMissingInfo.StreetAdressMissing(let error){
            print("Please enter a \(error)")
        } catch ErrorMissingInfo.CityMissing(let error){
            print("Please enter a \(error)")
        } catch ErrorMissingInfo.ZipCodeMissing(let error){
            print("Please enter a \(error)")
        } catch ErrorMissingInfo.StateMissing(let error){
            print("Please enter a \(error)")
        } catch ErrorMissingInfo.SocialSecurityNumberMissing(let error){
            print("Please enter a \(error)")
        } catch ErrorMissingInfo.ManagementTierMissing(let error){
            print("Please enter a \(error)")
        } catch Error.PeopleTooOldForFree{
            print("Sorry, you are too old for a free pass")
        } catch Error.InvalidDateFormat{
            print("Invalid date format")
        }catch Error.UnknownType(let error){
            print(error)
        } catch let error {
            print(error)
        }
        
        if let people = people {
            return people
        } else {
            throw Error.UnableToCreatePeople
        }
    }
    
    //MARK: - Sound Helper
    enum Sounds:String{
        case AccessDenied
        case AccessGranted
    }
    
    func laodAllSounds(){
        let wav = "wav"
        grantedSound = loadSound(grantedSound, pathName: Sounds.AccessGranted.rawValue, type: wav)
        deniedSound = loadSound(deniedSound, pathName: Sounds.AccessDenied.rawValue, type: wav)
    }
    
    func loadSound(systSoundId:SystemSoundID, pathName:String, type:String) -> SystemSoundID{
        var sound = SystemSoundID()
        let pathToSoundFile = NSBundle.mainBundle().pathForResource(pathName, ofType: type)
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &sound)
        return sound
    }
    
    func playSound(soundId:SystemSoundID) {
        AudioServicesPlaySystemSound(soundId)
    }
}

