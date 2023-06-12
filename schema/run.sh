source /parameter-store/params
mkdir /code
cd /code
git clone https://github.com/pcs1999/${COMPONENT}.git .
if [ $? -ne 0] ; then
  echo clone failed
  exit 1
fi

cd /code/schema
if [ $SCHEMA_TYPE == "mongodb" ] ; then
    curl -L -o  https://truststore.pki.rds.amazonaws.com/us-east-1/us-east-1-bundle.pem

    mongo --ssl --host ${DOCUMENTDB_ENDPOINT} --sslCAFile /app/rds-combined-ca-bundle.pem --username ${DOCUMENTDB_USER} --password ${DOCUMENTDB_PASS} < /code/schema/${COMPONENT}.js

elif [ $SCHEMA_TYPE == "mysql" ] ; then
  echo
fi