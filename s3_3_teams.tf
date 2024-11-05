provider "aws" {
  region = "eu-west-3"
}


#Role for Team A created
resource "aws_iam_role" "team_a" {
  name = "team_a"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          "AWS" : [
            "arn:aws:iam::767398066589:user/Mehdi",
            "arn:aws:iam::767398066589:root"
          ]
        },
        Action    = "sts:AssumeRole",
        Condition = {}
      }
    ]
  })
}



#Role for Team B created
resource "aws_iam_role" "team_b" {
  name = "team_b"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          "AWS" : [
            "arn:aws:iam::767398066589:user/Mehdi",
            "arn:aws:iam::767398066589:root"
          ]
        },
        Action    = "sts:AssumeRole",
        Condition = {}
      }
    ]
  })
}


#Role for Team C created
resource "aws_iam_role" "team_c" {
  name = "team_c"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          "AWS" : [
            "arn:aws:iam::767398066589:user/Mehdi",
            "arn:aws:iam::767398066589:root"
          ]
        },
        Action    = "sts:AssumeRole",
        Condition = {}
      }
    ]
  })
}


#Role for Admin created
resource "aws_iam_role" "Admin" {
  name = "Admin"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          "AWS" : [
            "arn:aws:iam::767398066589:user/Mehdi",
            "arn:aws:iam::767398066589:root"
          ]
        },
        Action    = "sts:AssumeRole",
        Condition = {}
      }
    ]
  })
}


#Bucket policy team A
resource "aws_s3_bucket" "bucket-team-a" {
  bucket = "bucket-team-a"
}
resource "aws_s3_bucket_policy" "bucket_a_policy" {
  bucket = aws_s3_bucket.bucket-team-a.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "DenyAccess",
        Effect    = "Deny",
        Principal = "*",
        Action    = "s3:*",
        Resource = [
          "arn:aws:s3:::bucket-team-a",
          "arn:aws:s3:::bucket-team-a/*"
        ]
        Condition = {
          StringNotLike = {
            "aws:PrincipalArn" : [
              "arn:aws:iam::767398066589:role/team_a",
              "arn:aws:iam::767398066589:role/team_b",
              "arn:aws:iam::767398066589:role/team_c",
              "arn:aws:iam::767398066589:role/Admin",
              "arn:aws:iam::767398066589:user/Mehdi",
              "arn:aws:iam::767398066589:root"
            ]
          }
        }
      },
      {
        Sid    = "AllowReadWriteDeleteBucketA",
        Effect = "Allow",
        Principal = {
          "AWS" : [
            "arn:aws:iam::767398066589:role/team_a"
          ]
        },
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ],
        Resource = "arn:aws:s3:::bucket-team-a/*"
      },
      {
        Sid    = "AllowReadBucketA",
        Effect = "Allow",
        Principal = {
          "AWS" : [
            "arn:aws:iam::767398066589:role/team_a",
            "arn:aws:iam::767398066589:role/team_b",
            "arn:aws:iam::767398066589:role/team_c"
          ]
        },
        Action = [
          "s3:GetObject"
        ],
        Resource = "arn:aws:s3:::bucket-team-a/*"
      },
      {
        Sid    = "ListBucketA",
        Effect = "Allow",
        Principal = {
          "AWS" : [
            "arn:aws:iam::767398066589:role/team_a",
            "arn:aws:iam::767398066589:role/team_b",
            "arn:aws:iam::767398066589:role/team_c"
          ]
        },
        Action = [
          "s3:ListBucket"
        ],
        Resource = "arn:aws:s3:::bucket-team-a"
      },
      {
        Sid    = "AllowMehdi",
        Effect = "Allow",
        Principal = {
          "AWS" : [
            "arn:aws:iam::767398066589:role/Admin"
          ]
        },
        Action = "s3:*",
        Resource = [
          "arn:aws:s3:::bucket-team-a",
          "arn:aws:s3:::bucket-team-a/*"
        ]
      }
    ]
  })
}




