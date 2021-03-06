provider "aws" {
  region = "ap-northeast-1"
  alias  = "modernisation-platform-ap-northeast-1"
}

provider "aws" {
  region = "ap-northeast-2"
  alias  = "modernisation-platform-ap-northeast-2"
}

provider "aws" {
  region = "ap-south-1"
  alias  = "modernisation-platform-ap-south-1"
}

provider "aws" {
  region = "ap-southeast-1"
  alias  = "modernisation-platform-ap-southeast-1"
}

provider "aws" {
  region = "ap-southeast-2"
  alias  = "modernisation-platform-ap-southeast-2"
}

provider "aws" {
  region = "ca-central-1"
  alias  = "modernisation-platform-ca-central-1"
}

provider "aws" {
  region = "eu-central-1"
  alias  = "modernisation-platform-eu-central-1"
}

provider "aws" {
  region = "eu-north-1"
  alias  = "modernisation-platform-eu-north-1"
}

provider "aws" {
  region = "eu-west-1"
  alias  = "modernisation-platform-eu-west-1"
}

provider "aws" {
  region = "eu-west-2"
  alias  = "modernisation-platform-eu-west-2"
}

provider "aws" {
  region = "eu-west-3"
  alias  = "modernisation-platform-eu-west-3"
}

provider "aws" {
  region = "sa-east-1"
  alias  = "modernisation-platform-sa-east-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "modernisation-platform-us-east-1"
}

provider "aws" {
  region = "us-east-2"
  alias  = "modernisation-platform-us-east-2"
}

provider "aws" {
  region = "us-west-1"
  alias  = "modernisation-platform-us-west-1"
}

provider "aws" {
  region = "us-west-2"
  alias  = "modernisation-platform-us-west-2"
}

module "baselines-modernisation-platform" {
  source = "github.com/ministryofjustice/modernisation-platform-terraform-baselines"
  providers = {
    # Default and replication regions
    aws                    = aws.modernisation-platform-eu-west-2
    aws.replication-region = aws.modernisation-platform-eu-west-1

    # Other regions
    aws.ap-northeast-1 = aws.modernisation-platform-ap-northeast-1
    aws.ap-northeast-2 = aws.modernisation-platform-ap-northeast-2
    aws.ap-south-1     = aws.modernisation-platform-ap-south-1
    aws.ap-southeast-1 = aws.modernisation-platform-ap-southeast-1
    aws.ap-southeast-2 = aws.modernisation-platform-ap-southeast-2
    aws.ca-central-1   = aws.modernisation-platform-ca-central-1
    aws.eu-central-1   = aws.modernisation-platform-eu-central-1
    aws.eu-north-1     = aws.modernisation-platform-eu-north-1
    aws.eu-west-1      = aws.modernisation-platform-eu-west-1
    aws.eu-west-2      = aws.modernisation-platform-eu-west-2
    aws.eu-west-3      = aws.modernisation-platform-eu-west-3
    aws.sa-east-1      = aws.modernisation-platform-sa-east-1
    aws.us-east-1      = aws.modernisation-platform-us-east-1
    aws.us-east-2      = aws.modernisation-platform-us-east-2
    aws.us-west-1      = aws.modernisation-platform-us-west-1
    aws.us-west-2      = aws.modernisation-platform-us-west-2
  }
  root_account_id = local.root_account.master_account_id
  tags            = local.tags
}

module "trusted-advisor-modernisation-platform" {
  source = "github.com/ministryofjustice/modernisation-platform-terraform-trusted-advisor"
}
