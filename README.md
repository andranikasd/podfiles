Here’s a strong **README draft** for your `podfiles` repo based on your tagline *“Fuckless Debugging in containerized environments”*.
It sets the tone as fun but still professional enough for GitHub. You can tone up/down the language as you like.

---

# podfiles

**Fuckless Debugging in containerized environments**

`podfiles` gives you the tools you *always* need inside pods and containers — without rebuilding images or fighting RBAC surprises.
Think **ping, nslookup, wget, traceroute, sh** — injected on-demand into any running container.

---

## ✨ Features

* **Kubernetes Pods**

  * `podfiles k8s shell <pod>` → Open a debug shell.

    * First tries an ephemeral container (`kubectl debug` + netshoot).
    * Falls back to copying a static BusyBox binary if ephemeral containers are blocked.
  * `podfiles k8s copy-busybox <pod>` → Upload BusyBox and symlink selected applets.
  * Namespaced aware (`-n namespace`).

* **Docker Containers**

  * `podfiles docker netshoot <container>` → Run netshoot sidecar sharing the container’s network namespace.
  * `podfiles docker copy-busybox <container>` → Copy BusyBox into the container for missing tools.

* **Smart Fallbacks**

  * If ephemeral debugging is blocked, BusyBox copy still works.
  * Works on both **amd64** and **arm64** hosts.

---

## 🚀 Install

```bash
curl -fsSL https://raw.githubusercontent.com/andranikasd/podfiles/master/scripts/install.sh | bash
```

Uninstall:

```bash
curl -fsSL https://raw.githubusercontent.com/andranikasd/podfiles/master/scripts/uninstall.sh | bash
```

---

## 🔥 Quick Start

### Kubernetes

```bash
# Open a debug shell in a pod
podfiles k8s shell -n my-ns my-pod

# Inject BusyBox with ping + nslookup only
podfiles k8s copy-busybox -n my-ns my-pod --as "ping,nslookup"
```

### Docker

```bash
# Sidecar netshoot shell sharing container’s network
podfiles docker netshoot my-container -- bash

# Copy BusyBox into container
podfiles docker copy-busybox my-container --as "ping,wget,sh"
```

---

## ⚙️ Requirements

* **kubectl** (for K8s mode)
* **docker** (for Docker mode)
* **curl** (to fetch static BusyBox binaries)
* Kubernetes ≥1.23 for ephemeral containers (if RBAC permits)

---

## 🔒 Security Notes

* Ephemeral containers persist in the pod spec until restart, but do not restart with the pod.
* BusyBox lives in `/tmp/podfiles/bin` inside the target — it disappears after restart.
* `ping` requires `CAP_NET_RAW`; if it fails inside BusyBox, use `podfiles k8s attach` instead.

---

## 🛠 Configuration

| Env Var                      | Default                    | Purpose                                        |
| ---------------------------- | -------------------------- | ---------------------------------------------- |
| `PODFILES_EPHEMERAL_IMAGE`   | `nicolaka/netshoot:latest` | Image used for ephemeral containers & netshoot |
| `PODFILES_BUSYBOX_URL_AMD64` | BusyBox musl binary        | Download URL (x86\_64)                         |
| `PODFILES_BUSYBOX_URL_ARM64` | BusyBox musl binary        | Download URL (arm64)                           |
| `PODFILES_TMP_DIR`           | `/tmp/podfiles`            | Temp dir inside container/pod                  |
| `PODFILES_BIN_DIR`           | `/tmp/podfiles/bin`        | Where BusyBox & symlinks are installed         |

---

## 🧪 Development

```bash
# lint shell scripts
make lint

# run bats tests
make test
```

---

## 🤝 Contributing

1. Fork + clone the repo.
2. Use **Conventional Commits** (`feat:`, `fix:`, `docs:`).
3. Run `make lint && make test` before PRs.
4. PR titles are validated by CI.

See [CONTRIBUTING.md](./CONTRIBUTING.md) for details.

---

## 📜 License

MIT. See [LICENSE](./LICENSE).

---

Do you want me to also add **ASCII usage examples** (like diagrams showing the pod → ephemeral container → BusyBox fallback flow) to make the README more visually engaging?