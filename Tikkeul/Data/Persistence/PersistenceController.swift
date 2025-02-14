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
