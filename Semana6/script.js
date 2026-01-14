const form = document.getElementById('registroForm');
const inputs = document.querySelectorAll('#registroForm input');
const btnEnviar = document.getElementById('btnEnviar');

// Expresiones regulares para validación
const regexEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const regexPassword = /^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,}$/;

const validaciones = {
    nombre: (val) => val.length >= 3,
    email: (val) => regexEmail.test(val),
    password: (val) => regexPassword.test(val),
    confirmar: (val) => val === document.getElementById('password').value && val !== "",
    edad: (val) => parseInt(val) >= 18
};

// Función para validar cada campo individualmente
const validarCampo = (input) => {
    const nombreCampo = input.name;
    const valor = input.value;
    const errorSpan = document.getElementById(`error-${nombreCampo}`);
    
    let esValido = validaciones[nombreCampo](valor);

    if (esValido) {
        input.classList.add('valid');
        input.classList.remove('invalid');
        errorSpan.style.display = 'none';
    } else {
        input.classList.add('invalid');
        input.classList.remove('valid');
        errorSpan.style.display = 'block';
    }
    
    verificarFormularioCompleto();
};

// Habilitar/Deshabilitar botón de envío
const verificarFormularioCompleto = () => {
    const todosValidos = Array.from(inputs).every(input => input.classList.contains('valid'));
    btnEnviar.disabled = !todosValidos;
};

// Event Listeners para validación en tiempo real
inputs.forEach(input => {
    input.addEventListener('input', () => validarCampo(input));
    input.addEventListener('blur', () => validarCampo(input));
});

// Manejo del envío
form.addEventListener('submit', (e) => {
    e.preventDefault();
    alert('✅ Registro exitoso. Todos los datos son válidos.');
    form.reset();
    inputs.forEach(i => i.classList.remove('valid', 'invalid'));
    btnEnviar.disabled = true;
});

// Manejo del reinicio
form.addEventListener('reset', () => {
    inputs.forEach(i => i.classList.remove('valid', 'invalid'));
    const errores = document.querySelectorAll('.error-msg');
    errores.forEach(e => e.style.display = 'none');
    btnEnviar.disabled = true;
});