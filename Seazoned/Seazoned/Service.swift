//
//  Webservice.swift
//  EstateBlock
//
//  Created by Dinesh Sailor on 28/11/16.
//  Copyright © 2016 Varshaa Weblabs. All rights reserved.
//

import UIKit

import Alamofire
import Reachability
import SVProgressHUD

struct Server {
  //  static let demo = "http://jbmdemo.in/prediktion/api/"
    
    //static let live =  "http://192.168.1.2:8080/dev/seazonedapp/public/api/"
    
    //static let live2 = "http://192.168.1.2:8080/dev/seazonedapp/public/"
    
   //   static let live2 = "http://103.230.103.142:8080/dev/seazonedapp/public/"
    
     // static let live =  "http://103.230.103.142:8080/dev/seazonedapp/public/api/"
    
    
    
      static let live2 = "http://seazoned.com/api/"
    
      static let live =  "http://seazoned.com/api/"
    
    
  //  "http://seazoned.com/api"
//http://103.230.103.142:8080/dev/seazonedapp/public/api/
    
	//static let live = "http://prediktions.com/api/"
}

enum LoginSource: String {
    case custom = "custom"
    case facebook = "facebook"
    case google = "google"
    case twitter = "twitter"
}

struct Parameter {
    
    static let username = "username"
    static let password = "password"
     static let profile_id = "profile_id"
    
     static let old_pw = "old_pw"
      static let new_pw = "new_pw"
     static let conf_pw = "conf_pw"
    
    
    
      static let first_name = "first_name"
      static let last_name = "last_name"
    
    static let email = "email"
    //tel
  static let tel = "tel"
    static let dob = "dob"
    
	 static let street = "street"
     static let city = "city"
   // state
      static let state = "state"
      static let country = "country"
     static let book_service_id = "book_service_id"
    static let status   = "status"
    static let address   = "address"
    
    static let profile_image = "profile_image"
    
    static let facebook_id = "facebook_id"
    
    static let google_id = "google_id"
    
    static let user_id = "user_id"
    static let service_id = "service_id"
    
    static let pool_chlorine = "pool_chlorine"
    static let pool_saline = "pool_saline"
    static let pool_spa_hot_tub = "pool_spa_hot_tub"
    static let pool_inground = "pool_inground"
    static let pool_above_ground = "pool_above_ground"
    static let pool_clear = "pool_clear"
    static let pool_cloudy = "pool_cloudy"
    static let pool_heavy = "pool_heavy"
    
    static let area_first_acre = "area_first_acre"
    static let area_next_acre = "area_next_acre"
    static let area_acre_limit = "area_acre_limit"
    
    static let lawntreat_first_acre = "lawntreat_first_acre"
    static let lawntreat_next_acre = "lawntreat_next_acre"
    static let lawntreat_acre_limit = "lawntreat_acre_limit"
    
    static let lawn_first_acre = "lawn_first_acre"
    static let lawn_first_grass = "lawn_first_grass"
    static let lawn_next_acre = "lawn_next_acre"
    static let lawn_next_grass = "lawn_next_grass"
    static let lawn_acre_limit = "lawn_acre_limit"
    
    static let leaf_first_acre = "leaf_first_acre"
    static let leaf_next_acre = "leaf_next_acre"
    static let leaf_acre_limit = "leaf_acre_limit"
    static let light = "light"
    static let medium = "medium"
    static let heavy = "heavy"
    static let over_top = "over_top"
    
    static let winter_first_acre = "winter_first_acre"
    static let winter_next_acre = "winter_next_acre"
    static let winter_acre_limit = "winter_acre_limit"
    static let winter_first_zone = "winter_first_zone"
    static let winter_next_zone = "winter_next_zone"
    static let winter_zone_limit = "winter_zone_limit"
    
    static let first_car = "first_car"
    static let next_car = "next_car"
    static let car_limit = "car_limit"
    static let straight = "straight"
    static let circular = "circular"
    static let incline = "incline"
    static let front_door = "front_door"
    static let stairs = "stairs"
    static let side_door = "side_door"
    
    static let added_service_id = "added_service_id"
    
    static let provider_name = "provider_name"
    static let description = "description"
    static let days = "days"
    static let start = "start"
    static let end = "end"
    static let recurring_services = "recurring_services"
    
    static let order_id = "order_id"
    
    static let paypal_name = "paypal_name"
    static let paypal_api_username = "paypal_api_username"
    static let paypal_api_password = "paypal_api_password"
    static let paypal_api_signature = "paypal_api_signature"
    
    static let paypal_id = "paypal_id"
    
    static let device_token = "device_token"
    static let device_type = "device_type"
    static let user_type = "user_type"
    
    static let latitude = "latitude"
    static let longitude = "longitude"
   
}

struct Webservice {
	
	static let addOneSignalId = Server.live + "add_signal_id"
     static let notification = Server.live + "get-notification-status"
    static let login = Server.live + "authenticate"
    static let register = Server.live + "landscaper-registration"
      static let change_landscaper_driver_image  = Server.live + "change-landscaper-driver-image"
    static let userinfo = Server.live + "userinfo"
    
