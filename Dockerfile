FROM hashicorp/packer:1.7.3

LABEL "repository" = "https://github.com/ExitoLab/packer_build_action_aws"
LABEL "homepage" = "https://github.com/ExitoLab/packer_build_action_aws"
LABEL "maintainer" = "Ige Adetokunbo Temitayo <igeadetokunbo@gmail.com>"

LABEL "com.github.actions.name" = "Packer build on AWS"
LABEL "com.github.actions.description" = "Run packer build on a template file on AWS"
LABEL "com.github.actions.icon"="check-circle"
LABEL "com.github.actions.color"="blue"

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]