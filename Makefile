.PHONY: archive-model start-serve stop-serve check-status rm-model request-test

model_store_path = /home/takeshita/test/heat/model-store
config_properties_path = /home/takeshita/test/heat/config.properties
model_name = heat
model_version = 1.0
model_file = heat.py
serialized_file = checkpoint.pth
extra_files = models.zip,datasets.zip,metrics.zip,utils.zip,infer.py
handler_file = serve/handler.py
requirements_file = requirements-thirdparty.txt
export_path = model-store
image_path = /home/takeshita/heat/4_99_2.jpeg

torchserve_path = $(shell which torchserve)

archive-model:
	        torch-model-archiver --model-name $(model_name) --version $(model_version) --model-file $(model_file) --serialized-file $(serialized_file) --extra-files $(extra_files) --handler $(handler_file) --requirements-file $(requirements_file) --export-path $(export_path)

start-serve:
	        torchserve --start --ncs --model-store $(model_store_path) --models $(model_name)=$(model_name).mar --ts-config $(config_properties_path)

stop-serve:
	        torchserve --stop

rm-model:
	        rm $(model_store_path)/$(model_name).mar

check-status:
	        curl http://localhost:8080/ping
		        curl http://localhost:8081/models

request-test:
	        curl http://localhost:8080/predictions/$(model_name)/${model_version} -T ${image_path}

sudo-start-serve:
		sudo $(torchserve_path) --start --ncs --model-store $(model_store_path) --models $(model_name)=$(model_name).mar --ts-config $(config_properties_path)

sudo-stop-serve:
		sudo $(torchserve_path) --stop