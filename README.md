# FWFaceAuth

[![CI Status](https://img.shields.io/travis/GreciaEM/FWFaceAuth.svg?style=flat)](https://travis-ci.org/GreciaEM/FWFaceAuth)
[![Version](https://img.shields.io/cocoapods/v/FWFaceAuth.svg?style=flat)](https://cocoapods.org/pods/FWFaceAuth)
[![License](https://img.shields.io/cocoapods/l/FWFaceAuth.svg?style=flat)](https://cocoapods.org/pods/FWFaceAuth)
[![Platform](https://img.shields.io/cocoapods/p/FWFaceAuth.svg?style=flat)](https://cocoapods.org/pods/FWFaceAuth)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 13.1

## Installation

FWFaceAuth is available through https://github.com/grupo-profuturo/ios-framework-pod-spec. To install, add the private repo.

```ruby
pod repo add ios-framework-pod-spec https://github.com/grupo-profuturo/ios-framework-pod-spec
```

Then add the following lines to your Podfile:

```ruby
source 'https://github.com/grupo-profuturo/ios-framework-pod-spec'
target 'face-auth' do

  use_frameworks!
  
  pod 'FWFaceAuth'

  # Dependency pods
  pod 'Microblink'
  pod 'NVActivityIndicatorView'
  pod 'Firebase/Analytics'
  pod 'Firebase/MLVision'
  pod 'Firebase/MLVisionTextModel'
  
end
```
## Update

To update, run:
```ruby
pod repo update ios-framework-pod-spec
```
And update pods in podfile:
```ruby
pod update
```

## Initialization

To show instructions, use:
```ruby
let uiConfiguration = FaceAuthModel.UIConfiguration(activityIndicator: activityData, withInstructions: true)
```
To don't show instructions, use:
```ruby
let uiConfiguration = FaceAuthModel.UIConfiguration(activityIndicator: activityData, withInstructions: false)
```

## Control

To run:
```ruby
let request = FaceAuthModel.Request(client: "", account: "", curp: "", nombre: "", apellidoPaterno: "", apellidoMaterno: "", origenID: 32, processID: "", subProcessID: "", appBundle: Bundle(for: type(of: self)))
        faceAuth!.startFaceAuth(request: request, uiConfiguration: uiConfiguration)
```

## Author

Panxea Grecia Escárcega

## License

FWFaceAuth is available under the MIT license. See the LICENSE file for more info.
