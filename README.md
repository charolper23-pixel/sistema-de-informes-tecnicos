# sistema-de-informes-tecnicos


## ⚙️ Lógica de Trabajo del Sistema

El núcleo de este sistema está diseñado para modernizar y digitalizar la gestión de TI en la institución, **sustituyendo el antiguo flujo tradicional de informes técnicos en papel impreso y llenado manual** por un ecosistema centralizado, ágil y totalmente auditable. 

El sistema rompe con el concepto del "ticket genérico" y lo reemplaza por **Informes Técnicos Dinámicos** con un flujo de validación simplificado, garantizando la eficiencia, el control institucional y la inmutabilidad de los datos una vez aprobados.

---

### 👥 1. Roles y Actores del Sistema

El sistema opera bajo un modelo de control de acceso basado en dos perfiles principales:

| Rol | Departamento | Acciones Permitidas |
| :--- | :--- | :--- |
| **Solicitante** | Cualquier área de la institución | Seleccionar plantillas, llenar y enviar informes técnicos, ver el estado histórico de sus requerimientos. |
| **Técnico** | Soporte Técnico / TI | Visualizar la bandeja de entrada, evaluar informes pendientes, registrar la solución, aprobar y congelar el documento. |

---

### 📋 2. Motor de Plantillas Dinámicas

Para erradicar los reportes incompletos o ambiguos que ocurrían en el formato de papel, el sistema utiliza formularios inteligentes:
* El sistema almacena **Tipos de Plantillas** según el problema (ej. *Falla de Red*, *Avería de Hardware*, *Solicitud de Software*).
* Cada plantilla define sus propios **Campos Obligatorios** específicos (ej. Dirección IP, Código de Bien Nacional o Nombre del software).
* La interfaz de usuario se renderiza automáticamente leyendo este esquema, obligando al solicitante a entregar los datos técnicos precisos desde el primer instante.

---

### 🔄 3. Ciclo de Vida del Informe (Flujo de Estados)

Todo informe técnico atraviesa un flujo de control estricto que asegura el orden institucional:

| Estado | Descripción | Permisos |
| :--- | :--- | :--- |
| **🟢 Pendiente** | El solicitante envía el formulario. El informe entra a la bandeja de soporte técnico y espera ser atendido. | El solicitante ya no puede modificarlo; el Técnico puede evaluarlo. |
| **🔒 Aprobado** | El técnico asiste al lugar, resuelve la incidencia y valida el informe en el sistema. | El registro se congela de forma permanente. Se habilita la opción de descarga. |

---

### ✅ 4. Validación y Registro de Aprobación

Para mantener un control claro y transparente de los informes procesados, al momento de cerrar un caso el sistema ejecuta la siguiente lógica en la capa del Controlador:

1. **Registro de Responsable:** Captura automáticamente la identidad (Nombre, Usuario o ID) del ingeniero técnico que resolvió el problema.
2. **Estampa de Tiempo:** Almacena la fecha y hora exacta en la que se validó el requerimiento en el sistema.
3. **Bloqueo de Registro:** El estado cambia a "Aprobado", lo que inhabilita cualquier intento de edición en la base de datos, dejando una constancia digital limpia y segura de quién autorizó el cierre.

---

### 📄 5. Generación de Documentos Oficiales (Descarga)

Una vez que un informe adquiere el estado de **"Aprobado"**, el sistema habilita un botón de exportación para el usuario:
* El controlador recopila los datos del formulario, los datos del técnico que aprobó y la estampa de tiempo.
* Compila la información en un formato estructurado oficial (descargable).
* Este documento sirve como constancia digital o física (sustituyendo los antiguos archivadores de papel) tanto para el departamento solicitante como para las auditorías internas del departamento de TI.
