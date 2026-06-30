# k8s-security Helm Chart

A Helm chart for applying Kubernetes security hardening to namespaces — enforcing Network Policies, Pod Security Standards, and Zero Trust mTLS via Linkerd.

## Features

- **NetworkPolicy**: Default deny-all ingress, with allowlist for trusted namespaces and ports
- **Pod Security Standards**: Namespace-level label enforcement (`baseline` / `restricted` / `privileged`)
- **Zero Trust (Linkerd)**: mTLS enforcement, AuthorizationPolicy per service, and default-deny server policy

## Prerequisites

- Kubernetes 1.23+
- Helm 3.x
- [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/) enabled on the cluster
- Linkerd CLI (required only when `zeroTrust.enabled: true`)

## Installation

```bash
helm install my-release ./k8s-security
```

Override default values with a custom file:

```bash
helm install my-release ./k8s-security -f values.yaml
```

Zero Trust disabled (Linkerd not required):

```bash
helm install my-release ./k8s-security --set zeroTrust.enabled=false
```

## Configuration

### Network Policy

| Parameter | Description | Default |
|-----------|-------------|---------|
| `namespace` | Target namespace | `default` |
| `networkPolicy.enabled` | Enable NetworkPolicy resources | `true` |
| `networkPolicy.defaultDenyIngress` | Create a deny-all ingress policy | `true` |
| `networkPolicy.defaultDenyEgress` | Create a deny-all egress policy | `true` |
| `networkPolicy.allowedNamespaces` | Namespaces allowed to send ingress traffic | `[monitoring, ingress-nginx]` |
| `networkPolicy.allowedIngressPorts` | Ports allowed for ingress | `80/TCP, 443/TCP` |

### Pod Security

| Parameter | Description | Default |
|-----------|-------------|---------|
| `podSecurity.enabled` | Enable Pod Security Standard labels | `true` |
| `podSecurity.level` | Security level (`baseline` / `restricted` / `privileged`) | `restricted` |
| `podSecurity.enforce` | Action for enforce mode | `warn` |
| `podSecurity.audit` | Action for audit mode | `audit` |
| `podSecurity.warn` | Action for warn mode | `warn` |

### Zero Trust (Linkerd)

| Parameter | Description | Default |
|-----------|-------------|---------|
| `zeroTrust.enabled` | Enable Linkerd mTLS and authorization policies | `true` |
| `zeroTrust.mtls.mode` | mTLS mode (`STRICT`) | `STRICT` |
| `zeroTrust.authorizationPolicy.defaultDeny` | Create a default-deny Server policy | `true` |
| `zeroTrust.authorizationPolicy.allowedServices` | List of service-to-service authorization rules | see values.yaml |
| `linkerd-control-plane.identityTrustAnchorsPEM` | Trust anchor certificate (PEM) | `""` |
| `linkerd-control-plane.identity.issuer.tls.crtPEM` | Issuer certificate (PEM) | `""` |
| `linkerd-control-plane.identity.issuer.tls.keyPEM` | Issuer private key (PEM) | `""` |

## Templates

| Template | Description |
|----------|-------------|
| `templates/network-policy.yaml` | Deny-all and allowlist NetworkPolicy resources |
| `templates/pod-security.yaml` | Namespace Pod Security Standard labels |
| `templates/peer-authentication.yaml` | Linkerd Namespace injection and mTLS config |
| `templates/authorization-policy.yaml` | Linkerd Server, AuthorizationPolicy, and MeshTLSAuthentication resources |

## Rendering Templates (dry-run)

```bash
helm template my-release ./k8s-security
```

## Maintainers

| Name |
|------|
| hvvup |
