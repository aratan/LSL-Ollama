import xmlrpc.client

# Configuración de la conexión RemoteAdmin OpenSimulator
remote_admin_url = "http://localhost:9000/"
remote_admin_password = "123"
region_name = "nigth_city"
avatar_uuid = "5fc5fd48-c250-46c8-86f0-7aecc7711b73"
new_position = {"x": 128.0, "y": 128.0, "z": 25.0}

# Comando para teletransportar al avatar
teleport_command = f'admin_teleport_user {avatar_uuid} {region_name} {new_position["x"]} {new_position["y"]} {new_position["z"]}'

try:
    # Conectar al servidor XML-RPC
    server = xmlrpc.client.ServerProxy(remote_admin_url)

    # Ejecutar el comando de RemoteAdmin
    teleport_command = "Hola a todos"
    response = server.admin_broadcast({'password': remote_admin_password, 'message': teleport_command})

    print("Comando enviado con éxito:")
    print(response)
except Exception as e:
    print(f"Error al enviar el comando: {e}")