#Bucket policy team B 
resource "aws_s3_bucket" "bucket-team-b" {
  bucket = "bucket-team-b"
}
resource "aws_s3_bucket_policy" "bucket_b_policy" {
  bucket = aws_s3_bucket.bucket-team-b.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "DenyAccess",
        Effect    = "Deny",
        Principal = "*",
        Action    = "s3:*",
        Resource = [
          "arn:aws:s3:::bucket-team-b",
          "arn:aws:s3:::bucket-team-b/*"
        ]
        Condition = {
          StringNotLike = {
            "aws:PrincipalArn" : [
              "arn:aws:iam::767398066589:role/team_b",
              "arn:aws:iam::767398066589:role/Admin",
              "arn:aws:iam::767398066589:user/Mehdi",
              "arn:aws:iam::767398066589:root"
            ]
          }
        }
      },
      {
        Sid    = "AllowReadWriteDeleteBucketB",
        Effect = "Allow",
        Principal = {
          "AWS" : [
            "arn:aws:iam::767398066589:role/team_b"
          ]
        },
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ],
        Resource = "arn:aws:s3:::bucket-team-b/*"
      },
      {
        Sid    = "ListBucketB",
        Effect = "Allow",
        Principal = {
          "AWS" : [
            "arn:aws:iam::767398066589:role/team_b"
          ]
        },
        Action = [
          "s3:ListBucket"
        ],
        Resource = "arn:aws:s3:::bucket-team-b"
      },
      {
        Sid    = "AllowMehdi",
        Effect = "Allow",
        Principal = {
          "AWS" : [
            "arn:aws:iam::767398066589:role/Admin"
          ]
        },
        Action = "s3:*",
        Resource = [
          "arn:aws:s3:::bucket-team-b",
          "arn:aws:s3:::bucket-team-b/*"
        ]
      }
    ]
  })
}

#Bucket policy team C
resource "aws_s3_bucket" "bucket-team-c" {
  bucket = "bucket-team-c"
}
resource "aws_s3_bucket_policy" "bucket_c_policy" {
  bucket = aws_s3_bucket.bucket-team-c.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "DenyAccess",
        Effect    = "Deny",
        Principal = "*",
        Action    = "s3:*",
        Resource = [
          "arn:aws:s3:::bucket-team-c",
          "arn:aws:s3:::bucket-team-c/*"
        ]
        Condition = {
          StringNotLike = {
            "aws:PrincipalArn" : [
              "arn:aws:iam::767398066589:role/team_b",
              "arn:aws:iam::767398066589:role/team_c",
              "arn:aws:iam::767398066589:role/Admin",
              "arn:aws:iam::767398066589:user/Mehdi",
              "arn:aws:iam::767398066589:root"
            ]
          }
        }
      },
      {
        Sid    = "AllowReadBucketC",
        Effect = "Allow",
        Principal = {
          "AWS" : [
            "arn:aws:iam::767398066589:role/team_c"
          ]
        },
        Action = [
          "s3:GetObject"
        ],
        Resource = "arn:aws:s3:::bucket-team-c/*"
      },
      {
        Sid    = "AllowWriteBucketC",
        Effect = "Allow",
        Principal = {
          "AWS" : [
            "arn:aws:iam::767398066589:role/team_b",
            "arn:aws:iam::767398066589:role/team_c"
          ]
        },
        Action = [
          "s3:PutObject"
        ],
        Resource = "arn:aws:s3:::bucket-team-c/*"
      },
      {
        Sid    = "AllowDelete",
        Effect = "Allow",
        Principal = {
          "AWS" : [
            "arn:aws:iam::767398066589:role/team_c"
          ]
        },
        Action = [
          "s3:DeleteObject"
        ],
        Resource = "arn:aws:s3:::bucket-team-c/*"
      },
      {
        Sid    = "ListBucketC",
        Effect = "Allow",
        Principal = {
          "AWS" : [
            "arn:aws:iam::767398066589:role/team_b",
            "arn:aws:iam::767398066589:role/team_c"
          ]
        },
        Action = [
          "s3:ListBucket"
        ],
        Resource = "arn:aws:s3:::bucket-team-c"
      },
      {
        Sid    = "AllowMehdi",
        Effect = "Allow",
        Principal = {
          "AWS" : [
            "arn:aws:iam::767398066589:role/Admin"
          ]
        },
        Action = "s3:*",
        Resource = [
          "arn:aws:s3:::bucket-team-c",
          "arn:aws:s3:::bucket-team-c/*"
        ]
      }
    ]
  })
}


