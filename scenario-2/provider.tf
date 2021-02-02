terraform {
  required_providers {
    helmfile = {
      source = "mumoshu/helmfile"
      version = "0.13.2"
    }
  }
}

resource "helmfile_release_set" "kubernetes" {
  working_directory = "../platform"
  kubeconfig        = pathexpand("<kube_config>")
  environment       = terraform.workspace
  values = [
<<EOF
awsRegion: "${local.env.region}"
publicDomainName: "${local.env.public_domain}"
awsAccountNumber: "${local.env.aws_account_id}"
clusterName: "${local.env.k8s_cluster_name}"
EOF
  ]
}

