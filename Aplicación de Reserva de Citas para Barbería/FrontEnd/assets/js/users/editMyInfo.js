let tokenV = sessionStorage.getItem('token');
var rutaV = sessionStorage.getItem("ruta");
let btnEditar = document.getElementById("btnEditar");
let inputCorreo = document.getElementById("inputCorreo");
let inputContrasenia = document.getElementById("inputContrasenia");
let inputContraseniaActual = document.getElementById("inputContraseniaActual");
let formEditUser = document.getElementById("formEditUser");
let textoError = document.getElementById("textoError");
textoError.style = "color:red";
textoError.classList.add = "fw-bold";
let switchContrasenia = document.getElementById("switchContrasenia");
let contContrasenia = document.getElementById("contContrasenia");
let icon_eyeCurrent = document.getElementById('icon_eyeCurrent');
let icon_eyeNew = document.getElementById('icon_eyeNew');
let id_usuario = "";

// verificar si se ha logueado
if (tokenV === null) {
    window.location.href = 'index.html';
}

document.addEventListener('DOMContentLoaded', function() {
    getUserInfo();
});

switchContrasenia.addEventListener("change",() => {
    let option = switchContrasenia.checked;
    if (option) {
        contContrasenia.classList.remove("ocultar");
    }else{
        contContrasenia.classList.add('ocultar');
    }
});

icon_eyeCurrent.addEventListener("click",() => {
    ( icon_eyeCurrent.classList.contains('fa-eye-slash') ) ? icon_eyeCurrent.classList.replace('fa-eye-slash','fa-eye') : icon_eyeCurrent.classList.replace('fa-eye','fa-eye-slash');
    ( icon_eyeCurrent.classList.contains('fa-eye-slash') ) ? inputContraseniaActual.type = "password" : inputContraseniaActual.type = "text" ;
});

icon_eyeNew.addEventListener("click",() => {
    ( icon_eyeNew.classList.contains('fa-eye-slash') ) ? icon_eyeNew.classList.replace('fa-eye-slash','fa-eye') : icon_eyeNew.classList.replace('fa-eye','fa-eye-slash');
    ( icon_eyeNew.classList.contains('fa-eye-slash') ) ? inputContrasenia.type = "password" : inputContrasenia.type = "text" ;
});

const getUserInfo = async () =>{
    let headers = new Headers({
        "accept": "application/json",
        "Authorization": `Bearer ${tokenV}`,
        "Content-Type": "application/json"
    });
    
    const requestOptions = {
        method: 'POST',
        headers: headers
    };
    
    let endPoint = `${rutaV}/users/get-user-token?token=${tokenV}`;

    const getInfoUser = await fetch(endPoint, requestOptions);
    if (getInfoUser.ok) {
        const result = await getInfoUser.json();
        inputCorreo.value = result.correo;
        id_usuario = result.id_usuario;
    }else{
        textoError.textContent = "Error al obtener los datos el usuario";
    }
    
}

const updateDataUser = async (datos) =>{
    let headers = new Headers({
        "accept": "application/json",
        "Authorization": `Bearer ${tokenV}`,
        "Content-Type": "application/json"
    });
    
    const requestOptions = {
        method: 'POST',
        headers: headers,
        body:JSON.stringify(datos)
    };

    let endPoint = `${rutaV}/users/update-user`;
    const updateUser = await fetch(endPoint, requestOptions);
    const dataResult = await updateUser.json();
    if (updateUser.ok){
        window.location.href = "index.html";
        sessionStorage.removeItem('token');
        sessionStorage.setItem('email', dataResult.correo);
    }else{
        if (updateUser.status == 404){
            textoError.textContent = await dataResult.detail;
        }
    }
}

formEditUser.addEventListener("submit", (e) =>{
    e.preventDefault();
    let datosForm = new FormData(formEditUser);
    // Se evalue si el elemento contContrasenia tiene la clase ocultar y si es asi devuelve un true o un false.
    let containsOcultar = contContrasenia.classList.contains('ocultar');
    
    let inputCorreo = datosForm.get("correo");
    let inputContrasenia = (containsOcultar)?null:datosForm.get("contrasenia");
    let inputContraseniaActual = (containsOcultar)?null:datosForm.get("contraActual");
    
    if (inputCorreo.length >= 12){
        let datosPost = {
            "correo": inputCorreo,
            "id_usuario": id_usuario,
            "contraActual": inputContraseniaActual,
            "contrasenia": inputContrasenia
        }

        if (inputContrasenia !== null) {
            if (inputContrasenia.length >= 3 && inputContraseniaActual.length >=3){
                updateDataUser(datosPost);
            }else{
                textoError.textContent = "La contrasena debe tener minimo 3 caracteres";
            }
        }else{
            updateDataUser(datosPost);
        }
    }else{
        textoError.textContent = "El correo debe tener minimo 12 caracteres";
    }

});

