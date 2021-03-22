#!/bin/sh

BUCKET=kwood.me

echo "Deploying kwoodsite to bucket $BUCKET"

s3cmd sync js/ s3://$BUCKET/js/ --delay-updates -M
s3cmd sync css/ s3://$BUCKET/css/ --delay-updates -M
s3cmd sync img/ s3://$BUCKET/img/ --delay-updates -M
s3cmd sync vendor/ s3://$BUCKET/vendor/ --delay-updates -M
s3cmd put index.html s3://$BUCKET/index.html --delay-updates -M

# Set JS and CSS cache control headers. These are hashed filenames, so we can set them to very far-future.
# This will get slow as these directories fill up with old files. We can either clean out old ones periodically
# or figure out how to only modify the new ones.
#s3cmd --recursive modify --add-header="Cache-Control:public, max-age=31536000" s3://$BUCKET/js
#s3cmd --recursive modify --add-header="Cache-Control:public, max-age=31536000" s3://$BUCKET/css

echo "Deploy complete... view at http://$BUCKET.s3-website-us-west-1.amazonaws.com"

