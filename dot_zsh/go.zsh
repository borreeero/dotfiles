[ -d /usr/local/go ] && path=("/usr/local/go/bin" $path)
command -v go >/dev/null 2>&1 && path=("$(go env GOPATH)/bin" $path)
