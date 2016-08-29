# Uncomment this line to define a global platform for your project
platform :ios, '8.0'
use_frameworks!

def pod_install
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'KeychainAccess' 
    pod 'APIKit'
    pod 'Himotoki'
    pod 'WebLinking'
    pod 'Action'
    pod 'SwiftDate'
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
