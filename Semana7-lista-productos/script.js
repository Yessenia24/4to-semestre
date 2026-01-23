// 1. Arreglo inicial de productos
const productos = [
    { nombre: "Laptop", precio: 750, descripcion: "Ideal para estudio y trabajo." },
    { nombre: "Mouse", precio: 12, descripcion: "Ergonómico y con luces RGB." },
    { nombre: "Teclado", precio: 45, descripcion: "Mecánico con switches azules." }
];

// 2. Referencias a elementos del DOM
const contenedorLista = document.getElementById('lista-productos');
const botonAgregar = document.getElementById('btn-agregar');

// 3. Función para renderizar la lista completa
function renderizarProductos() {
    // Limpiamos la lista para evitar duplicados al renderizar de nuevo
    contenedorLista.innerHTML = "";

    productos.forEach((producto) => {
        // Creamos el elemento de lista usando una plantilla
        const li = document.createElement('li');
        li.innerHTML = `
            <strong>${producto.nombre}</strong> - $${producto.precio} <br>
            <small>${producto.descripcion}</small>
            <hr>
        `;
        contenedorLista.appendChild(li);
    });
}

// 4. Función para agregar un producto aleatorio
function agregarProducto() {
    const nuevoProducto = {
        nombre: "Producto Nuevo " + (productos.length + 1),
        precio: Math.floor(Math.random() * 100) + 1,
        descripcion: "Descripción generada automáticamente."
    };

    productos.push(nuevoProducto); // Lo agregamos al arreglo
    renderizarProductos(); // Volvemos a dibujar la lista
}

// 5. Inicialización
document.addEventListener('DOMContentLoaded', renderizarProductos);
botonAgregar.addEventListener('click', agregarProducto);