//
//  MyPageTitle.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/14.
//

struct MyPageTitle {
    let title: String
}

extension MyPageTitle {

    static func myPageTitleList() -> [MyPageTitle] {
        return [MyPageTitle(title: "계정"),
                MyPageTitle(title: "서비스 이용약관"),
                MyPageTitle(title: "개인정보 처리 방침"),
                MyPageTitle(title: "오픈소스 라이브러리"),
                MyPageTitle(title: "개발자 정보")
                ]
    }
}
