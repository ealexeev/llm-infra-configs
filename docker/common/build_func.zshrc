function docker_build() {
	readonly IMAGE_NAME=${1:?"The directory containing the Dockerfile  must be specified."}
        readonly DATE=$(date +%Y%m%d)

	echo "Building ${IMAGE_NAME}:${DATE}..."
        docker build -t "${IMAGE_NAME}:${DATE}" -t "${IMAGE_NAME}:latest" -f ${IMAGE_NAME}/Dockerfile .
}
