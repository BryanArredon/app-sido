# `app_sido` — Plan de Issues y Ramas (Repositorio App Flutter: Web, Android e iOS)

Este documento contiene **exclusivamente los Issues y Ramas del repositorio `app_sido`** (Flutter Multiplataforma: **Web, Android e iOS** con Clean Architecture Feature-First, Riverpod, GoRouter y Dio).

> Aunque en la hoja de cálculo general la App aparecía resumida en la Fase 4, al tener su **propio repositorio separado** se desglosa en **14 Issues modulares** para que puedas llevar tus ramas y Pull Requests ordenados en el GitHub Project de `app_sido`.

---

## Tabla Resumen de Issues para el Repo `app_sido` (14 Issues)

| ID | Título del Issue en `app_sido` | Rama Git (`git checkout -b ...`) | Fase / Milestone | Etapa | Tam. | Depende de (App / API) | Estado Actual |
| :--- | :--- | :--- | :--- | :---: | :---: | :---: | :--- |
| **APP-T01** | `[APP-T01] Arquitectura base Clean Architecture, soporte Web/Android/iOS y CI` | `chore/APP-T01-arquitectura-base-multiplataforma` | Base & Core | v2 | M | — | **Listo para subir (100%)** |
| **APP-T02** | `[APP-T02] Integrar paquetes core (flutter_riverpod, go_router, dio) e interceptores JWT` | `chore/APP-T02-riverpod-gorouter-dio` | Base & Core | v2 | M | APP-T01 | Pendiente |
| **APP-T03** | `[APP-T03] Bocetos UX/UI y Design System SIDO (tokens de oferta real, trampa e insignias)` | `docs/APP-T03-bocetos-design-system` | UI/UX & Core | v2 | S | APP-T01 | Pendiente |
| **APP-T04** | `[APP-T04] Feature Auth: Login, Registro, persistencia segura de JWT y sesión multiplataforma` | `feat/APP-T04-feature-auth-jwt` | Features Core | v2 | M | APP-T02, `API-F4-T1` | Pendiente |
| **APP-T05** | `[APP-T05] Feature Deals Feed: Listado de ofertas validadas con Score, ahorro real y pull-to-refresh` | `feat/APP-T05-feature-deals-feed` | Features Core | v2 | L | APP-T02, APP-T03, `API-F4-T1` | Pendiente |
| **APP-T06** | `[APP-T06] Filtros avanzados y buscador (por tienda, categoría, rango de precio y score mínimo)` | `feat/APP-T06-filtros-y-buscador` | Features Core | v2 | M | APP-T05 | Pendiente |
| **APP-T07** | `[APP-T07] Feature Product Detail: Gráfica interactiva de historial (actual vs mediana 90d vs mínimo 180d)` | `feat/APP-T07-detalle-grafica-historial` | Features Core | v2 | L | APP-T05, `API-F4-T1` | Pendiente |
| **APP-T08** | `[APP-T08] Comparador multi-tienda en detalle de producto (Precio Total Real con envío y cupones)` | `feat/APP-T08-comparador-multitienda` | Features Core | v2 | M | APP-T07, `API-F3-T6` | Pendiente |
| **APP-T09** | `[APP-T09] Pantalla de Transparencia: "Ofertas rechazadas y por qué" (alza previa, tachado inflado)` | `feat/APP-T09-ofertas-rechazadas-transparencia` | Diferenciador | v2 | S | APP-T05, `API-F4-T6` | Pendiente |
| **APP-T10** | `[APP-T10] Feature Watchlist & Preferencias: Seguir productos, categorías y ajustar umbral personal` | `feat/APP-T10-watchlist-y-preferencias` | Personalización | v2 | M | APP-T04, `API-F4-T2` | Pendiente |
| **APP-T11** | `[APP-T11] Integrar Notificaciones Push (Firebase Cloud Messaging) en Android, iOS y Web` | `feat/APP-T11-notificaciones-push-fcm` | Alertas App | v2 | M | APP-T10, `API-F4-T3` | Pendiente |
| **APP-T12** | `[APP-T12] Pruebas de widgets e integración de flujos principales + monitoreo con Sentry Flutter` | `test/APP-T12-tests-integracion-y-sentry` | Calidad | v2 | M | APP-T07, APP-T09 | Pendiente |
| **APP-T13** | `[APP-T13] Despliegue Beta (Flutter Web PWA + TestFlight iOS + Firebase App Distribution Android)` | `chore/APP-T13-despliegue-beta-multiplataforma` | Release Beta | v2 | M | APP-T11, APP-T12 | Pendiente |
| **APP-T14** | `[APP-T14] Sección "Para Ti" y alertas de ciclos de recompra (Opcional Fase 6)` | `feat/APP-T14-recomendaciones-para-ti` | Opcional | Opcional | M | APP-T13, `API-F6-T2` | Pendiente |

---

## Equivalencia con tu Hoja de Cálculo Original

