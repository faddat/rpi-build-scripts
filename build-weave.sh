export GOPATH=~/go

TAG=$1
echo "Building weave for $TAG"
mkdir $GOPATH
cd $GOPATH
echo "executing go clean"
go clean -i net
echo "executing go install"
go install -tags netgo std
echo "cleaning existing sources"
mkdir -p src/github.com/weaveworks
cd src/github.com/weaveworks
rm -rf weave
echo "cloning"
git clone -b rpi-latest-release http://github.com/dilgerma/weave
cd weave
make SUDO=
#publish

publish() {
   docker tag  dilgerm/weave dilgerm/rpi-weave:latest
   docker tag  dilgerm/weaveexec dilgerm/rpi-weaveexec:latest
   docker tag  dilgerm/plugin dilgerm/rpi-plugin:latest
   docker tag  dilgerm/weavedb dilgerm/weavedb:latest

   if [ -n "$TAG" ]; then
      docker tag dilgerm/weave dilgerm/rpi-weave:$TAG
      docker tag dilgerm/weaveexec dilgerm/rpi-weaveexec:$TAG
      docker tag dilgerm/plugin dilgerm/rpi-plugin:$TAG
      docker tag dilgerm/weavedb dilgerm/weavedb:$TAG  
   fi

   docker push dilgerm/rpi-weave:latest
   docker push dilgerm/rpi-weaveexec:latest
   docker push dilgerm/rpi-plugin:latest
   docker push dilgerm/weavedb:latest
         
}


