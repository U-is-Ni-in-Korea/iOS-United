import Foundation
import Combine
import NetworkPlatform

protocol MyPageGetRepositoryInterface {
    func data() -> AnyPublisher<MyPageGetDTO, ErrorType>
}