| ID en tu Hoja | Dónde vive ahora en `app_sido` |
| :--- | :--- |
| **Base Multiplataforma** | `APP-T01` (Ya completado al 100%) y `APP-T02` |
| **F4-T4** (Bocetos de pantallas) | `APP-T03` |
| **F4-T5** (App móvil / Web: Feed, detalle con gráfica y filtros) | Dividido en `APP-T04` (Auth), `APP-T05` (Feed), `APP-T06` (Filtros), `APP-T07` (Gráfica Historial) y `APP-T08` (Comparador Tiendas) para que no tengas una sola rama gigante |
| **F4-T6** (Panel de "Ofertas rechazadas y por qué") | `APP-T09` |
| **F4-T2** (Preferencias y lista de seguimiento - UI) | `APP-T10` |
| **F4-T3** (Notificaciones push - Cliente) | `APP-T11` |
| **F5-T1 / F5-T2** (Pruebas y Sentry en App) | `APP-T12` |
| **F4-T7** (Beta con 5-20 personas) | `APP-T13` |
| **Fase 6** (Recomendaciones - UI) | `APP-T14` |

---

## Criterios de Aceptación Detallados por Issue (`app_sido`)

### 1. Base, Arquitectura y Diseño
- **`APP-T01` (`chore/APP-T01-arquitectura-base-multiplataforma`) — LISTO PARA SUBIR**:
  - [x] Estructura Feature-First Clean Architecture (`core`, `shared`, `features/users`) bajo `lib/src/`.
  - [x] Cliente HTTP con importación condicional (`http_adapter_web.dart` para JS/Wasm y `http_adapter_io.dart` para Android/iOS) sin romper compilación Web.
  - [x] Resolución automática de `API_BASE_URL` (`10.0.2.2` en Android Emulator vs `127.0.0.1` en iOS/Web).
  - [x] `AdaptiveScaffold` (Bottom Navigation en móvil `<600px`, NavigationRail en Tablet/Web `>=600px`).
  - [x] Permisos de red en `AndroidManifest.xml`, `Info.plist` y URLs limpias en Web (`usePathUrlStrategy`).
- **`APP-T02` (`chore/APP-T02-riverpod-gorouter-dio`)**:
  - [ ] Ejecutar `flutter pub add flutter_riverpod go_router dio`.
  - [ ] Configurar `ProviderScope` en `bootstrap.dart`, rutas declarativas con `GoRouter` (deep-linking compatible con Web/iOS/Android) e interceptor JWT en `Dio`.
- **`APP-T03` (`docs/APP-T03-bocetos-design-system`)**:
  - [ ] Bocetos de las 4 pantallas principales (Feed, Detalle con gráfica, Ofertas rechazadas, Watchlist).
  - [ ] Componentes UI compartidos: `ScoreBadge` (verde `>=0.80`, ámbar `0.70-0.79`), `PriceComparisonTag` y `SellerTrustBadge`.

### 2. Módulos de Negocio (Features)
- **`APP-T04` (`feat/APP-T04-feature-auth-jwt`)**:
  - [ ] Capas `domain`, `data` y `presentation` en `lib/src/features/auth/`.
  - [ ] Almacenamiento seguro de `access_token` y `refresh_token` compatible con Web, Android e iOS.
- **`APP-T05` (`feat/APP-T05-feature-deals-feed`)**:
  - [ ] Feature `lib/src/features/deals/` mostrando tarjetas de ofertas reales con precio actual, precio de referencia (mediana 90d), precio tachado de la tienda, % de descuento real y Score.
  - [ ] Soporte responsivo: lista de 1 columna en móvil y grid de 2-3 columnas en Web/Tablet.
- **`APP-T06` (`feat/APP-T06-filtros-y-buscador`)**:
  - [ ] Filtros por tienda, categoría, descuento real mínimo y ordenamiento por Score o fecha.
- **`APP-T07` (`feat/APP-T07-detalle-grafica-historial`)**:
  - [ ] Pantalla de detalle del producto con gráfica interactiva de 90/180 días.
  - [ ] Líneas horizontales de referencia en la gráfica: **Mediana 90 días** y **Mínimo 180 días**.
- **`APP-T08` (`feat/APP-T08-comparador-multitienda`)**:
  - [ ] Tabla comparativa dentro del detalle del producto mostrando cuánto cuesta en las 5 tiendas (desglosando producto + envío - cupón = Precio Total Real) y reputación del vendedor.
- **`APP-T09` (`feat/APP-T09-ofertas-rechazadas-transparencia`)**:
  - [ ] Pantalla dedicada a mostrar ofertas descartadas por SIDO con etiqueta explicativa del engaño detectado (*"Alza previa al evento"*, *"Precio tachado inflado en +37%"*, *"Oferta permanente"*).
- **`APP-T10` (`feat/APP-T10-watchlist-y-preferencias`)**:
  - [ ] Pantalla para agregar/quitar productos de seguimiento, elegir categorías favoritas y ajustar el slider de umbral personal de notificación.

### 3. Notificaciones, Calidad y Lanzamiento
- **`APP-T11` (`feat/APP-T11-notificaciones-push-fcm`)**:
  - [ ] Integración de `firebase_messaging` en Android, iOS y Web con navegación directa (*deep link*) al detalle de la oferta al tocar la notificación.
- **`APP-T12` (`test/APP-T12-tests-integracion-y-sentry`)**:
  - [ ] Widget tests de Feed, Detalle y Rechazadas + integración de `sentry_flutter`.
- **`APP-T13` (`chore/APP-T13-despliegue-beta-multiplataforma`)**:
  - [ ] Publicación de PWA/Web y distribución en TestFlight (iOS) y Firebase App Distribution (Android) para los primeros 5–20 testers.
- **`APP-T14` (`feat/APP-T14-recomendaciones-para-ti`)**:
  - [ ] Pestaña opcional de recomendaciones personalizadas y recordatorios de recompra de consumibles.
