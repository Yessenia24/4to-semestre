// Seleccionamos los elementos del DOM
const urlInput = document.getElementById('image-url');
const addBtn = document.getElementById('add-btn');
const deleteBtn = document.getElementById('delete-btn');
const gallery = document.getElementById('gallery');

let selectedImage = null;

// Función para agregar imagen
addBtn.addEventListener('click', () => {
    const url = urlInput.value;

    if (url === "") {
        alert("Por favor, ingresa una URL válida.");
        return;
    }

    // 1. Crear el elemento img dinámicamente
    const newImg = document.createElement('img');
    newImg.src = url;
    newImg.alt = "Imagen de la galería";

    // 2. Evento para seleccionar la imagen al hacer clic
    newImg.addEventListener('click', function() {
        // Quitar selección previa si existe
        if (selectedImage) {
            selectedImage.classList.remove('selected');
        }
        
        // Asignar nueva selección
        this.classList.add('selected');
        selectedImage = this;
    });

    // 3. Agregar a la galería y limpiar input
    gallery.appendChild(newImg);
    urlInput.value = "";
});

// Función para eliminar la imagen seleccionada
deleteBtn.addEventListener('click', () => {
    if (selectedImage) {
        gallery.removeChild(selectedImage);
        selectedImage = null; // Limpiar la referencia
    } else {
        alert("Por favor, selecciona una imagen primero.");
    }
});

// Extra: Manejar tecla "Enter" para agregar imagen (keydown)
urlInput.addEventListener('keydown', (event) => {
    if (event.key === "Enter") {
        addBtn.click();
    }
});