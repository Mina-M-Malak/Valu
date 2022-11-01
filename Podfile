

  use_frameworks!
  
  workspace 'Market'
  # Pods for Market

  def rx_pods
      
      pod 'RxSwift'
      pod 'RxCocoa'
      
  end

  def rx_ext_pods
      
      pod 'RxSwiftExt'

      pod 'RxOptional'

      pod 'Action'

      pod 'RxDataSources'

  end

  def network_pods
    
      pod 'Alamofire'
      pod 'RxAlamofire'

  end

  def resources_pods

      pod 'Kingfisher'
      pod 'RxKingfisher'
      pod 'Cosmos'

  end

  def all_pods

      rx_pods
      rx_ext_pods
      network_pods
      resources_pods

  end

def tests_pods
  
    pod 'RxTest'

end

  target 'Market' do
      project 'Market.xcodeproj'

      all_pods

  end

target 'MarketTests' do
    project 'Market.xcodeproj'

    all_pods
    tests_pods

end
