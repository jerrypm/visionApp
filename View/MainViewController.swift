//
//  MainViewController.swift
//  TestATASKApp
//
//  Created by Jeri Purnama on 20/06/23.
//

import CoreData
import UIKit
import Vision

// MARK: - MainViewController

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(cellClass: CustomTableViewCell.self)
        tableView.separatorStyle = .none
    }

    @IBAction func didActionCamera(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "Select Photo", preferredStyle: .actionSheet)

        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.sourceType = .camera
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true, completion: nil)
            } else {
                print("Camera Not Available")
            }
        }

        let photoLibraryAction = UIAlertAction(title: "Library Photo", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true, completion: nil)
            } else {
                print("Library Not Available")
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: CustomTableViewCell.self, for: indexPath)
        return cell
    }
}

// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert to CIImage.")
            }

            detect(image: ciImage)
        }

        imagePicker.dismiss(animated: true, completion: nil)
    }

    func detect(image: CIImage) {
        let request = VNRecognizeTextRequest { request, _ in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                fatalError("Received invalid observations")
            }

            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else {
                    continue
                }

                DispatchQueue.main.async {
                    self.computeResult(expression: topCandidate.string)
                }
            }
        }

        request.recognitionLevel = .accurate
        let requests = [request]

        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: image, options: [:])
            try? handler.perform(requests)
        }
    }

    func computeResult(expression: String) {
        let mathExpression = NSExpression(format: expression)
        guard let mathResult = mathExpression.expressionValue(with: nil, context: nil) as? NSNumber else {
            return
        }
        saveResult(expression: expression, result: mathResult.floatValue)
    }

    func saveResult(expression: String, result: Float) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let newCalculation = Calculation(context: context)
        newCalculation.expression = expression
        newCalculation.result = result
        try? context.save()
    }
}
