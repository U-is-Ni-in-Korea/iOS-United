//
//  AccountTitle.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/14.
//

struct AccountTitle {
    let title: String
}

extension AccountTitle{
    
    static func accountTitleList() -> [AccountTitle] {
        return [AccountTitle(title: "로그아웃"),
                AccountTitle(title: "계정 탈퇴"),
                AccountTitle(title: "커플 연결 해제")
                ]
    }
}
