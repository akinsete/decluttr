enum DecluttrAppEnvironment {
  development,
  production;

  bool get isDevelopment => this == DecluttrAppEnvironment.development;
  bool get isProduction => this == DecluttrAppEnvironment.production;
}
