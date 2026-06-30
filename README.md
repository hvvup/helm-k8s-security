# k8s-security Helm Chart

A Helm chart for applying Kubernetes security hardening to namespaces — enforcing Network Policies and Pod Security Standards.

## Features

- **NetworkPolicy**: Default deny-all ingress, with allowlist for trusted namespaces and ports
- **Pod Security Standards**: Namespace-level label enforcement (`baseline` / `restricted` / `privileged`)

## Prerequisites

- Kubernetes 1.23+
- Helm 3.x
- [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/) enabled on the cluster

## Installation

```bash
helm install my-release ./k8s-security
```

Override default values with a custom file:

```bash
helm install my-release ./k8s-security -f values.yaml
```

## Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `namespace` | Target namespace | `default` |
| `networkPolicy.enabled` | Enable NetworkPolicy resources | `true` |
| `networkPolicy.defaultDenyIngress` | Create a deny-all ingress policy | `true` |
| `networkPolicy.defaultDenyEgress` | Create a deny-all egress policy | `true` |
| `networkPolicy.allowedNamespaces` | Namespaces allowed to send ingress traffic | `[monitoring, ingress-nginx]` |
| `networkPolicy.allowedIngressPorts` | Ports allowed for ingress | `80/TCP, 443/TCP` |
| `podSecurity.enabled` | Enable Pod Security Standard labels | `true` |
| `podSecurity.level` | Security level (`baseline` / `restricted` / `privileged`) | `restricted` |
| `podSecurity.enforce` | Action for enforce mode | `warn` |
| `podSecurity.audit` | Action for audit mode | `audit` |
| `podSecurity.warn` | Action for warn mode | `warn` |

## Rendering Templates (dry-run)

```bash
helm template my-release ./k8s-security
```

## Maintainers

| Name |
|------|
| hvvup |
