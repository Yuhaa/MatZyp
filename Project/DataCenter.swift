//
//  DataCenter.swift
//  MatZyp
//
//  Created by hyu on 2016. 11. 1..
//  Copyright © 2016년 CodersHigh. All rights reserved.
//

import Foundation
import UIKit

enum Language{
    case korean
    case chinese
    case english
}

class Setting{
    var lang:Language
    
    init(lang:Language) {
        self.lang = lang
    }
    
    func setLanguage(set_lang:Language){
        lang = set_lang
    }
    
    func getLanguage() -> Language {
        return lang
    }
}

class Location{
    var name: [Language:String]
    var matzyps :[Matzyp]?
    
    init (name:[Language:String]) {
        self.name = name
    }
}
class Matzyp {
    var name : [Language : String]
    var number : String
    var region : String
    var location : String
    var latitude : Double
    var longitude : Double
    var homepage : String?
    var business_hour : String
    var main_img: UIImage?
    var img : UIImage?
    var menus : [Menu]? //Menu class
    var rate : Double = 0.0
    var reviews: [Review] = []
    
    init(name:[Language:String]) {
        self.name = name
        self.number = ""
        self.location = ""
        self.business_hour = ""
        self.region = ""
        self.latitude = 0.0
        self.longitude = 0.0
    }
    
    init(name : [Language : String], number : String, location : String, homepage : String,
         business_hour : String, main_img: UIImage?,img : UIImage?) {
        self.name = name
        self.number = number
        self.location = location
        self.homepage = homepage
        self.business_hour = business_hour
        
        if let main_image = main_img, let image = img {
            self.main_img = main_image
            self.img = image
        } else {
            self.main_img = nil
            self.img = nil
        }
        //menu_ = menu
        self.region = ""
        self.latitude = 0.0
        self.longitude = 0.0
    }
    
    /* Calculate current rate
    */
    func GetRate() {
        var temp = 0.0
        for i in self.reviews {
            temp += i.rate
        }
        
        self.rate = temp / Double(self.reviews.count)
    }
    
    func setLang (lang:Int)
    {
        
    }
}

class Menu {
    var name :[Language:String]
    var price:Int
    let img: UIImage?
    init(name:[Language:String], price:Int, img: UIImage?) {
        self.name = name
        self.price = price
        if let image = img {
            self.img = image
        } else {
            self.img = nil
        }
        
    }
}

class Review {
    var id: String
    var name: String
    var text: [Language : String]
    var date: String
    var rate: Double
    var image: UIImage?
    
    init() {
        self.id = ""
        self.name = ""
        self.text = [ : ]
        let format = DateFormatter()
        format.locale = NSLocale(localeIdentifier: "ko_kr") as Locale!
        format.timeZone = NSTimeZone(name: "KST") as TimeZone!
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.date = format.string(from: NSDate() as Date)
        self.rate = 0.0
    }
}

class User {
    var id: String
    var name: String
    var profileImage: UIImage?
    
    init() {
        self.id = ""
        self.name = ""
    }
}
let dataCenter:DataCenter = DataCenter()
class DataCenter {
    var setting:Setting
    var locations:[Location] = []
    let hanyangChone:Matzyp
    let alchone:Matzyp
    let daedosikttang:Matzyp
    let gwangMoon:Matzyp
    //let koreaSamgye:Matzyp
    
    let robotkimbab:Matzyp
    let sonyeonsanghoi:Matzyp
    let daegalzip:Matzyp
    
    let samsungred:Matzyp
    let sinanchon:Matzyp
    
    let surakio:Matzyp
    let termini:Matzyp
    let chammanna:Matzyp
    
    let haematea:Matzyp
    let bomgas:Matzyp
    let sogumi:Matzyp
    
    let hamnam:Matzyp
    let northsea:Matzyp
    let cryroad:Matzyp
    
    let redsun:Matzyp
    let mpizza:Matzyp
    
    let ioknyeo:Matzyp
    let tianpan:Matzyp
    
    
    
