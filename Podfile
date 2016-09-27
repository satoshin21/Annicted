# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

def pod_install
    pod 'Alamofire', '4.0.1'
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxAlamofire', '~> 3.0.0-beta.1'
    pod 'KeychainAccess'
    pod 'SwiftyJSON'
    pod 'APIKit', '~> 3.0-beta.2'
    pod 'Himotoki'
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