#Policy for Team A created
resource "aws_iam_policy" "policy-team-a" {
  name        = "policy-team-a"
  path        = "/"
  description = "PolicyForTeamA"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "BasicsControlsForA",
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ],
        Resource = [
          "arn:aws:s3:::bucket-team-a/*",
          "arn:aws:s3:::bucket-team-a"
        ]
      },
      {
        Sid    = "ListBuckets",
        Effect = "Allow",
        Action = [
          "s3:ListAllMyBuckets"
        ],
        Resource = [
          "arn:aws:s3:::*"
        ]
      }
    ]
  })
}

# Attach the policy to the team_a role
resource "aws_iam_policy_attachment" "attach_policy_to_team_a" {
  name       = "attach_policy_to_team_a"
  policy_arn = aws_iam_policy.policy-team-a.arn
  roles      = [aws_iam_role.team_a.name]
}

#Policy for Team B created
resource "aws_iam_policy" "policy-team-b" {
  name        = "policy-team-b"
  path        = "/"
  description = "PolicyForTeamB"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "PolicyBucketB",
        Effect = "Allow",
        Action = [
          "s3:PutObject"
        ],
        Resource = [
          "arn:aws:s3:::bucket-team-a/*",
          "arn:aws:s3:::bucket-team-a",
          "arn:aws:s3:::bucket-team-c/*",
          "arn:aws:s3:::bucket-team-c",
          "arn:aws:s3:::bucket-team-b/*",
          "arn:aws:s3:::bucket-team-b"
        ]
      },
      {
        Sid    = "BasicsControlsForB",
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:DeleteObject"
        ],
        Resource = [
          "arn:aws:s3:::bucket-team-b/*",
          "arn:aws:s3:::bucket-team-b"
        ]
      },{
        Sid    = "ListBuckets",
        Effect = "Allow",
        Action = [
          "s3:ListAllMyBuckets"
        ],
        Resource = [
          "arn:aws:s3:::*"
        ]
      }
    ]
  })
}

# Attach the policy to the team_b role
resource "aws_iam_policy_attachment" "attach_policy_to_team_b" {
  name       = "attach_policy_to_team_b"
  policy_arn = aws_iam_policy.policy-team-b.arn
  roles      = [aws_iam_role.team_b.name]
}

#Policy for Team C created
resource "aws_iam_policy" "policy-team-c" {
  name        = "policy-team-c"
  path        = "/"
  description = "PolicyForTeamC"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "BasicsControlsForC",
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        Resource = [
          "arn:aws:s3:::bucket-team-c/*",
          "arn:aws:s3:::bucket-team-c"
        ]
      },
      {
        Sid    = "PolicyReadBucketC",
        Effect = "Allow",
        Action = [
          "s3:GetObject"
        ],
        Resource = [
          "arn:aws:s3:::bucket-team-a/*",
          "arn:aws:s3:::bucket-team-a",
          "arn:aws:s3:::bucket-team-c/*",
          "arn:aws:s3:::bucket-team-c"
        ]
      },
      {
        Sid    = "ListBuckets",
        Effect = "Allow",
        Action = [
          "s3:ListAllMyBuckets"
        ],
        Resource = [
          "arn:aws:s3:::*"
        ]
      }
    ]
  })
}

# Attach the policy to the team_c role
resource "aws_iam_policy_attachment" "attach_policy_to_team_c" {
  name       = "attach_policy_to_team_c"
  policy_arn = aws_iam_policy.policy-team-c.arn
  roles      = [aws_iam_role.team_c.name]
}

#Policy for Adrmin created
resource "aws_iam_policy" "policy-admin" {
  name        = "policy-admin"
  path        = "/"
  description = "PolicyForAdmin"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowAdminAllBuckets",
        "Effect" : "Allow",
        "Action" : [
          "s3:*"
        ],
        "Resource" : [
          "arn:aws:s3:::*",
        ]
      },
    ]
  })
}

# Attach the policy to the Admin role
resource "aws_iam_policy_attachment" "attach_policy_to_Admin" {
  name       = "attach_policy_to_Admin"
  policy_arn = aws_iam_policy.policy-admin.arn
  roles      = [aws_iam_role.Admin.name]
}