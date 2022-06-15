# qr_reader

Aplicacion que lee Codigos QR / desarrollado en el curso de Fernando Herrera.

Pagina para crear QR: https://www.qrcode.es/es/generador-qr-code/

Ejemplo de direcciones: https://www.youtube.com

Ejemplo de Mapas: geo:6.279170,-75.589249

## Dependencias utilizadas

- Barcode_scanner -> Para escanear los codigos QR
- Provider -> Para usar estados y funciones globales en toda la App
- SQLite -> Usado para guardar los registros de mapa y/o geolocalización
- GoogleMaps -> Para mostrar las ubicaciones registradas en la App
- Url_launcher -> Usado para abrir el navegador con la Dirección url registrada
- Path_provider -> Para obtener el directorio y poder guardar la DB
