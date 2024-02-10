import Foundation
import Combine
import Domain
import NetworkPlatform

protocol MyPageGetRepositoryInterface {
    func data() -> AnyPublisher<MyPageGetDTO, ErrorType>
}
