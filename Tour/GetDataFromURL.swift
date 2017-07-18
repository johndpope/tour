//
//  GetDataFromURL.swift
//  Tour
//
//  Created by tnt on 6/1/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import Foundation
class GetDataFromURL {
    static var URL : String = "http://tour.xekia.vn:1111"
    static var URL_IMAGE : String = "http://tour.xekia.vn:1111/"
    static var URL_GOOGLE_API_ADDRESS : String = "http://maps.googleapis.com/maps/api/geocode/json?language=vi"
    //static var URL : String = "http://115.74.177.1:1111/"
    static var URL_LOGIN : String = URL + "/users/login"
    static var URL_USEROFTOUR_LOGIN : String = URL + "/useroftours/login"
    static var URL_REGISTER : String = URL + "/users/register"
    static var URL_CHANGE_PASSWORD : String = URL + "/users/changepassword"
    static var URL_LOGOUT : String =  URL + "/users/logout"
    static var URL_UPDATE_USER : String = URL + "/users/updateinfouser"
    static var URL_UPLOAD_IMAGE : String = URL + "/upload"
    static var URL_CREATE_TOUR : String = URL + "/tours/setup"
    static var URL_GET_TOUR : String = URL + "/tours/get"
    static var URL_GET_ALL_TOUR : String = URL + "/tours/getall"
    static var URL_TOUR_UPDATE : String = URL + "/tours/update"
    static var URL_CREATE_USEROFTOUR : String = URL + "/useroftours/create"
    static var URL_REMOVE_USEROFTOUR : String = URL + "/useroftours/remove"
    static var URL_UPDATE_USEROFTOUR : String = URL + "/useroftours/update"
    static var URL_CREATE_SCHEDULES : String = URL + "/schedules/create"
    static var URL_REMOVE_SCHEDULES : String = URL + "/schedules/remove"
    static var URL_UPDATE_SCHEDULES : String = URL + "/schedules/update"
    static var URL_SEND_MESSAGES : String = URL +  "/messages/send"
    static var URL_USEROFTOUR_LOGOUT : String = URL + "/useroftours/logout"
    static var URL_USEROFTOUR_GET_TOUR : String = URL + "/tours/get/useroftour"
    static var URL_USEROFTOUR_CHANGE_PASSWORD : String = URL + "/useroftours/changepassword"
    static var URL_USEROFTOUR_UPDATE_USER : String = URL + "/useroftours/updateinfouser"
    static var URL_CHAT_GROUP_HISTORY : String  = URL + "/messages/getmessagetour"
    static var URL_CHAT_USER_HISTORY : String = URL + "/messages/getmessageuser"
    static var URL_GET_1_TOUR : String = URL + "/tours/getall/idtour"
    static var URL_GET_USER_COMPANY : String = URL + "/users/getAllUser/Company/nolock"
    static var URL_GET_USER_EPAC : String = URL + "/users/getAllUser/Company/byusers"
    static var URL_LIKE_USER_COMPANY : String = URL + "/users/update/like"
    static var URL_GET_TOUR_DETAIL : String = URL + "/tours/getall/tour/byuser"
    static var URL_FIND_TOUR_DETAIL : String = URL + "/tours/find"
    static var URL_GET_ASSIGNMENT_COMPANY : String = URL + "/assignmentuser/getassignment"
    static var URL_GET_ASSIGNMENT_NUMSTART : String = URL + "/assignmentuser/getassignmentnumsart"
    static var URL_GET_ASSIGNMENT_CHECK : String = URL + "/assignmentuser/checkassignmentnumstart"
    static var URL_ADD_ASSIGNMENT : String = URL + "/assignmentuser/addassignment"
    static var URL_GET_ALL_TOUR_USEROFTOUR : String = URL + "/tours/getall/useroftour"
    static var URL_UPDATE_LOCATION_USER : String = URL + "/users/updateinfouser_user"
    static var URL_GET_ALL_USEROFTOUR_OF_TOUR : String = URL + "/useroftours/get"
    static var URL_PUSH_REPORT : String = URL + "/pushdata/send/report/admin"
    static var URL_GET_ACTIVITIESIMAGE : String = URL + "/activityimages/getallbyuser"
    static var URL_GET_EMPLOYEE : String = URL + "/roleemployee/getuserbyiduser"
    static var URL_GET_LIST_LAST_MESSAGE : String = URL + "/messages/getlastmessagebyuser"	
}
