CREATE OR REPLACE STAGE sp500_stage
  URL='s3://your-s3-bucket/sp500_data.csv'
  CREDENTIALS=(AWS_KEY_ID='your-aws-key' AWS_SECRET_KEY='your-aws-secret')
  FILE_FORMAT = (TYPE = CSV FIELD_OPTIONALLY_ENCLOSED_BY='"' SKIP_HEADER = 1);
