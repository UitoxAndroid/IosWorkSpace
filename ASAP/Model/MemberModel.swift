//
//  MemberModel.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/10/23.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation
import RealmSwift

class MemberModel 
{
	var guid: String {
		if let memberData = memberData {
			return memberData.guid
		}		
		return ""
	}
	
	var email: String {
		if let memberData = memberData {
			return memberData.email
		}		
		return ""
	}
	
	var phone: String {
		if let memberData = memberData {
			return memberData.phone
		}		
		return ""
	}
	
	var encodeGuid: String {
		if let memberData = memberData {
			return memberData.encodeGuid
		}		
		return ""
	}
	
	private var memberData: MemberData? {
		get {
			let realm = try! Realm()
			let results = realm.objects(MemberData)
			
			if results.count == 0 {
				return nil
			}
			
			return results[0]
		}
	}
	
	func deleteMemberData() {
		let realm = try! Realm()
		let results = realm.objects(MemberData)
		if results.count > 0 {
			realm.write {
				realm.delete(results[0])
			}
		}
	}
	
	func insertMemberDataIntoDisk(memberData: MemberData) {
		let realm = try! Realm()
		realm.beginWrite()
		realm.create(MemberData.self, value: memberData, update: false)
		realm.commitWrite()
	}
}