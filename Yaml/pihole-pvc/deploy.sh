#!/usr/bin/bash
kubectl apply -f 00-namespace.yaml
kubectl apply -f 01-pvc.yaml
kubectl apply -f 02-deployment.yaml
kubectl apply -f 03-service.yaml
