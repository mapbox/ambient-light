platform :ios, '8.0'
use_frameworks!

pod 'Mapbox-iOS-SDK', '~>2.1.0'

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end
end
