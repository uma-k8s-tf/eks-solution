resource "kubernetes_namespace" "kyverno" {
  metadata {
    name = "kyverno"
  }
}
resource "helm_release" "kyverno" {
  name             = "kyverno"
  repository       = "https://kyverno.github.io/kyverno/"
  chart            = "kyverno"
  namespace        = kubernetes_namespace.kyverno.metadata[0].name
  create_namespace = true

  wait    = true
  timeout = 600

  values = [
    file("${path.module}/kyverno-values.yaml")
  ]
}