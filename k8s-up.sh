#!/bin/bash

echo "🚀 Iniciando túneles de Kubernetes..."

# 1. Túnel para Argo CD (Puerto 8080)
# Usamos & para enviarlo al fondo y disown para que no se cierre al salir
kubectl port-forward svc/argocd-server -n argocd 8080:443 > /dev/null 2>&1 &
echo "✅ Argo CD listo en: https://localhost:8080"

# 2. Túnel para tu Web (Puerto 9090)
kubectl port-forward svc/mi-servicio-web -n mi-app-pro 9090:80 > /dev/null 2>&1 &
echo "✅ Tu App lista en: http://localhost:9090"

echo "💡 Para detener los túneles usa: killall kubectl"