# Dependency Injection with Provider

Este proyecto implementa inyección de dependencias usando el patrón Provider en Flutter.

## Estructura

```
lib/
├── myapp/
│   ├── app.dart                    # MyApp con MultiProvider configurado
│   ├── datasources/               # Fuentes de datos
│   ├── repositories/              # Repositorios
│   ├── usecases/                  # Casos de uso
│   └── widgets/                   # Widgets de ejemplo
├── di/
│   └── injection.dart             # Configuración de dependencias
├── domain/                        # Entidades y contratos (sin cambios)
├── data/                          # Modelos (sin cambios)
├── presentation/                  # UI (sin cambios)
└── main.dart                      # Punto de entrada limpio
```

## Configuración de Dependencias

Las dependencias se registran en `lib/di/injection.dart`:

```dart
List<Provider> getProviders() {
  return [
    // Datasources
    Provider<CatBreedRemoteDatasource>(
      create: (_) => CatBreedRemoteDatasource(),
    ),
    
    // Repositories
    ProxyProvider<CatBreedRemoteDatasource, CatBreedRepositoryImpl>(
      update: (_, datasource, __) => CatBreedRepositoryImpl(datasource),
    ),
    
    // Use Cases
    ProxyProvider<CatBreedRepositoryImpl, GetCatBreedsUseCase>(
      update: (_, repository, __) => GetCatBreedsUseCase(repository),
    ),
    // ...
  ];
}
```

## Uso en Widgets

### Método 1: Provider.of
```dart
final getCatBreedsUseCase = Provider.of<GetCatBreedsUseCase>(context, listen: false);
final result = await getCatBreedsUseCase();
```

### Método 2: context.read
```dart
final searchCatBreedUseCase = context.read<SearchCatBreedUseCase>();
final result = await searchCatBreedUseCase('Persian');
```

### Método 3: Consumer
```dart
Consumer<GetCatBreedsUseCase>(
  builder: (context, getCatBreedsUseCase, child) {
    // Usar getCatBreedsUseCase aquí
    return Widget();
  },
)
```

## Beneficios

1. **Desacoplamiento**: Las dependencias se inyectan automáticamente
2. **Testabilidad**: Fácil mock de dependencias en pruebas
3. **Mantenibilidad**: Cambios centralizados en la configuración
4. **Escalabilidad**: Fácil agregar nuevas dependencias

## Ejemplo Completo

Ver `lib/myapp/widgets/example_usecase_widget.dart` para un ejemplo completo de cómo usar los casos de uso con Provider.