    static let userinfo_edit = Server.live + "userinfo-edit"
     static let service_request = Server.live + "service-request"
 static let accept_reject_service = Server.live + "accept-reject-service"
    static let landscaper_edit = Server.live + "landscaper-edit"
    static let serviceList = Server.live + "service-list"

    //accept-reject-service
 //service-pending
	 static let service_pending = Server.live + "service-pending"
    
    static let landscaper_fb_login = Server.live + "landscaper-fb-login"
    
    static let landscaper_google_login = Server.live + "landscaper-google-login"
    
    static let add_lanscaper_details = Server.live + "add-lanscaper-details"

    static let view_added_services = Server.live + "view-added-services"
    
    static let delete_added_services = Server.live + "delete-added-services"
    
    static let add_provider_details = Server.live + "add-provider-details"
    
    static let view_service = Server.live + "view-service"
    
    static let edit_service = Server.live + "edit-service"
    
    static let view_service_hours_and_others = Server.live + "view-service-hours-and-others"
    
    static let edit_service_hours_and_others = Server.live + "edit-service-hours-and-others"
    
    static let booking_history_details_landscaper = Server.live + "booking-history-details-landscaper"
    
    static let landscaper_booking_history = Server.live + "landscaper-booking-history"
    
    static let subscribe = Server.live + "subscribe"
    
    static let landscaper_chat_list = Server.live + "landscaper-chat-list"
    
    
    
    static let static_image = Server.live2 + "uploads/services/7692_1518190108_feature-image-big.jpg"
    
    static let view_paypal_account = Server.live + "view-paypal-account"
    
    static let add_paypal_account = Server.live + "add-paypal-account"
    
    static let delete_paypal_account = Server.live + "delete-paypal-account"
    
    static let view_transaction_history = Server.live + "view-transaction-history"
    
    static let end_job_landscaper = Server.live + "end-job-landscaper"
    
    static let notification_list_landscaper = Server.live + "notification-list-landscaper"
    
    static let emailCheck = Server.live + "emailCheck"
    
    static let otpCheck = Server.live + "otpCheck"
    
    static let new_password = Server.live + "new-password"
    
     static let get_faq = Server.live + "get_faq"
    
    
}

class Service: NSObject {
    
    enum ResponseType {
		
	//	case addOneSignalId
        case login
        case register
//        case forgotPassword
//        case countries
//        case emailAvailability
//        case validateSessionKey
//        case verifyCode
//        case resendCode
//        case leagues
//        case setSoccerPreference
//        case deleteSoccerPrefernce
//        case team
//        case selectChampion
//        case getPreferredLeagues
//        case setNewsPreference
//        case getUserNews
//        case getProfile
//        case feedback
//        case contact
//        case privacyPolicy
//        case getUserTeams
//        case setUserPrediktWinLoss
//        case updateUserProfile
//        case changePassword
//        case getToken
//        case hasPredikted
//        case getWeeklyMatches
//        case setMultiSoccerPreference
//        case getNewsPreference
//        case searchFriends
//        case existingSearchFriends
//        case sentFriends
//        case receivedFriends
//        case friends
//        case addFriend
//        case confirmFriend
//        case removeFriend
//        case upcomingEvents
//        case notifyMe
//        case getMyWins
//        case getWinsSport
//        case getCurrentWeek
//        case getEntertainment
		
    }
    
    class func request(url: String, method: HTTPMethod, parameters: Parameters?, displayLoader: Bool, loaderMessage: String?, resposneType: ResponseType, completion:@escaping (_ response: Any) -> Void) {
        
        let reachability = Reachability()
        
        if (reachability?.isReachable)! {
            
            if displayLoader {
				DispatchQueue.main.async {
					if loaderMessage == nil {
						SVProgressHUD.setDefaultStyle(.light)
						SVProgressHUD.setDefaultMaskType(.gradient)
						SVProgressHUD.show()
					} else {
						SVProgressHUD.setDefaultStyle(.light)
						SVProgressHUD.setDefaultMaskType(.gradient)
						SVProgressHUD.show(withStatus: loaderMessage)
					}
				}
            }
            
            Alamofire.request(URL(string: url)!, method: method, parameters: parameters, encoding: URLEncoding.default).responseJSON(completionHandler: { (response) in
                
                SVProgressHUD.dismiss()
                
                switch response.result {
                    
                case .success(let json):
                    
                    switch resposneType {
						
			
                        
                    case .login:
                        let login = Login_data.init(object: json)
                        completion(login)
                        
                    case .register:
                        let reg = Reg_data.init(object: json)
                        completion(reg)
                    
						
                   
                    }
                    break
					
                case .failure(let error):
					
					if error.localizedDescription != "cancelled" {
						showError(with: error.localizedDescription)
					}
					
                    print("Webservice Error - \(error.localizedDescription)")
					print("URL - \(url)")
                    
                    break
                }
            })
            
        } else {
            print("Internet connection not available")
			showInfo(with: "Internet connection not available")
        }
    }
	
	class func cancelRequests() {
		Alamofire.SessionManager.default.session.getAllTasks(completionHandler: { (task) in
			task.forEach { $0.cancel() }
		})
	}
	
}
