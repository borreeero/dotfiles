[ -d /usr/local/go ] && path=("/usr/local/go/bin" $path)
[ -x "$(which go)" ] && path=("$(go env GOPATH)/bin" $path)
