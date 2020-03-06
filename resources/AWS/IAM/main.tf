#IAM
module "service_linked_role" {
  source              = "../../../modules/AWS/IAM/service_linked_role"
  service_linked_role = var.service_linked_role
}

module "iam_role" {
  source   = "../../../modules/AWS/IAM/iam_role"
  iam_role = var.iam_role
}

module "role_policy" {
  source          = "../../../modules/AWS/IAM/iam_role_policy"
  iam_role_policy = var.iam_role_policy
  role            = module.iam_role.iam_role_id
}

module "iam_instance_profile" {
  source           = "../../../modules/AWS/IAM/instance_profile"
  instance_profile = var.iam_instance_profile
  role_name        = module.iam_role.iam_role_id
}

module "iam_role_policy_attachment" {
  source                     = "../../../modules/AWS/IAM/iam_role_policy_attachment"
  iam_role                   = module.iam_role.iam_role_name
  iam_role_policy_attachment = var.iam_role_policy_attachment
}