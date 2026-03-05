# IGM Assignment 2 – Iluminación PBR vs Phong

**Autores:** Daniel Quintillán Quintillán y Álvaro Santiso Freire

## Descripción

La principal diferencia que se puede apreciar en esta demo entre la iluminación PBR y la iluminación Phong clásica tiene que ver con la conservación de la energía.
La iluminación PBR respeta este principio; es decir: la luz reflejada por un objeto nunca puede ser mayor que la luz emitida por las fuentes lumínicas.
Por su parte, la iluminación Phong clásica ignora la luz ambiente del motor gráfico y la sustituye por un componente ambiente definido para cada objeto iluminado. Esto implica que si apagamos todas las fuentes de luz y deshabilitamos el cielo del WorldEnvironment estará toda la simulación a oscuras con la excepción de la esfera Phong. Esta esfera emitirá la luz de su componente.
Además, al ser mayoritariamente difusa, la iluminación de la esfera iluminada mediante Phong depende mayoritariamente de la intensidad y posición de los focos de luz, pero no de la posición de la cámara.
Las esferas PBR, por otro lado, presentan reflejos especulares que se mueven con la cámara.

## Abrir en Godot

Para que Godot reconozca el proyecto, abre la carpeta `lighting/` (contiene el archivo `project.godot`).

## Scripts custom

Los scripts se encuentran en la carpeta `lighting/`:

| Archivo | Descripción |
|---------|-------------|
| `lighting/fps_camera.gd` | Controlador de cámara en primera persona. Captura el ratón y permite moverse con WASD y rotar la vista con el ratón. |
| `lighting/cameracontrol.gd` | Gestor global de la escena. Permite ciclar entre cámaras, encender/apagar luces individuales, activar/desactivar la oclusión ambiental (SSAO) y mostrar/ocultar el cielo del `WorldEnvironment`. |
| `lighting/sphere_3.gdshader` | Shader espacial que implementa el modelo de iluminación Phong clásico de forma manual (ambiente + difusa + especular), desactivando la iluminación PBR de Godot para comparar visualmente ambos modelos. |