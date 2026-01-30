// 1. Alerta Personalizada
document.getElementById('btnAlerta').addEventListener('click', function() {
    alert('¡Hola! Has activado la interacción de JavaScript con éxito.');
});

// 2. Validación del Formulario
const formulario = document.getElementById('formContacto');

formulario.addEventListener('submit', function(event) {
    const nombre = document.getElementById('nombre').value;
    const email = document.getElementById('email').value;
    const mensaje = document.getElementById('mensaje').value;

    // Detener el envío si hay campos vacíos
    if (nombre === "" || email === "" || mensaje === "") {
        event.preventDefault(); // Evita que la página se recargue
        alert("Por favor, completa todos los campos obligatorios.");
    } else {
        alert("¡Formulario enviado con éxito!");
    }
});