docker build -t luismago/multi-client:latest -t luismago/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t luismago/multi-server:latest -t luismago/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t luismago/multi-worker:latest -t luismago/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push luismago/multi-client:latest
docker push luismago/multi-server:latest
docker push luismago/multi-worker:latest

docker push luismago/multi-client:$GIT_SHA
docker push luismago/multi-server:$GIT_SHA
docker push luismago/multi-worker:$GIT_SHA
kubectl apply -f k8s

kubectl set image deployments/server-deployment server=luismago/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=luismago/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=luismago/multi-worker:$GIT_SHA
