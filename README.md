# DogCommunity

This is a sample app for my CoreML talk. It is an app for dog owners to share photos of their dogs. This app doesn't use any real backend. It's main functionality (apart from showing and adding photos) is verifying if the added photo is a dog. It will reject cat photos.

### Prerequisites

You need the app and some photos of dogs and cats on your device or simulator.

### CoreML

Model was created using [CreateML]() based on [the Kaggle dataset](https://www.kaggle.com/c/dogs-vs-cats/data).

This is the code responsible for the classification:
```swift
let model = try VNCoreMLModel(for: CatOrDog().model)
let request = VNCoreMLRequest(model: model) { request, error in
    self.processRequest(request, completion: completion)
}

let handler = VNImageRequestHandler(cgImage: image.cgImage!)
try handler.perform([request])
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

* App icon is made by Freepik from [www.flaticon.com](https://www.flaticon.com)
* Dog photos are part of [Kaggle competition Dogs vs. Cats](https://www.kaggle.com/c/dogs-vs-cats)
