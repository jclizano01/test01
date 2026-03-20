Aplica el archivo:
kubectl apply -f web-basica.yaml


Verifica los componentes:
kubectl get deployments -n mi-app-pro
kubectl get pods -n mi-app-pro
kubectl get svc

Como usamos type: LoadBalancer, K3s le asignará una IP interna.
Si estás en local, puedes usar el túnel rápido para verlo en el navegador:

kubectl port-forward svc/mi-servicio-web 8080:80



Explicación rápida de las partes:
apiVersion y kind: Le dicen a Kubernetes qué tipo de objeto estás creando.
metadata: El nombre que tú le das al recurso.
spec: El "estado deseado" (lo que quieres que pase).
labels: Son como etiquetas adhesivas. El Service usa el selector para encontrar a los Pods que tengan la misma etiqueta. 


borrar todo lo creado
kubectl delete -f web-basica.yaml

cambiar de contexto
kubectl config set-context --current --namespace=mi-app-pro

Borrar un Namespace es la forma más rápida y potente de limpiar tu clúster,
porque Kubernetes se encarga de eliminar absolutamente todo lo que haya dentro (Pods, Services, Deployments, ConfigMaps) de un solo golpe.

kubectl delete namespace mi-app-pro


Mira tus 2 pods actuales:
kubectl get pods -n mi-app-pro


Escala a 5 instancias sin tocar el archivo YAML:
kubectl scale deployment mi-servidor-web --replicas=5 -n mi-app-pro

ver los pdos
kubectl get pods -n mi-app-pro -w
-w: observar 

matar pod
kubectl delete pod [NOMBRE_DEL_POD] -n mi-app-pro


kubectl describe pod [NOMBRE_DEL_POD] -n mi-app-pro

kubectl top pods

kubectl top nodes


docker
sudo docker build -t jclizano/mi-web:v1 .

sudo docker push jclizano/mi-web:v1

ARGO CD

kubectl create namespace argocd

2. Instalar Argo CD (Versión Estable)
kubectl apply -n argocd -f https://raw.githubusercontent.com

# Descarga usando la URL directa de la versión estable
curl -L https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml > install-argocd.yaml

head -n 5 install-argocd.yaml


# Asegúrate de tener el namespace creado
kubectl create namespace argocd || true

# Aplica el archivo que acabamos de descargar
kubectl apply -n argocd -f install-argocd.yaml

validar pods todos ready
kubectl get pods -n argocd

traer contraseña
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
df90Zl23HpkUug2e

ocurrio un error en los pods
paso1 
kubectl delete namespace argocd

2. Crea el namespace de nuevo:
kubectl create namespace argocd

1. Forzar el borrado de los Pods
kubectl delete pods --all -n argocd --force --grace-period=0

Para solucionarlo en tu Ubuntu, debes usar el flag --server-side. Esto le dice a Kubernetes que procese el archivo en el servidor y no guarde ese historial gigante en los metadatos.

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml  --server-side

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

terminal:
kubectl port-forward svc/argocd-server -n argocd 8080:443 (Panel)
kubectl port-forward svc/mi-servicio-web -n mi-app-pro 9090:80 (App)


permisos 
chmod +x k8s-up.sh


while true; do kubectl port-forward svc/mi-servicio-web -n mi-app-pro 9090:80; sleep 1; done
