#!/bin/bash

# Verify git, process tools, lsb-release (common in install instructions for CLIs) installed
sudo apt-get update && sudo apt-get -y install --no-install-recommends apt-utils dialog unzip git iproute2 procps lsb-release 2>&1

# Install pip & pre-commit
sudo apt-get install -y python3-pip
python3 -m pip install --no-cache-dir --break-system-packages pre-commit

# Clean up
sudo apt-get autoremove -y
sudo apt-get clean -y

# Install Go tools
go install github.com/uudashr/gopkgs/v2/cmd/gopkgs@latest
go install github.com/ramya-rao-a/go-outline@latest
go install github.com/acroca/go-symbols@latest
go install github.com/godoctor/godoctor@latest
go install golang.org/x/tools/cmd/gorename@latest
go install github.com/rogpeppe/godef@latest
go install github.com/zmb3/gogetdoc@latest
go install github.com/haya14busa/goplay/cmd/goplay@latest
go install github.com/sqs/goreturns@latest
go install github.com/josharian/impl@latest
go install github.com/davidrjenni/reftools/cmd/fillstruct@latest
go install github.com/fatih/gomodifytags@latest
go install github.com/cweill/gotests/...@latest
go install golang.org/x/tools/cmd/goimports@latest
go install golang.org/x/lint/golint@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install github.com/mgechev/revive@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install honnef.co/go/tools/cmd/staticcheck@latest
go install golang.org/x/tools/gopls@latest

# Protocol Buffer Compiler
PROTOC_VERSION=27.2
if [ $(dpkg --print-architecture) = "amd64" ]; then PROTOC_ARCH="x86_64"; else PROTOC_ARCH="aarch_64" ; fi
curl -LO "https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-$PROTOC_ARCH.zip"
unzip "protoc-${PROTOC_VERSION}-linux-$PROTOC_ARCH.zip" -d $HOME/.local
rm -f "protoc-${PROTOC_VERSION}-linux-$PROTOC_ARCH.zip"

# Install Operator Framework SDK
OPERATOR_RELEASE_VERSION=v1.26.0
ARCH=$(case $(uname -m) in x86_64) echo -n amd64 ;; aarch64) echo -n arm64 ;; *) echo -n $(uname -m) ;; esac) 
OS=$(uname | awk '{print tolower($0)}')
OPERATOR_SDK_DL_URL=https://github.com/operator-framework/operator-sdk/releases/download/${OPERATOR_RELEASE_VERSION}
curl -LO ${OPERATOR_SDK_DL_URL}/operator-sdk_${OS}_${ARCH}
chmod +x operator-sdk_${OS}_${ARCH}
sudo mv operator-sdk_${OS}_${ARCH} /usr/local/bin/operator-sdk

# Install tools for make build command
go install sigs.k8s.io/controller-tools/cmd/controller-gen
go install sigs.k8s.io/kustomize/kustomize/v5
go install sigs.k8s.io/controller-runtime/tools/setup-envtest
go install go.uber.org/mock/mockgen
go install google.golang.org/protobuf/cmd/protoc-gen-go
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc
go install github.com/jstemmer/go-junit-report/v2
