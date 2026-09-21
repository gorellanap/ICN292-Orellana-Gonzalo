# ICN292-Orellana-Gonzalo
Gonzalo Joaquín Orellana Peña / gorellanap
ICN-292, Segundo Semestre 2026



# Laboratorio 3: Automatización de Procesos en n8n — Triage de Devoluciones
---
## 1. Parámetros usados
* **Semilla (S):** `345`
* **Umbral de Monto (U):** `$75.000 CLP`
* **Plazo Máximo (D):** `14 días`

---

## 2. Descripción del Proyecto
Este repositorio contiene la solución oficial del **Laboratorio 3**, implementando un motor de reglas de triage de devoluciones para la empresa **AndesHogar SpA** sobre la plataforma **n8n**. El sistema automatiza la recepción mediante Webhook, la clasificación según reglas de negocio, la consulta externa de indicadores económicos (UF desde `mindicador.cl`) y la generación de reportes diarios consolidados.

---

## 3. Estructura del Repositorio y Workflows

* `/ICN292-Lab3-Orellana-Gonzalo-triage.json` : Workflow principal de triage de devoluciones.
* `/ICN292-Lab3-Orellana-Gonzalo-emisor.json` : Workflow emisor auxiliar para el lote de 15 solicitudes.
* `/ICN292-Lab3-Orellana-Gonzalo-resumen.json` : Workflow programado de consolidación diaria (Schedule Trigger a las 20:00 hrs).
* `/informe/ICN292-Lab3-Orellana-Gonzalo.pdf` : Informe escrito final en formato PDF 
* `/informe/ICN292-Lab3-Orellana-Gonzalo.docx` : Copia editable en formato Word.

---

## 4. Instrucciones para Importar en n8n
1. Descargar los archivos `.json` de este repositorio.
2. En n8n, crear un nuevo flujo e importar cada archivo desde la opción **Import from File**.
3. Activar el flujo principal mediante el interruptor **Active / Published** (verde).
