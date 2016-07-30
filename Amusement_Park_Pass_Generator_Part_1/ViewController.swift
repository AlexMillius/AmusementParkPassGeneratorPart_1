//
//  ViewController.swift
//  Amusement_Park_Pass_Generator_Part_1
//
//  Created by Alex Millius on 29.07.16.
//  Copyright © 2016 TumTum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do {
            //let guestClassic = try createHardCodedPeople(type: .GuestClassic, infos: nil) //Guest Classic without error
            //let vipGuest = try createHardCodedPeople(type: .GuestVIP, infos: nil) //Guest VIP without error
            //let freeChildGuest = try createHardCodedPeople(type: .GuestFreeChild, infos: PeopleInfos(birthday: "22.01.2014"))
            //let foodServiceEmployee = try createHardCodedPeople(type: .EmployeeFoodService, infos: PeopleInfos(firstName: "Armando", lastName: "Qeshua", dateOfBirth: "22.01.2000", streetAdress: "Route de Chiza", city: "Bengladou", zipCode: 1954, state: "NY", socialSecurityNumber: (12, 134, 1245)))
            //let rideServiceEmployee = try createHardCodedPeople(type: .EmployeeRideService, infos: PeopleInfos(firstName: "Bob", lastName: "Smith", dateOfBirth: "22.04.87", streetAdress: "love street", city: "Bourgogne", zipCode: 1456, state: "Ohio", socialSecurityNumber: (123, 45, 678)))
            //let maintenanceEmployee = try createHardCodedPeople(type: .EmployeeMaintenance, infos: PeopleInfos(firstName: "Charly", lastName: "Jacquot" , dateOfBirth: "30.11.1983", streetAdress: "Rue du babouin", city: "Berne", zipCode: 2489, state: "Michigan", socialSecurityNumber: (123, 432, 67)))
            let manager = try createHardCodedPeople(type: .EmployeeManager, infos: PeopleInfos(managementTier: .General, firstName: "Marc", lastName: "Antille", dateOfBirth: "05.03.1975", streetAdress: "Boss's Street", city: "Manuver", zipCode: 2348, state: "Nevada", socialSecurityNumber: (34, 567, 2345)))
            
        } catch Error.UnableToCreatePeople {
            print("Unable to create People")
        } catch Error.UnknownType(let error) {
            print(error)
        }
        catch let error {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createHardCodedPeople(type type:TypesOfPeople, infos:PeopleInfos?) throws -> PeopleType {
        
        var people:PeopleType?
        
        do {
            people = try createNewPeople(type: type, firstName: infos?.firstName, lastName: infos?.lastName, dateOfBirth: infos?.dateOfBirth, streetAdress: infos?.streetAdress, city: infos?.city, zipCode: infos?.zipCode, state: infos?.state, socialSecurityNumber: infos?.socialSecurityNumber, managementTier: infos?.managementTier)
        } catch ErrorMissingInfo.FirstNameMissing(let error){
            print("please enter a \(error)")
        } catch ErrorMissingInfo.LastNameMissing(let error){
            print("please enter a \(error)")
        } catch ErrorMissingInfo.DateOfBirthMissing(let error){
            print("please enter a \(error)")
        } catch ErrorMissingInfo.StreetAdressMissing(let error){
            print("please enter a \(error)")
        } catch ErrorMissingInfo.CityMissing(let error){
            print("please enter a \(error)")
        } catch ErrorMissingInfo.ZipCodeMissing(let error){
            print("please enter a \(error)")
        } catch ErrorMissingInfo.StateMissing(let error){
            print("please enter a \(error)")
        } catch ErrorMissingInfo.SocialSecurityNumberMissing(let error){
            print("please enter a \(error)")
        } catch ErrorMissingInfo.ManagementTierMissing(let error){
            print("please enter a \(error)")
        } catch Error.PeopleTooOldForFree{
            print("Sorry, you are too old for a free pass")
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
}

