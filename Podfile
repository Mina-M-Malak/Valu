# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Market' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  workspace 'Market'
  # Pods for Market

  def core_pods

      pod 'Strongify', :git => 'https://github.com/milanhorvatovic/Strongify', :branch => 'master'

  end

  def rx_pods
      
      #pod 'RxSwift', '~> 5.0'
      pod 'RxSwift', '5.0.1'
      #pod 'RxSwift'
      
      #pod 'RxCocoa', '~> 5.0'
      pod 'RxCocoa', '5.0.1'
      #pod 'RxCocoa'
      
  end

  def rx_ext_pods
      
      #pod 'RxSwiftExt', '~> 5.2'
      pod 'RxSwiftExt', '5.2.0'
      #pod 'RxSwiftExt'

      #pod 'RxOptional', '~> 4.1'
      pod 'RxOptional', '4.1.0'
      #pod 'RxOptional'

      #pod 'Action', '~> 4.0'
      pod 'Action' , '4.0.0'
      #pod 'Action'

      #pod 'RxDataSources', '~> 4.0'
      pod 'RxDataSources', '4.0.1'
      #pod 'RxDataSources'

  end

  def network_pods

      #pod 'Alamofire', '~> 4.9'
      pod 'Alamofire', '4.9.1'
      #pod 'Alamofire'

      #pod 'RxAlamofire', '~> 5.1'
      pod 'RxAlamofire', '5.1.0'
      #pod 'RxAlamofire'

  end

  def resources_pods

      #pod 'Kingfisher', '~> 5.12'
      pod 'Kingfisher', '5.12.0'
      #pod 'Kingfisher'

      #pod 'RxKingfisher', '~> 1.0'
      pod 'RxKingfisher', '1.0.0'
      #pod 'RxKingfisher'

  end

  def supplementary_pods
    
      #pod 'CocoaLumberjack/Swift', '~> 3.6'
      #pod 'CocoaLumberjack/Swift', '3.6.0'
      #pod 'CocoaLumberjack/Swift'
    
  end

  def all_pods

      core_pods
      rx_pods
      rx_ext_pods
      network_pods
      resources_pods
      supplementary_pods

  end

  target 'Market' do
      project 'Market.xcodeproj'

      all_pods

  end
end
