NAME = dockerbase/android
VERSION = 1.2

.PHONY: all build test tag_latest release ssh enter

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .

test:
	docker run -it --rm $(NAME):$(VERSION) echo hello world!

run:
	docker run -it --rm --name $(subst /,-,$(NAME)) $(NAME):$(VERSION)

ls_volume:
	@ID=$$(docker ps | grep -F "$(NAME):$(VERSION)" | awk '{ print $$1 }') && \
                if test "$$ID" = ""; then echo "Container is not running."; exit 1; fi && \
                DIR=$$(docker inspect $$ID | python -c 'import json,sys; obj=json.load(sys.stdin); print obj[0]["Volumes"]["/etc/nginx/sites-enabled"]') && \
                echo "looking at $$DIR" && \
		ls -ls $$DIR

version:
	docker run -it --rm $(NAME):$(VERSION) sh -c " lsb_release -d ; git --version ; ruby -v ; ssh -V ; make -v " | tee COMPONENTS
	docker run -it --rm $(NAME):$(VERSION) sh -c " javac -version ; java -version " | tee -a COMPONENTS
	docker run -it --rm $(NAME):$(VERSION) sh -c " echo -n Android SDK: ; readlink ~/.android/android-sdk.linux " | tee -a COMPONENTS
	docker run -it --rm $(NAME):$(VERSION) sh -c " echo -n Android NDK: ; readlink ~/.android/android-ndk.linux " | tee -a COMPONENTS
	docker run -it --rm $(NAME):$(VERSION) sh -c " echo -n Android build-tools: ; ls ~/.android/android-sdk.linux/build-tools/ " | tee -a COMPONENTS
	docker run -it --rm $(NAME):$(VERSION) sh -c " echo -n Android platform-tools: ; cat ~/.android/android-sdk.linux/platform-tools/source.properties | grep Pkg.Revision " | tee -a COMPONENTS
	docker run -it --rm $(NAME):$(VERSION) sh -c " echo -n Android platforms: ; ls ~/.android/android-sdk.linux/platforms/ " | tee -a COMPONENTS
	docker run -it --rm $(NAME):$(VERSION) sh -c " echo -n Android tools: ; cat ~/.android/android-sdk.linux/tools/source.properties | grep Pkg.Revision " | tee -a COMPONENTS
	dos2unix COMPONENTS
	sed -i -e 's/^/    /' COMPONENTS
	sed -i -e '/^### Components & Versions/q' README.md
	echo >> README.md
	cat COMPONENTS >> README.md
	rm COMPONENTS

tag_latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"

release: test tag_latest
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	#@if ! head -n 1 Changelog.md | grep -q 'release date'; then echo 'Please note the release date in Changelog.md.' && false; fi
	docker push $(NAME)
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"

ssh:
	chmod 600 build/insecure_key
	@ID=$$(docker ps | grep -F "$(NAME):$(VERSION)" | awk '{ print $$1 }') && \
		if test "$$ID" = ""; then echo "Container is not running."; exit 1; fi && \
		IP=$$(docker inspect $$ID | grep IPAddr | sed 's/.*: "//; s/".*//') && \
		echo "SSHing into $$IP" && \
		ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i build/insecure_key root@$$IP

enter:
	@ID=$$(docker ps | grep -F "$(NAME):$(VERSION)" | awk '{ print $$1 }') && \
		if test "$$ID" = ""; then echo "Container is not running."; exit 1; fi && \
		PID=$$(docker inspect --format {{.State.Pid}} $$ID) && \
		SHELL=/bin/bash sudo -E build/bin/nsenter --target $$PID --mount --uts --ipc --net --pid
