#!/bin/bash

function make_manifest(){

  local buildpack=$1
  local environment=$2
  
  local memory="128M"
  local cmd="null"

  case "$buildpack" in
    nodejs)
        cmd="node index.js"
        ;;
    java)
        memory="256M"
        ;;
     
    # *)
    #   echo $"Usage: $0 {start|stop|restart|condrestart|status}"
    #   exit 1
   
  esac

cat > buildpacks/${buildpack}/manifest-${environment}.yml <<EOF
---
applications:
- name: ${buildpack}_buildpack
  host: ${buildpack}_buildpack
  buildpack: ${buildpack}_buildpack
  instances: 1
  memory: ${memory}
  path: .
  command: ${cmd}
EOF

}

function main(){
  for p in $(ls buildpacks)
  do
    make_manifest "$p" "stage"
    make_manifest "$p" "prod"
  done
}


main
