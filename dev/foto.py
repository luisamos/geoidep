import base64

# Tu cadena base64 (acortada aquí para el ejemplo)
data = """/9j/4AAQSkZJRgABAgAAAQABAAD..."""

# Decodificar y guardar como imagen
with open("imagen.jpg", "wb") as f:
    f.write(base64.b64decode(data))

print("✅ Imagen guardada como imagen.jpg")


echo "/9j/4AAQSkZJRgABAgAAAQABAAD..." | base64 --decode > imagen.jpg
