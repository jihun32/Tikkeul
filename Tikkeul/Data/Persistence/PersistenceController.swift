//
//  PersistenceController.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/13/25.
//

import CoreData

struct PersistenceController {
    
    /// 싱글턴 인스턴스 - 앱 전체에서 하나의 CoreData 컨트롤러를 사용하도록 설정
    static let shared = PersistenceController()

    /// SwiftUI 프리뷰를 위한 샘플 데이터 제공
    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true) // 메모리 내 저장소 사용 (디스크에 저장되지 않음)
        let viewContext = result.container.viewContext
        
        // 샘플 데이터 10개 생성
        for i in 1...10 {
            let newItem = Tikkeul(context: viewContext)
            newItem.id = UUID()
            newItem.money = Int16(i * 10000) // 금액 필드 설정
            newItem.category = "snack" // 카테고리 기본값 설정
            newItem.date = Date() // 현재 날짜 설정
        }
        
        // 데이터 저장
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    /// CoreData 컨테이너 (데이터 모델명 "Tikkeul")
    let container: NSPersistentContainer

    /// 초기화 - CoreData 스택 구성
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Tikkeul") // "Tikkeul" 데이터 모델 로드
        if inMemory {
            // 테스트 또는 프리뷰용 - 영구 저장소를 사용하지 않음
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        // 저장소 로드 및 오류 처리
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        // 변경사항 자동 병합 - 여러 컨텍스트에서 변경 사항을 반영
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
