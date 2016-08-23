# Uncomment this line to define a global platform for your project
platform :ios, '8.0'
use_frameworks!

def pod_install
    pod 'Alamofire'
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxAlamofire'
    pod 'ObjectMapper'
    pod 'KeychainAccess'
    pod 'RxRealm'
    pod 'SwiftyJSON'
end

target 'Annicted' do
    pod_install
end

plugin 'cocoapods-keys', {
    :project => "Annicted",
    :keys => [
    "AnnictClientId",
    "AnnictClientSecret"
    ]}
