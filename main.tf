resource "aws_s3_bucket" "crc-bucket" {
  bucket = "js-crc-3540"
}

locals {
  source_code = fileset("src/", "*")
}

resource "aws_s3_object" "crc-bucket-obejct" {
  for_each = { for file in local.source_code : file => file }

  key = each.key
  bucket = aws_s3_bucket.crc-bucket.id
  source = "src/${each.key}"
}