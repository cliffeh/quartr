# quartr helm chart

Example usage:

```bash
helm upgrade quartr .helm/quartr --install \
    --namespace quartr --create-namespace
```

To enable tailscale ingress:

```bash
helm upgrade quartr .helm/quartr --install \
    --namespace quartr --create-namespace \
    --set ingress.enabled=true \
    --set ingress.ingressClassName=tailscale
```
