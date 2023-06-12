set -e

aws ssm describe-parameters --region us-east-1 --query "Parameters[*].Name" | xargs -n1  |sed -e 's/,//' | grep ${ENV}.${COMPONENT} >/parameter-store/names

rm -f /parameter-store/params

for param in `cat /parameter-store/names`; do
  VALUE=$(aws ssm get-parameters --region us-east-1 --names $param  --with-decryption --query Parameters[0].Value | sed 's/"//g'  )
  KEY=$(echo $param | awk -F . '{print $NF}')
  echo export $KEY=\"$VALUE\" >>/parameter-store/params
  cat /parameter-store/params
done