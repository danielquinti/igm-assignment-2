shader_type spatial;

// Desactivamos la iluminación PBR de Godot para calcular la luz manualmente.
render_mode ambient_light_disabled;

uniform sampler2D textura_albedo : source_color;  // Mapa difuso
uniform sampler2D textura_especular;              // Mapa especular

// Parámetros del modelo de Phong clásico
uniform vec3 color_luz_ambiente : source_color = vec3(0.1, 0.1, 0.1); // Color luz ambiente
uniform float ka : hint_range(0.0, 1.0) = 1.0; // Coeficiente ambiental
uniform float kd : hint_range(0.0, 1.0) = 1.0; // Coeficiente difuso
uniform float ks : hint_range(0.0, 2.0) = 1.0; // Coeficiente especular
uniform float exponente_brillo : hint_range(1.0, 256.0) = 32.0; // Shininess

// Pasa la lectura del mapa especular de fragment() a light()
varying float mascara_especular;

void fragment() {
    // Lectura de la textura difusa
    vec3 color_base = texture(textura_albedo, UV).rgb;
    ALBEDO = color_base;

    // Lectura de la textura especular (0.0 = mate, 1.0 = brillo)
    mascara_especular = texture(textura_especular, UV).r;

    // Componente ambiente: ka * LuzAmbiente * ColorObjeto
    // Se emite como EMISSION porque desactivamos la luz ambiente del motor.
    vec3 luz_ambiente_final = ka * color_luz_ambiente * color_base;
    EMISSION = luz_ambiente_final;
}

void light() {
    // Componente difusa (Ley de Lambert): kd * ColorLuz * ColorObjeto * (N · L)
    float dot_nl = max(dot(NORMAL, LIGHT), 0.0);
    vec3 luz_difusa = kd * LIGHT_COLOR * ALBEDO * dot_nl * ATTENUATION;

    // Componente especular (Phong): ks * ColorLuz * (V · R)^n * MapaEspecular
    vec3 R = reflect(-LIGHT, NORMAL);
    float dot_vr = max(dot(VIEW, R), 0.0);
    float factor_brillo = pow(dot_vr, exponente_brillo);
    vec3 luz_especular = ks * LIGHT_COLOR * factor_brillo * mascara_especular * ATTENUATION;

    // Salida
    DIFFUSE_LIGHT += luz_difusa;
    SPECULAR_LIGHT += luz_especular;
}