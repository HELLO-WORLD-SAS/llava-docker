variable "REGISTRY" {
    default = "docker.io"
}

variable "REGISTRY_USER" {
    default = "helloworldsas"
}

variable "APP" {
    default = "llava"
}

variable "RELEASE" {
    default = "1.6.0"
}

variable "CU_VERSION" {
    default = "118"
}

variable "BASE_IMAGE_REPOSITORY" {
    default = "ashleykza/runpod-base"
}

variable "BASE_IMAGE_VERSION" {
    default = "1.4.0"
}

variable "CUDA_VERSION" {
    default = "11.8.0"
}

variable "TORCH_VERSION" {
    default = "2.1.2"
}

target "default" {
    dockerfile = "Dockerfile"
    tags = ["${REGISTRY}/${REGISTRY_USER}/${APP}:${RELEASE}"]
    args = {
        RELEASE = "${RELEASE}"
        BASE_IMAGE = "${BASE_IMAGE_REPOSITORY}:${BASE_IMAGE_VERSION}-cuda${CUDA_VERSION}-torch${TORCH_VERSION}"
        INDEX_URL = "https://download.pytorch.org/whl/cu${CU_VERSION}"
        TORCH_VERSION = "${TORCH_VERSION}+cu${CU_VERSION}"
        XFORMERS_VERSION = "0.0.23.post1+cu${CU_VERSION}"
        LLAVA_COMMIT = "22422b4c3a3ef1ba52aca074cc9021216877ce5d"
        LLAVA_MODEL = "liuhaotian/llava-v1.6-vicuna-13b"
        VENV_PATH = "/workspace/venvs/${APP}"
    }
}
