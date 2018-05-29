# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def app_pods
    use_frameworks!
    
    # Pods for KCPL
    
    pod 'IQKeyboardManager'
    pod 'Alamofire'
    pod 'SwiftyJSON'
    pod 'BRYXBanner'
    pod 'MRProgress'
end

target 'KCPL' do
  app_pods
    
  target 'KCPLTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'KCPLUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end

target 'KCPLSales' do
    app_pods
end

target 'KCPLAdmin' do
   app_pods
end
