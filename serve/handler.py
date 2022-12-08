from torchvision import transforms
from ts.torch_handler.image_classifier import VisionHandler


class FloorplanReconstructor(VisionHandler):

    image_processing = transforms.Compose([
        transforms.Resize(256),
        transforms.ToTensor(),
        transforms.Normalize((0.485, 0.456, 0.406), (0.229, 0.224, 0.225))
    ])

    def postprocess(self, data):
        # Absolute coordinate -> relative coordinate
        corners = data['corners']
        corners /= 256

        data['corners'] = corners

        return data
