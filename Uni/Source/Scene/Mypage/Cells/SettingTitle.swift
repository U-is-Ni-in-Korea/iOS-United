//
//  Setting.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/14.
//

struct SettingTitle {
    //let image: UIImage
    let title: String
}

extension SettingTitle{
    
    static func settingTitleList() -> [SettingTitle] {
        return [SettingTitle(title: "계정"),
                SettingTitle(title: "서비스 이용약관"),
                SettingTitle(title: "개인정보 처리 방침"),
                SettingTitle(title: "오픈소스 라이브러리"),
                SettingTitle(title: "개발자 정보")
                ]
    }
}
