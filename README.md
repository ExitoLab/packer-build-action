# Packer build action on AWS

This action runs packer build on AWS

## Inputs Variables

| Name | Description | Required | Default |
| --- | --- | --- | --- |
| `workingDir` | The directory where the packer template and var file reside. Default is `"."` | no | yes |
| `templateFile` | The packer template file to use for packer build.| yes | no |
| `varFile` | The variable file to use for packer build. | no | no |


## Providing Secrets to Packer

Add the secrets using github secrets. Under your repository name, click Settings. In the left sidebar, click Secrets.

## Outputs

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
        uses: ExitoLab/packer_build_action_aws@v2.8
        with:
          templateFile: 'packer-template.json'
          workingDir: '.'
          varFile: 'packer-vars.json'
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: us-east-1
```

Pls note: Don't add the `varFile` if you do not have the file in your working directory