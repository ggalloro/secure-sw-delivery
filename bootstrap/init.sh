# Initializes APIS, sets up the Google Cloud Deploy pipeline
# bail if PROJECT_ID is not set 
if [[ -z "${PROJECT_ID}" ]]; then
  echo "The value of PROJECT_ID is not set. Be sure to run \"export PROJECT_ID=YOUR-PROJECT\" first"
  return
fi
# sets the current project for gcloud
gcloud config set project $PROJECT_ID
# creates the Artifact Registry repo
gcloud artifacts repositories create maven-demo-app --location=europe-west1 \
--repository-format=docker
# customize the clouddeploy.yaml 
sed -e "s/project-id-here/${PROJECT_ID}/" templates/template.clouddeploy.yaml > clouddeploy.yaml
# customize binauthz policy files from templates
sed -e "s/project-id-here/${PROJECT_ID}/" templates/template.allowlist-policy.yaml > policy/binauthz/allowlist-policy.yaml
sed -e "s/project-id-here/${PROJECT_ID}/" templates/template.attestor-policy.yaml > policy/binauthz/attestor-policy.yaml
# creates the Google Cloud Deploy pipeline
gcloud deploy apply --file clouddeploy.yaml \
--region=europe-west1 --project=$PROJECT_ID