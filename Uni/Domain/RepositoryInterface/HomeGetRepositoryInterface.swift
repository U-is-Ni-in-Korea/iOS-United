import Foundation
import Combine
import Domain
import NetworkPlatform

protocol HomeGetRepositoryInterface {
    func data() -> AnyPublisher<HomeGetDTO, ErrorType>
}
