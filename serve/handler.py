from torchvision import transforms
from ts.torch_handler.image_classifier import VisionHandler
import zipfile

zp = zipfile.ZipFile("models.zip", 'r')
zp.extractall()
zp.close()

zp = zipfile.ZipFile("datasets.zip", 'r')
zp.extractall()
zp.close()

zp = zipfile.ZipFile("utils.zip", 'r')
zp.extractall()
zp.close()

zp = zipfile.ZipFile("metrics.zip", 'r')
zp.extractall()
zp.close()


class FloorplanReconstructor(VisionHandler):

    image_processing = transforms.Compose([
        transforms.Grayscale(3),
        transforms.Resize((512, 512)),
        transforms.ToTensor(),
        transforms.Normalize((0.485, 0.456, 0.406), (0.229, 0.224, 0.225))
    ])

    def postprocess(self, data):
        # Absolute coordinate -> relative coordinate
        corners = data['corners']
        corners = corners / 512.

        data['corners'] = corners.tolist()
        data['edges'] = data['edges'].tolist()

        return [data]
