#GitHubとAWSの連携
data "aws_codestarconnections_connection" "YutaGitHub" {
  name = "YutaGitHub"
}