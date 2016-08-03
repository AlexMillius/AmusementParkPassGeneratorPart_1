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
            //let freeChildGuest = try createPass(type: .GuestFreeChild, infos: PeopleInfos(birthday: "02.09.2014"));people = freeChildGuest
            //let foodServiceEmployee = try createPass(type: .EmployeeFoodService, infos: PeopleInfos(employeeFirstName: "Armando", lastName: "Qeshua", dateOfBirthString: "22.01.2000", streetAdress: "Route de Chiza", city: "Bengladou", zipCode: 1954, state: "NY", socialSecurityNumber: (12, 134, 1245))); people = foodServiceEmployee
            //let rideServiceEmployee = try createPass(type: .EmployeeRideService, infos: PeopleInfos(employeeFirstName: "Bob", lastName: "Smith", dateOfBirthString: "22.04.87", streetAdress: "love street", city: "Bourgogne", zipCode: 1456, state: "Ohio", socialSecurityNumber: (123, 45, 678))); people = rideServiceEmployee
            //let maintenanceEmployee = try createPass(type: .EmployeeMaintenance, infos: PeopleInfos(employeeFirstName: "Charly", lastName: "Jacquot" , dateOfBirthString: "30.11.1983", streetAdress: "Rue du babouin", city: "Berne", zipCode: 2489, state: "Michigan", socialSecurityNumber: (123, 432, 67))); people = maintenanceEmployee
            //let manager = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: "Marc", lastName: "Antille", dateOfBirthString: "02.08.1975", streetAdress: "Boss's Street", city: "Manuver", zipCode: 2348, state: "Nevada", socialSecurityNumber: (34, 567, 2345))); people = manager
            //let freeChildGuestTooYoung = try createPass(type: .GuestFreeChild, infos: PeopleInfos(birthday: "22.01.2000")); people = freeChildGuestTooYoung
            //let managerFirstNameError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: nil, lastName: "Antille", dateOfBirthString: "05.03.1975", streetAdress: "Boss's Street", city: "Manuver", zipCode: 2348, state: "Nevada", socialSecurityNumber: (34, 567, 2345))); people = managerFirstNAmeError
            //let managerLastNameError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: "Marc", lastName: nil, dateOfBirthString: "05.03.1975", streetAdress: "Boss's Street", city: "Manuver", zipCode: 2348, state: "Nevada", socialSecurityNumber: (34, 567, 2345))); people = managerLastNameError
            //let managerBirthdayError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: "Marc", lastName: "Antille", dateOfBirthString: nil, streetAdress: "Boss's Street", city: "Manuver", zipCode: 2348, state: "Nevada", socialSecurityNumber: (34, 567, 2345))); people = managerBirthdayError
            //let managerStreetAdressError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: "Marc", lastName: "Antille", dateOfBirthString: "05.03.1975", streetAdress: nil, city: "Manuver", zipCode: 2348, state: "Nevada", socialSecurityNumber: (34, 567, 2345))); people = managerStreetAdressError
            //let managerCityError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: "Marc", lastName: "Antille", dateOfBirthString: "05.03.1975", streetAdress: "Boss's Street", city: nil, zipCode: 2348, state: "Nevada", socialSecurityNumber: (34, 567, 2345))); people = managerCityError
            //let managerZipCodeError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: "Marc", lastName: "Antille", dateOfBirthString: "05.03.1975", streetAdress: "Boss's Street", city: "Manuver", zipCode: nil, state: "Nevada", socialSecurityNumber: (34, 567, 2345))); people = managerZipCodeError
            //let managerStateError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: "Marc", lastName: "Antille", dateOfBirthString: "05.03.1975", streetAdress: "Boss's Street", city: "Manuver", zipCode: 2348, state: nil, socialSecurityNumber: (34, 567, 2345))); people = managerStateError
            //let managerSocialSecurityError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: "Marc", lastName: "Antille", dateOfBirthString: "05.03.1975", streetAdress: "Boss's Street", city: "Manuver", zipCode: 2348, state: "Nevada", socialSecurityNumber: nil)); people = managerSocialSecurtityError
            //let managerTierError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .None, firstName: "Marc", lastName: "Antille", dateOfBirthString: "05.03.1975", streetAdress: "Boss's Street", city: "Manuver", zipCode: 2348, state: "Nevada", socialSecurityNumber: (34, 567, 2345))); people = managerTierError
            //let managerDateFormatError = try createPass(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: "Marc", lastName: "Antille", dateOfBirthString: "555.44403.441975", streetAdress: "Boss's Street", city: "Manuver", zipCode: 2348, state: "Nevada", socialSecurityNumber: (34, 567, 2345))); people = managerDateFormatError
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
            //if AmusementParkArea.checkIfAccessGranted(people).birthDay {print("Happy Birthday!")}
            //if RidesArea.checkIfAccessGranted(people).granted{playSound(grantedSound)}else{playSound(deniedSound)}
            //if RidesControllArea.checkIfAccessGranted(people).granted{playSound(grantedSound)}else{playSound(deniedSound)}
            //if SkipLineArea.checkIfAccessGranted(people).granted{playSound(grantedSound)}else{playSound(deniedSound)}
            //if MaintenanceArea.checkIfAccessGranted(people).granted{playSound(grantedSound)}else{playSound(deniedSound)}
            //if KitchenArea.checkIfAccessGranted(people).granted{playSound(grantedSound)}else{playSound(deniedSound)}
            //if OfficeArea.checkIfAccessGranted(people).granted{playSound(grantedSound)}else{playSound(deniedSound)}
            //if FoodDiscountCheck.checkIfAccessGranted(people).granted{playSound(grantedSound)}else{playSound(deniedSound)}
            //if MerchandiseDiscountCheck.checkIfAccessGranted(people).granted{playSound(grantedSound)}else{playSound(deniedSound)}
        } // end of if let people
    }// end of viewDidLoad

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createPass(type type:TypesOfPeople, infos:PeopleInfos) throws -> PeopleType {
        
        var people:PeopleType?
        
        do {
            people = try createNewPeople(type: type, firstName: infos.firstName, lastName: infos.lastName, dateOfBirthString: infos.dateOfBirthString, streetAdress: infos.streetAdress, city: infos.city, zipCode: infos.zipCode, state: infos.state, socialSecurityNumber: infos.socialSecurityNumber, managementTier: infos.managementTier)
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

