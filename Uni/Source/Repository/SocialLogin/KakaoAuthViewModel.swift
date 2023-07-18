//
//  KakaoAuthViewModel.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/17.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser


//class KakaoAuthViewModel {
//    let authRepository = AuthRepository()
//    init() {
//        print("KakaoAUthVM - init()")
//    }
//    
//    // MARK: - 로그인
//    func hanldeKakaoLogin(completion: @escaping ((String) -> Void)) {
//        print("KakaoAuthVM - handleKakaoLogin() called()")
//        //카카오톡 설치 여부 확인
//        if (UserApi.isKakaoTalkLoginAvailable()) {
//            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                if let error = error {
//                    print(error)
//                }
//                else {
//                    if let oauthToken = oauthToken {
//                        completion(oauthToken.accessToken)
//                        print(oauthToken.accessToken)
//                    }
//                }
//            }
//        } else { //카카오톡이 설치가 안되어있으면
//            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
//                    if let error = error {
//                        print(error)
//                    }
//                    else {
//                        _ = oauthToken
//                        if let oauthToken = oauthToken {
//                            completion(oauthToken.accessToken)
//                            print(oauthToken.accessToken)
//                        }
//                    }
//                }
//        }
//    }
//    // MARK: - 로그아웃
//    func kakaoLogOut() {
//        UserApi.shared.logout {(error) in
//            if let error = error {
//                print(error)
//            }
//            else {
//                print("logout() success.")
//            }
//        }
//    }
//}
//
