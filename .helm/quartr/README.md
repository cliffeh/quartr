# quartr helm chart

To deploy `latest`:

```bash
helm upgrade quartr .helm/quartr --install --namespace quartr --create-namespace
```

To deploy `v0.0.6`:

```bash
helm upgrade quartr .helm/quartr --install \
  --namespace quartr --create-namespace --set image.tag="v0.0.6"
```
