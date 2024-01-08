import Foundation
import Combine
import NetworkPlatform

protocol HomeGetRepositoryInterface {
    func data() -> AnyPublisher<HomeGetDTO, ErrorType>
}
