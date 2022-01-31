#!/usr/bin/env bash

function switch-aws-role () {
  envname=$1

  export AWS_PROFILE=$envname

  aws sts get-caller-identity

  echo "Please provide the wished cluster name or type one of the following options:"
  echo " - Use 'list' or 'l' to list available clusters and select one"
  echo " - Use 'active', 'a' or press enter to connect to the active cluster"
  echo " - Use 'none' or 'n' to skip connecting to a cluster"
  read cluster_name

  # needs to be first, to correctly process pressing enter
  if [[ "$cluster_name" == "active" || "$cluster_name" == "a" || "$cluster_name" == "" ]]; then
    cluster_name=""
    for cluster in $(aws eks list-clusters --query clusters --output text); do
      if [ $(aws eks describe-cluster --name $cluster --query cluster.tags.active --output text) = true ]; then
        cluster_name=$cluster
        break
      fi
    done
  fi

  if [[ "$cluster_name" == "none" || "$cluster_name" == "n" ]]; then
    cluster_name=""
  fi

  if [[ "$cluster_name" == "list" || "$cluster_name" == "l" ]]; then
    echo "Please select a cluster by number"
    echo "0) None (skip connecting to a cluster)"
    cluster_name=""
    select cluster_name in $(aws eks list-clusters --query clusters --output text); do
      break
    done
  fi

  if [[ "$cluster_name" != "" ]]; then
    aws eks update-kubeconfig --name $cluster_name
  else
    kubectl config unset current-context
    echo "Unset Kubernetes context"
  fi
}