    var user: User?
    init() {
        let hanyangChone_menu1 = Menu(name: [.korean:"고추장불고기",.english:"Spicy bulgogi",.chinese:"辣椒酱烤肉"], price: 5500, img: UIImage(named: "gochu"))
        let hanyangChone_menu2 = Menu(name: [.korean:"순두부찌개",.english:"Soft tofu stew",.chinese:"豆腐脑"], price: 5000, img: UIImage(named: "soon"))
        let hanyangChone_menu3 = Menu(name: [.korean:"된장찌개",.english:"Bean paste stew",.chinese:"大酱汤"], price: 5000, img: UIImage(named: "miso"))
        let alchone_menu1 = Menu(name: [.korean:"알밥",.english:"Rice with fish roe",.chinese:"鱼籽饭"], price: 3800, img: UIImage(named: "eggrice"))
        let alchone_menu2 = Menu(name: [.korean:"치즈알밥",.english:"Rice with fish roe and cheese",.chinese:"奶酪鱼籽饭"], price: 4500, img: UIImage(named: "cheggrice"))
        
        let daedo_menu1 = Menu(name: [.korean:"한우생등심(250g)",.english:"Beef Sirloin",.chinese:"韩式牛里脊肉"], price: 38500, img: UIImage(named: "daedo_koreaCow"))
        let daedo_menu2 = Menu(name: [.korean:"깍두기볶음밥",.english:"Radish kimchi fried rice", .chinese:"萝卜泡菜炒饭"], price: 3000, img: UIImage(named: "daedo_ggakdugi"))
        let daedo_menu3 = Menu(name: [.korean:"된장죽", .english:"Bean paste rice porridge", .chinese:"大酱稀饭"], price: 3000, img: UIImage(named: "daedo_m3"))
        
        let gwangMoon_menu1 = Menu(name: [.korean:"돼지김치찌개",.english:"Pork kimchi stew",.chinese:"猪肉泡菜汤"], price: 7000, img: UIImage(named:"gwangMoon_kimchi"))
        let gwangMoon_menu2 = Menu(name: [.korean:"제육볶음",.english:"Jeyuk bokkeum",.chinese:"辣炒猪肉"], price: 10000, img: UIImage(named:"gwangMoon_jeyouk"))
        let gwangMoon_menu3 = Menu(name: [.korean:"계란말이",.english:"Rolled Omelet",.chinese:"鸡蛋卷"], price: 5000, img: UIImage(named:"gwangMoon_gyeran"))
        let gwangMoon_menu4 = Menu(name: [.korean:"공기밥",.english:"Rice",.chinese:"饭"], price: 1000, img: UIImage(named:"rice"))
        
        let robotgimbap_menu1 = Menu(name: [.korean:"매콤제육김밥",.english:"Spicy Gimbap with Pork",.chinese:"紫菜饭一起吃辣味"], price: 4000, img: UIImage(named:"robotgimbap_menu1"))
        let robotgimbap_menu2 = Menu(name: [.korean:"로봇치즈라볶이",.english:"Robot Cheese stir-fried Rice Cake with Noodles",.chinese:"机器人的奶酪炒年糕"], price: 5800, img: UIImage(named:"robotgimbap_menu2"))
        let robotgimbap_menu3 = Menu(name: [.korean:"알래스카크림치즈김밥",.english:"Alaska Cream Cheese Gimbap",.chinese:"阿拉斯加 芝士 紫菜卷饭"], price: 3800, img: UIImage(named:"robotgimbap_menu3"))
        
        let sonyeonsanhoi_menu1 = Menu(name: [.korean:"지중해크림파스타",.english:"the Mediterranean Cream Pasta",.chinese:"奶油意大利面地中海"], price: 12000, img: UIImage(named:"sonyeonsanhoi_menu1"))
        let sonyeonsanhoi_menu2 = Menu(name: [.korean:"치킨올리오파스타",.english:"Chicken Olio Pasta",.chinese:"橄榄炸鸡面条"], price: 12000, img: UIImage(named:"sonyeonsanhoi_menu2"))
        let sonyeonsanhoi_menu3 = Menu(name: [.korean:"신나는여름바캉스샐러드",.english:"Happy Summer Vacation Sallad",.chinese:"充满激情的夏日度假沙拉"], price: 21000, img: UIImage(named:"sonyeonsanhoi_menu3"))
        
        let daegalzip_menu1 = Menu(name: [.korean:"갈비된장",.english:"Ribs of soybean paste",.chinese:"排骨酱"], price: 7000, img: UIImage(named:"daegalzip_menu1"))
        let daegalzip_menu2 = Menu(name: [.korean:"게장정식",.english:"Set Menu with Marinated Crab",.chinese:"蟹酱正式"], price: 7000, img: UIImage(named:"daegalzip_menu2"))
        let daegalzip_menu3 = Menu(name: [.korean:"왕소갈비",.english:"Large Beef Ribs",.chinese:"大牛排"], price: 15000, img: UIImage(named:"daegalzip_menu3"))
        
        let samsungred_menu1 = Menu(name: [.korean:"냉동동그랑땡",.english:"Freezing Korea style Meatball",.chinese:"韩式肉饼冷冻"], price: 5500, img: UIImage(named:"samsungred_menu1"))
        let samsungred_menu2 = Menu(name: [.korean:"생고기주물럭",.english:"Raw meat jumulleok",.chinese:"肉拌菜"], price: 6000, img: UIImage(named:"samsungred_menu2"))
        
        let sinanchon_menu1 = Menu(name: [.korean:"민어회",.english:"Croaker fish",.chinese:"生鱼片𩾃"], price: 130000, img: UIImage(named:"sinanchon_menu1"))
        let sinanchon_menu2 = Menu(name: [.korean:"홍어삼합",.english:"Fermented Skate and Steamed Pork Slices Served with Kimchi",.chinese:"斑鳐三合"], price: 70000, img: UIImage(named:"sinanchon_menu2"))
        let sinanchon_menu3 = Menu(name: [.korean:"낙지꾸리",.english:"small octopus",.chinese:"长蛸团"], price: 55000, img: UIImage(named:"sinanchon_menu3"))
        
        let surakio_menu1 = Menu(name: [.korean:"비빔냉면",.english:"Spicy Buckwheat Noodles",.chinese:"拌冷面"], price: 5000, img: UIImage(named:"surakio_menu1"))
        let surakio_menu2 = Menu(name: [.korean:"왕만두",.english:" King-sized Dumplings",.chinese:"大馅包子"], price: 6000, img: UIImage(named:"surakio_menu2"))
        let surakio_menu3 = Menu(name: [.korean:"왕돈까스",.english:"Large Pork Cutlet",.chinese:"大炸猪排"], price: 5500, img: UIImage(named:"surakio_menu3"))
        
        let termini_menu1 = Menu(name: [.korean:"카프레제샐러드",.english:"A salad of Khafre",.chinese:"Khafre 沙拉"], price: 14700, img: UIImage(named:"termini_menu1"))
        let termini_menu2 = Menu(name: [.korean:"날치알크림(1인)",.english:"Flying Fish Roe Spaghetti with Cream Sauce",.chinese:"飞鱼子奶油"], price: 13900, img: UIImage(named:"termini_menu2"))
        let termini_menu3 = Menu(name: [.korean:"루꼴라",.english:"Arugula",.chinese:"芝麻菜"], price: 17700, img: UIImage(named:"termini_menu3"))
        
        let chammanna_menu1 = Menu(name: [.korean:"스페샬모듬소한판",.english:"Special Assorted cow",.chinese:"韩式牛烧烤拼盘"], price: 130000, img: UIImage(named:"chammanna_menu1"))
        let chammanna_menu2 = Menu(name: [.korean:"옛날전통불고기",.english:"Old traditional Bulgogi",.chinese:"传统烤肉"], price: 15000, img: UIImage(named:"chammanna_menu2"))
        let chammanna_menu3 = Menu(name: [.korean:"돼지왕갈비",.english:"Premium Grilled Spareribs",.chinese:"特大猪排"], price: 16000, img: UIImage(named:"chammanna_menu3"))
        
        let haematea_menu1 = Menu(name: [.korean:"가향홍차_복숭아",.english:"Peach black tea",.chinese:"桃茶"], price: 6000, img: UIImage(named:"haematea_menu1"))
        let haematea_menu2 = Menu(name: [.korean:"갸또 쇼콜라",.english:"Gateau Chocolate",.chinese:"Gateau Chocolat"], price: 3800, img: UIImage(named:"haematea_menu2"))
        let haematea_menu3 = Menu(name: [.korean:"인디안베이직밀크티",.english:"Indian Basic Milktea",.chinese:"印度奶茶基本"], price: 7000, img: UIImage(named:"haematea_menu3"))
        
        let bomgas_menu1 = Menu(name: [.korean:"치즈까스",.english:"Cheese Pork Cutlet",.chinese:"奶酪炸猪排"], price: 7000, img: UIImage(named:"bomgas_menu1"))
        let bomgas_menu2 = Menu(name: [.korean:"고감자롤",.english:"Potato Roll",.chinese:"马铃薯:卷"], price: 7500, img: UIImage(named:"bomgas_menu2"))
        let bomgas_menu3 = Menu(name: [.korean:"알밥",.english:"Rice with Fish Roe",.chinese:"鱼子饭"], price: 5000, img: UIImage(named:"bomgas_menu3"))
        
        let sogumi_menu1 = Menu(name: [.korean:"치마살",.english:"",.chinese:""], price: 150000, img: UIImage(named:"sogumi_menu1"))
        let sogumi_menu2 = Menu(name: [.korean:"육회",.english:"",.chinese:""], price: 30000, img: UIImage(named:"sogumi_menu2"))
        let sogumi_menu3 = Menu(name: [.korean:"갈비살",.english:"",.chinese:""], price: 12000, img: UIImage(named:"sogumi_menu3"))
        
        let hamnam_menu1 = Menu(name: [.korean:"알곱창",.english:"",.chinese:""], price: 8000, img: UIImage(named:"hamnam_menu1"))
        let hamnam_menu2 = Menu(name: [.korean:"막창구이",.english:"",.chinese:""], price: 11000, img: UIImage(named:"hamnam_menu2"))
        let hamnam_menu3 = Menu(name: [.korean:"순대곱창",.english:"",.chinese:""], price: 8000, img: UIImage(named:"hamnam_menu3"))
        
        let northsea_menu1 = Menu(name: [.korean:"눈꽃 커피",.english:"",.chinese:""], price: 6500, img: UIImage(named:"northsea_menu1"))
        let northsea_menu2 = Menu(name: [.korean:"카페드사이공",.english:"",.chinese:""], price: 5200, img: UIImage(named:"northsea_menu2"))
        let northsea_menu3 = Menu(name: [.korean:"눈꽃우유빙수",.english:"",.chinese:""], price: 6000, img: UIImage(named:"northsea_menu3"))
        
        let cryroad_menu1 = Menu(name: [.korean:"커틀렛",.english:"",.chinese:""], price: 9000, img: UIImage(named:"cryroad_menu1"))
        let cryroad_menu2 = Menu(name: [.korean:"만두",.english:"",.chinese:""], price: 8000, img: UIImage(named:"cryroad_menu2"))
        let cryroad_menu3 = Menu(name: [.korean:"국수",.english:"",.chinese:""], price: 7000, img: UIImage(named:"cryroad_menu3"))
        
        let redsun_menu1 = Menu(name: [.korean:"야끼만두사리",.english:"",.chinese:""], price: 1000, img: UIImage(named:"redsun_menu1"))
        let redsun_menu2 = Menu(name: [.korean:"순대볶음세트",.english:"",.chinese:""], price: 12000, img: UIImage(named:"redsun_menu2"))
        
        let mpizza_menu1 = Menu(name: [.korean:"크레마 감베리 펜네",.english:"",.chinese:""], price: 14500, img: UIImage(named:"mpizza_menu1"))
        let mpizza_menu2 = Menu(name: [.korean:"디아볼라 피자",.english:"",.chinese:""], price: 18000, img: UIImage(named:"mpizza_menu2"))
        let mpizza_menu3 = Menu(name: [.korean:"뽀빠이 피자",.english:"",.chinese:""], price: 17500, img: UIImage(named:"mpizza_menu3"))
        
        let ioknyeo_menu1 = Menu(name: [.korean:"전통팥빙수",.english:"",.chinese:""], price: 7500, img: UIImage(named:"ioknyeo_menu1"))
        let ioknyeo_menu2 = Menu(name: [.korean:"우유팥빙수",.english:"",.chinese:""], price: 7000, img: UIImage(named:"ioknyeo_menu2"))
        let ioknyeo_menu3 = Menu(name: [.korean:"녹차빙수",.english:"",.chinese:""], price: 8000, img: UIImage(named:"ioknyeo_menu3"))
        
        let tianpan_menu1 = Menu(name: [.korean:"치즈케이크",.english:"",.chinese:""], price: 6600, img: UIImage(named:"tianpan_menu1"))
        let tianpan_menu2 = Menu(name: [.korean:"아이스 러시안티",.english:"",.chinese:""], price: 6600, img: UIImage(named:"tianpan_menu2"))
        let tianpan_menu3 = Menu(name: [.korean:"블랙퍼스트",.english:"",.chinese:""], price: 6600, img: UIImage(named:"tianpan_menu3"))
        
        //let koreaSamgye_menu1 = Menu(name: [.korean:"고려삼계탕", .english:"Corean S"], price: <#T##Int#>, img: <#T##UIImage?#>)
        
        
        hanyangChone = Matzyp(name: [.korean:"한양촌",.english:"Hanyangchon",.chinese:"汉阳村"])
        hanyangChone.main_img = UIImage(named: "hanyangchone_main")
        hanyangChone.img = UIImage(named: "hanyangchone_sub")
        hanyangChone.region = "성동구/왕십리"
        hanyangChone.location = "서울특별시 성동구 사근동 177-2"
        hanyangChone.business_hour = "09:00 ~ 19:00"
        hanyangChone.number = "02 - 123 - 4567"
        hanyangChone.latitude = 37.5602679
        hanyangChone.longitude = 127.04684799999995
        hanyangChone.homepage = "www.abc.com"
        
        alchone = Matzyp(name: [.korean:"알촌",.english:"Alchon",.chinese:"알촌"])
        alchone.main_img = UIImage(named: "alchone_main")
        alchone.img = UIImage(named: "alchone_sub")
        alchone.region = "성동구/왕십리"
        alchone.location = "서울시 성동구 행당동 19-112"
        alchone.business_hour = "09:00 ~ 21:00"
        alchone.number = "02 - 2292 - 8885"
        alchone.latitude = 37.5585529
        alchone.longitude = 127.04014669999992
        alchone.homepage = "www.alchone.co.kr"
        
        daedosikttang = Matzyp(name: [.korean:"대도식당", .english:"Daedosikttang", .chinese:"大都食堂"])
        daedosikttang.main_img = UIImage(named: "daedo_main" )
        daedosikttang.img = UIImage(named: "daedo_sub")
        daedosikttang.region = "성동구/왕십리"
        daedosikttang.location = "서울 성동구 홍익동 431"
        daedosikttang.business_hour = "11:00 - 22:30"
        daedosikttang.number = "02-2292-9772"
        daedosikttang.latitude = 37.5674710
        daedosikttang.longitude = 127.0306740
        daedosikttang.homepage = "www"
        
        gwangMoon = Matzyp(name: [.korean:"광화문집",.english:"Gwanghwamunjip", .chinese:"矿化文集"])
        gwangMoon.main_img = UIImage(named: "gwangMoon_main")
        gwangMoon.img = UIImage(named: "gwangMoon_sub")
        gwangMoon.region = "광화문/시청"
        gwangMoon.location = "서울 종로구 새문안로5길 12"
        gwangMoon.business_hour = "09:00 - 22:00"
        gwangMoon.number = "02-739-7737"
        gwangMoon.latitude = 37.5713350
        gwangMoon.longitude = 126.9749740
        gwangMoon.homepage = "www"
        
        robotkimbab = Matzyp(name: [.korean:"로봇김밥",.english:"Robot Gimbap", .chinese:"机器人 紫菜包饭"])
        robotkimbab.main_img = UIImage(named: "robotgimbap_main")
        robotkimbab.img = UIImage(named: "robotgimbap_sub")
        robotkimbab.region = "광진/건대입구"
        robotkimbab.location = "서울 광진구 동일로20길 68"
        robotkimbab.business_hour = "10:30 - 21:30"
        robotkimbab.number = "02-462-1151"
        robotkimbab.latitude = 37.540513
        robotkimbab.longitude = 127.067215
        robotkimbab.homepage = "http://blog.naver.com/mj5094"
        
        sonyeonsanghoi = Matzyp(name: [.korean:"소년상회",.english:"The Boy Merchant Association", .chinese:"少年商会"])
        sonyeonsanghoi.main_img = UIImage(named: "sonyeonsanhoi_main")
        sonyeonsanghoi.img = UIImage(named: "sonyeonsanhoi_sub")
        sonyeonsanghoi.region = "광진/건대입구"
        sonyeonsanghoi.location = "서울 광진구 자양3동 783-1"
        sonyeonsanghoi.business_hour = "18:00 - 01:30"
        sonyeonsanghoi.number = "02-3437-5669"
        sonyeonsanghoi.latitude = 37.534126
        sonyeonsanghoi.longitude = 127.075056
        sonyeonsanghoi.homepage = ""
        
        daegalzip = Matzyp(name: [.korean:"대갈집",.english:"Big GrilledRib House", .chinese:"大排骨家"])
        daegalzip.main_img = UIImage(named: "daegalzip_main")
        daegalzip.img = UIImage(named: "daegalzip_sub")
        daegalzip.region = "광진/건대입구"
        daegalzip.location = "서울 광진구 자양동 550-1"
        daegalzip.business_hour = "11:00 - 23:00"
        daegalzip.number = "02-463-2702"
        daegalzip.latitude = 37.536056
        daegalzip.longitude = 127.068401
        daegalzip.homepage = ""
        
        samsungred = Matzyp(name: [.korean:"삼성빨간양념",.english:"Samsung RedSource", .chinese:"三星的调料"])
        samsungred.main_img = UIImage(named: "samsungred_main")
        samsungred.img = UIImage(named: "samsungred_sub")
        samsungred.region = "광화문/시청"
        samsungred.location = "서울 중구 북창동 19-2"
        samsungred.business_hour = "11:00 - 23:00"
        samsungred.number = "02-752-6449"
        samsungred.latitude = 37.562943
        samsungred.longitude = 126.977139
        samsungred.homepage = ""
        
        sinanchon = Matzyp(name: [.korean:"신안촌",.english:"Sinan Village", .chinese:"新安村"])
        sinanchon.main_img = UIImage(named: "sinanchon_main")
        sinanchon.img = UIImage(named: "sinanchon_sub")
        sinanchon.region = "광화문/시청"
        sinanchon.location = "서울 종로구 내자동 152"
        sinanchon.business_hour = "11:30 - 22:00"
        sinanchon.number = "02-725-7744"
        sinanchon.latitude = 37.575536
        sinanchon.longitude = 126.970842
        sinanchon.homepage = ""
        
        surakio = Matzyp(name: [.korean:"수락이오냉면",.english:"Surak Cold Noodle", .chinese:"木卫一冷面接受"])
        surakio.main_img = UIImage(named: "surakio_main")
        surakio.img = UIImage(named: "surakio_sub")
        surakio.region = "노원/도봉/미아"
        surakio.location = "서울 노원구 상계1동 1048-10 창일빌딩"
        surakio.business_hour = "10:00 - 21:00"
        surakio.number = "02-935-2515"
        surakio.latitude = 37.673756
        surakio.longitude = 127.052487
        surakio.homepage = ""
        
        termini = Matzyp(name: [.korean:"테르미니",.english:"Termini", .chinese:"泰尔米尼"])
        termini.main_img = UIImage(named: "termini_main")
        termini.img = UIImage(named: "termini_sub")
        termini.region = "노원/도봉/미아"
        termini.location = "서울 노원구 공릉동 27-20 아리아스"
        termini.business_hour = "11:00 ~ 22:00"
        termini.number = "02-972-0036"
        termini.latitude = 37.626402
        termini.longitude = 127.094174
        termini.homepage = ""
        
        chammanna = Matzyp(name: [.korean:"참만나",.english:"SoDelicios", .chinese:"很有味道"])
        chammanna.main_img = UIImage(named: "chammanna_main")
        chammanna.img = UIImage(named: "chammanna_sub")
        chammanna.region = "노원/도봉/미아"
        chammanna.location = "서울 노원구 공릉동 670-6"
        chammanna.business_hour = "10:00 ~ 24:00"
        chammanna.number = "02-974-1500"
        chammanna.latitude = 37.618171
        chammanna.longitude = 127.076232
        chammanna.homepage = ""
        
        haematea = Matzyp(name: [.korean:"해마티룸",.english:"HEMA TeaRoom", .chinese:"HEMA 茶馆"])
        haematea.main_img = UIImage(named: "haematea_main")
        haematea.img = UIImage(named: "haematea_sub")
        haematea.region = "대학로"
        haematea.location = "서울 종로구 혜화동 87-5"
        haematea.business_hour = "11:00 ~ 22:00"
        haematea.number = "02-742-7222"
        haematea.latitude = 37.586369
        haematea.longitude = 127.001591
        haematea.homepage = ""
        
        bomgas = Matzyp(name: [.korean:"봄까스",.english:"Spring Pork Cutlet", .chinese:"春天 炸猪排"])
        bomgas.main_img = UIImage(named: "bomgas_main")
        bomgas.img = UIImage(named: "bomgas_sub")
        bomgas.region = "대학로"
        bomgas.location = "서울 종로구 명륜2가 135-3"
        bomgas.business_hour = "10:30 ~ 21:30"
        bomgas.number = "02-747-7080"
        bomgas.latitude = 37.584569
        bomgas.longitude = 126.996958
        bomgas.homepage = ""
        
        sogumi = Matzyp(name: [.korean:"소구미",.english:"Sogumi", .chinese:"牛烤美"])
        sogumi.main_img = UIImage(named: "sogumi_main")
        sogumi.img = UIImage(named: "sogumi_sub")
        sogumi.region = "대학로"
        sogumi.location = "서울 종로구 명륜4가 77-1"
        sogumi.business_hour = "15:00 ~ 03:00"
        sogumi.number = "02-763-1700"
        sogumi.latitude = 37.582283
        sogumi.longitude = 127.000126
        sogumi.homepage = ""
        
        
        hamnam = Matzyp(name: [.korean:"함남곱창",.english:"Hamnam grilled beef intestines.", .chinese:"咸南牛小肠"])
        hamnam.main_img = UIImage(named: "hamnam_main")
        hamnam.img = UIImage(named: "hamnam_sub")
        hamnam.region = "동대문"
        hamnam.location = "서울 종로구 종로5가 246-5"
        hamnam.business_hour = "13:00 ~ 01:00"
        hamnam.number = "02-2278-2261"
        hamnam.latitude = 37.570176
        hamnam.longitude = 127.004890
        hamnam.homepage = ""
        
        northsea = Matzyp(name: [.korean:"북해빙수",.english:"the North Sea ice flakes with syrup", .chinese:"北海刨冰"])
        northsea.main_img = UIImage(named: "northsea_main")
        northsea.img = UIImage(named: "northsea_sub")
        northsea.region = "동대문"
        northsea.location = "서울 중구 흥인동 158-9"
        northsea.business_hour = "12:00 ~ 08:00"
        northsea.number = "02-2235-1005"
        northsea.latitude = 37.566609
        northsea.longitude = 127.014454
        northsea.homepage = ""
        
        cryroad = Matzyp(name: [.korean:"크라이로드노이",.english:"The Cry rodeunoi", .chinese:"克莱伊罗德老伊(音)"])
        cryroad.main_img = UIImage(named: "cryroad_main")
        cryroad.img = UIImage(named: "cryroad_sub")
        cryroad.region = "동대문"
        cryroad.location = "서울 중구 을지로6가 35-1"
        cryroad.business_hour = "09:00 ~ 22:00"
        cryroad.number = "02-2264-3980"
        cryroad.latitude = 37.565518
        cryroad.longitude = 127.005544
        cryroad.homepage = ""
        
        redsun = Matzyp(name: [.korean:"레드썬",.english:"Red Sun", .chinese:"红太阳"])
        redsun.main_img = UIImage(named: "redsun_main")
        redsun.img = UIImage(named: "redsun_sub")
        redsun.region = "명동"
        redsun.location = "서울 중구 명동2가 55-14"
        redsun.business_hour = "11:00 ~ 23:00"
        redsun.number = "02-2264-3980"
        redsun.latitude = 37.562837
        redsun.longitude = 126.983646
        redsun.homepage = "http://www.레드썬.com/"
        
        mpizza = Matzyp(name: [.korean:"명동피자",.english:"Myeongdong Pizza", .chinese:"明洞比萨"])
        mpizza.main_img = UIImage(named: "mpizza_main")
        mpizza.img = UIImage(named: "mpizza_sub")
        mpizza.region = "명동"
        mpizza.location = "서울 중구 충무로1가 22-2 우림빌딩 지하"
        mpizza.business_hour = "11:30 ~ 23:00"
        mpizza.number = "02-777-8979"
        mpizza.latitude = 37.562837
        mpizza.longitude = 126.983646
        mpizza.homepage = "http://www.myeongdongpizza.com"
        
        ioknyeo = Matzyp(name: [.korean:"이옥녀팥집",.english:"Small Beans House", .chinese:"红豆家"])
        ioknyeo.main_img = UIImage(named: "ioknyeo_main")
        ioknyeo.img = UIImage(named: "ioknyeo_sub")
        ioknyeo.region = "신촌/이대"
        ioknyeo.location = "서울 서대문구 대현동 110-26"
        ioknyeo.business_hour = "12:00 ~ 21:00"
        ioknyeo.number = "02-312-8293"
        ioknyeo.latitude = 37.558037
        ioknyeo.longitude = 126.942438
        ioknyeo.homepage = "http://www.okredbean.com"
        
        tianpan = Matzyp(name: [.korean:"티앙팡",.english:"Tiangpang", .chinese:"Tiangpang"])
        tianpan.main_img = UIImage(named: "tianpan_main")
        tianpan.img = UIImage(named: "tianpan_sub")
        tianpan.region = "신촌/이대"
        tianpan.location = "서울 서대문구 대현동 54-28"
        tianpan.business_hour = "12:00 ~ 23:00"
        tianpan.number = "02-364-4196"
        tianpan.latitude = 37.558207
        tianpan.longitude = 126.946065
        tianpan.homepage = ""
        
        hanyangChone.menus = [hanyangChone_menu1,hanyangChone_menu2,hanyangChone_menu3]
        alchone.menus = [alchone_menu1,alchone_menu2]
        daedosikttang.menus = [daedo_menu1, daedo_menu2, daedo_menu3]
        gwangMoon.menus = [gwangMoon_menu1,gwangMoon_menu2,gwangMoon_menu3,gwangMoon_menu4]
        robotkimbab.menus = [robotgimbap_menu1, robotgimbap_menu2, robotgimbap_menu3]
        sonyeonsanghoi.menus = [sonyeonsanhoi_menu1, sonyeonsanhoi_menu2, sonyeonsanhoi_menu3]
        daegalzip.menus = [daegalzip_menu1, daegalzip_menu2, daegalzip_menu3]
        samsungred.menus = [samsungred_menu1, samsungred_menu2]
        sinanchon.menus = [sinanchon_menu1, sinanchon_menu2, sinanchon_menu3]
        surakio.menus = [surakio_menu1, surakio_menu2, surakio_menu3]
        termini.menus = [termini_menu1, termini_menu2, termini_menu3]
        chammanna.menus = [chammanna_menu1, chammanna_menu2, chammanna_menu3]
        haematea.menus = [haematea_menu1, haematea_menu2, haematea_menu3]
        bomgas.menus = [bomgas_menu1, bomgas_menu2, bomgas_menu3]
        sogumi.menus = [sogumi_menu1, sogumi_menu2, sogumi_menu3]
        hamnam.menus = [hamnam_menu1, hamnam_menu2, hamnam_menu3]
        northsea.menus = [northsea_menu1, northsea_menu2, northsea_menu3]
        cryroad.menus = [cryroad_menu1, cryroad_menu2, cryroad_menu3]
        redsun.menus = [redsun_menu1, redsun_menu2]
        mpizza.menus = [mpizza_menu1, mpizza_menu2, mpizza_menu3]
        ioknyeo.menus = [ioknyeo_menu1, ioknyeo_menu2, ioknyeo_menu3]
        tianpan.menus = [tianpan_menu1, tianpan_menu2, tianpan_menu3]
        
        //let location1 = Location(name: [.korean:"왕십리",.english:"영_왕십리",.chinese:"중_왕십리"])
        //let location2 = Location(name: [.korean:"홍대",.english:"영_홍대",.chinese:"중_홍대"])
        //let location3 = Location(name: [.korean:"노원구",.english:"영_노원구",.chinese:"중_노원구"])
        //let location4 = Location(name: [.korean:"건대",.english:"영_건대",.chinese:"중_건대"])
        let location1 = Location(name: [.korean:"광진/건대입구",.english:"Gwangjin-gu/Konkuk Univ.",.chinese:"广津区/建国大学"])
        let location2 = Location(name: [.korean:"광화문/시청",.english:"Gwanghwamun/City Hall", .chinese:"光化门"])
        let location3 = Location(name: [.korean:"노원/도봉/미아",.english:"Nowon/Dobong-gu/Mia",.chinese:"芦原站/道峰站/弥阿站"])
        let location4 = Location(name: [.korean:"대학로", .english:"Daehangno", .chinese:"大学路"])
        let location5 = Location(name: [.korean:"동대문",.english:"Dongdaemun",.chinese:"东大门"])
        let location6 = Location(name: [.korean:"명동", .english:"Myeongdong", .chinese:"明洞"])
        let location7 = Location(name: [.korean:"신촌/이대",.english:"Sinchon/Ewha Womans Univ.",.chinese:"新村站/梨花女子大学"])
        let location8 = Location(name: [.korean:"성동구/왕십리",.english:"Seongdong-gu/Wangsimni", .chinese:"城东区/往十里"])
        let location9 = Location(name: [.korean:"종로", .english:"Jongno", .chinese:"钟路"])
        let location10 = Location(name: [.korean:"마포", .english:"Mapo", .chinese:"麻浦"])
        let location11 = Location(name: [.korean:"삼청동", .english:"Samcheong-dong", .chinese:"三清洞"])
        let location12 = Location(name: [.korean:"연남동/연희동", .english:"Yeonnam-dong/Yeonhui-dong", .chinese:"延南洞/延禧洞"])
        let location13 = Location(name: [.korean:"이태원/한남동", .english:"Itaewon/Hannam-dong", .chinese:"梨泰院/汉南洞"])
        let location14 = Location(name: [.korean:"홍대", .english:"Hongdae", .chinese:"弘益大学"])
        
        let location15 = Location(name: [.korean:"가로수길", .english:"Garosu-gil Road", .chinese:"林荫道"])
        let location16 = Location(name: [.korean:"강남역", .english:"Gangnam Station", .chinese:"江南站"])
        let location17 = Location(name: [.korean:"노량진", .english:"Noryangjin", .chinese:"鹭梁津"])
        let location18 = Location(name: [.korean:"노량진", .english:"Noryangjin", .chinese:"鹭梁津"])
        
        
        location1.matzyps = [robotkimbab, sonyeonsanghoi, daegalzip]
        location2.matzyps = [gwangMoon, samsungred, sinanchon]
        location3.matzyps = [surakio, termini, chammanna]
        location4.matzyps = [haematea, bomgas, sogumi]
        location5.matzyps = [hamnam, northsea, cryroad]
        location6.matzyps = [redsun, mpizza]
        location7.matzyps = [ioknyeo, tianpan]
        location8.matzyps = [hanyangChone, alchone, daedosikttang]
        location9.matzyps = []
        location10.matzyps = []
        location11.matzyps = []
        location12.matzyps = []
        location13.matzyps = []
        location14.matzyps = []
        location15.matzyps = []
        location16.matzyps = []
        location17.matzyps = []
        location18.matzyps = []
        
        locations = [location1,location2,location3,location4,location5, location6, location7, location8,location9, location10, location11, location12, location13, location14, location15, location16, location17, location18]
        
        let set = Setting(lang: .korean)
        setting = set
        
    }
}
/*
var matzypList:[Matzyp] = []

let hanyangchone = Matzyp(name: [0 : "한양촌", 1 : "Hanyangchone", 2 : "중국어"],
                          number: "010-3268-3267", /*location: "성동구 사근동",*/
                          homepage: "www.hanyangchone.co.kr",
                          business_hour: "09:00 ~ 18:00")
let alchone = Matzyp(name:[0:"알촌", 1:"Alchone", 2:"중국어"], number: "02-1234-5678", /*location:"서울시 성동구 행당동",*/ homepage:"www.alchone.com", business_hour:"09:00 ~ 20:00")
*/
