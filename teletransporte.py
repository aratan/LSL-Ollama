import xmlrpc.client

# Configuración de la conexión RemoteAdmin
remote_admin_url = "http://localhost:9000/"
remote_admin_password = "123"
avatar_uuid = "05233d0f-7794-426c-b97a-6a3b6a8a28da"
region_name = "nigth_city"
new_position = {"x": 117.0, "y": 145.0, "z": 22.0}

try:
    # Conectar al servidor XML-RPC
    server = xmlrpc.client.ServerProxy(remote_admin_url)

    # Intentar teletransportar al avatar usando admin_teleport_agent
    teleport_params = {
        'password': remote_admin_password,
        'region_name': region_name,
        'agent_id': avatar_uuid,
        'pos_x': str(new_position["x"]),
        'pos_y': str(new_position["y"]),
        'pos_z': str(new_position["z"])
    }
    teleport_response = server.admin_teleport_agent(teleport_params)

    print("Comando de teletransporte enviado con éxito:")
    print(teleport_response)

except Exception as e:
    print(f"Error al enviar el comando: {e}")
