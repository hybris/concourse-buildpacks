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
  for bp in ${1}
  do
    for ev in ${2}
    do
      make_manifest "$bp" "$ev"
    done
  done
}

default_buildpacks="$(ls buildpacks)"
default_environments="stage prod"



buildpacks=${1:-$default_buildpacks}
environments=${2:-$default_environments}

main "${buildpacks}" "${environments}"
