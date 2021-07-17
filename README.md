# Packer build action on AWS

The Actions runs the following on AWS 
1. Packer Validate
2. Packer Build

## Inputs Variables

| Name | Description | Required | Default |
| --- | --- | --- | --- |
| `workingDir` | The directory where the packer template and var file reside. Default is `"."` | no | yes |
| `templateFile` | The packer template file to use for packer build.| yes | no |
| `varFile` | The variable file to use for packer build. | no | no |


## Providing Secrets to Packer

In order to store sensitive information, GitHub provides secrets. The Secrets are encrypted in the environment variables which are made available to use in the GitHub Actions workflows. 
Add the secrets using github secrets. Under your repository name, click Settings. In the left sidebar, click Secrets.

## Example usage

To configure this action simply add the following lines to your .github/workflows/packer-build.yml workflow file:

```
name: Run packer build on AWS

on:
  push:
    branches:
        - 'master'
jobs:
  packer_build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: Packer build
        uses: ExitoLab/packer_build_action_aws@v0.2.10
        with:
          templateFile: 'packer-template.json'
          workingDir: '.'
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: us-east-1
```

Pls note: Add the `varFile` if you do have the file in your working directory

## Outputs

An AMI is produced on AWS. 


## Todo's

1. Support using Assume roles for authentication 
2. Support running packer on Azure 
3. Support running packer on GCP