default {
    state_entry() {
        llSay(0, "Bot iniciado. Escribe algo en el chat local.");
        llListen(0, "", NULL_KEY, ""); // Escucha todos los mensajes en el canal 0 (chat local)
    }

    listen(integer channel, string name, key id, string message) {
        llSay(0, "Procesando...");
        string url = "http://localhost:11434/api/chat"; // URL de la API de Ollama
        string requestBody = "{\"model\": \"phi3:latest\", \"messages\": [{ \"role\": \"user\", \"content\": \"" + llEscapeURL(message) + "\" }], \"stream\": false}";
        llHTTPRequest(url, [HTTP_METHOD, "POST", HTTP_MIMETYPE, "application/json"], requestBody);
    }

    http_response(key id, integer status, list metadata, string body) {
        if (status == 200) {
            // Extraer el valor de la clave "content"
            integer content_start = llSubStringIndex(body, "\"content\":\"") + 11;
            integer content_end = llSubStringIndex(body, "\",\"done_reason\"");
            string content = llDeleteSubString(body, content_end, -1);
            content = llDeleteSubString(content, 0, content_start - 1);
            content = llUnescapeURL(content); // Elimina cualquier escape de URL en la cadena

            // Reemplazar "},\"done_reason\"" por "*"
            content = llDumpList2String(llParseString2List(content, ["},\"done_reason\""], []), "*");

            // Encontrar y eliminar cualquier contenido después de "stop\",\"done\":true,\"total_duration\":"
            integer stop_index = llSubStringIndex(content, ":\"stop\",\"done\":true,\"total_duration\":");
            if (stop_index != -1) {
                content = llDeleteSubString(content, stop_index, -1);
            }

            // Eliminar las últimas 50 letras si la longitud es mayor a 50
            integer length = llStringLength(content);
            if (length > 50) {
                content = llDeleteSubString(content, length - 50, length);
            }

            llSay(0, "Respuesta del bot: " + content);
        } else if (status == 0) {
            llSay(0, "Error: No se pudo conectar con el servidor.");
        } else {
            llSay(0, "Error en la respuesta del bot. Estado: " + (string)status);
        }
    }
}
