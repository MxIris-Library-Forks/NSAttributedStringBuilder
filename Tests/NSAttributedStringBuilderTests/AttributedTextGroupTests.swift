//
//  AttributedTextGroupTests.swift
//
//
//  Created by JH on 2022/8/1.
//

@testable import NSAttributedStringBuilder
import XCTest

final class AttributedTextGroupTests: XCTestCase {
    func test0() {
        let att1 = NSAttributedString {
            AText("111")
                .font(.systemFont(ofSize: 30))
                .foregroundColor(.black)
            AText("222")
                .font(.systemFont(ofSize: 30))
                .foregroundColor(.black)
            if true {
                AText("222")
                    .font(.systemFont(ofSize: 30))
                    .foregroundColor(.black)
            }
        }

        let att2 = NSAttributedString {
            ATextGroup {
                AText("111")
                AText("222")
            }
            .font(.systemFont(ofSize: 30))
            .foregroundColor(.black)
        }
        XCTAssertTrue(att1.isEqual(att2))
    }

    func test1() {
        let att1 = NSAttributedString {
            AText("111")
                .font(.systemFont(ofSize: 30))
                .foregroundColor(.black)
            AText("222")
                .font(.systemFont(ofSize: 30))
                .foregroundColor(.red)
        }

        let att2 = NSAttributedString {
            ATextGroup {
                AText("111")
                    .foregroundColor(.black)
                AText("222")
                    .foregroundColor(.red)
            }
            .font(.systemFont(ofSize: 30))
        }
        XCTAssertTrue(att1.isEqual(att2))
    }
    
    func test2() {
        
        let att1 = NSAttributedString {
            AText("111")
                .backgroundColor(.blue)
            AText("222")
                .font(.systemFont(ofSize: 18, weight: .semibold))
                .backgroundColor(.blue)
            AText("333")
                .font(.systemFont(ofSize: 18, weight: .semibold))
                .backgroundColor(.blue)
                
        }
        
        let att2 = NSAttributedString {
            ATextGroup {
                AText("111")
                ATextGroup {
                    AText("222")
                    AText("333")
                }
                .font(.systemFont(ofSize: 18, weight: .semibold))
            }
            .backgroundColor(.blue)
        }
        XCTAssertTrue(att1.isEqual(att2))
    }
    func test3() {
      
        let att1 = NSAttributedString {
            AText("111")
                .backgroundColor(.blue)
            AText("222")
                .font(.systemFont(ofSize: 18, weight: .semibold))
                .backgroundColor(.blue)            
            Link("NSAttributedStringBuilder", url: URL(string: "https://github.com/ethanhuang13/NSAttributedStringBuilder")!)
            Space()
            AText("333")
                .font(.systemFont(ofSize: 18, weight: .semibold))
                .backgroundColor(.blue)
        }
        let att2 = NSAttributedString {
            ATextGroup {
                AText("111")
                ATextGroup {
                    AText("222")
                    Link("NSAttributedStringBuilder", url: URL(string: "https://github.com/ethanhuang13/NSAttributedStringBuilder")!)
                    Space()
                    AText("333")
                }
                .font(.systemFont(ofSize: 18, weight: .semibold))
            }
            .backgroundColor(.blue)
            
        }
        XCTAssertTrue(att1.isEqual(att2))
    }
}
