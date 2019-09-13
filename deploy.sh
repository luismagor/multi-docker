docker build -t luismago/multi-client -f ./client/Dockerfile ./client
docker build -t luismago/multi-server -f ./server/Dockerfile ./server
docker build -t luismago/multi-worker -f ./worker/Dockerfile ./worker
docker push luismago/multi-client
docker push luismago/multi-server
docker push luismago/multi-worker
kubectl apply -f k8s
# -t luismago/multi-server:latest -t luismago/multi-server:$GIT_SHA
#kubectl set image deployments/server-deployment server=luismago/multi-server:$GIT_SHA
kubectl rollout restart deployment server-deployment
kubectl rollout restart deployment client-deployment
kubectl rollout restart deployment worker-deployment