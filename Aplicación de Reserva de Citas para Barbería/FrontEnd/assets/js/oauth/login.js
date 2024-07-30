let formLogin = document.getElementById("formLogin");
let alertaDiv = document.getElementById('alertaDiv');
let icon_eye = document.getElementById("icon-eye");
let password = document.getElementById("password");
const mostrarAlerta = (type, title, message) => {
    var alerta = document.createElement('div');
    alerta.className = `alert ${type} alert-dismissible fade show text-center`;
    alerta.setAttribute('role', 'alert');
    var h5 = document.createElement('h5');  
    var strong = document.createElement('strong');
    strong.textContent = title;
    h5.appendChild(strong);
    alerta.appendChild(h5);
    var p = document.createElement('p');
    p.textContent = message;
    alerta.appendChild(p);
    var closeButton = document.createElement('button');
    closeButton.type = 'button';
    closeButton.className = 'close';
    closeButton.setAttribute('data-dismiss', 'alert');
    closeButton.setAttribute('aria-label', 'Close');
    var span = document.createElement('span');
    span.setAttribute('aria-hidden', 'true');
    span.innerHTML = '&times;';
    closeButton.appendChild(span);
    alerta.appendChild(closeButton);
    alertaDiv.append(alerta);
}


formLogin.addEventListener('submit', (e) => {
    e.preventDefault();
    let data = new FormData(formLogin);
    if (data.get("username").length <= 0 || data.get("password").length <= 0) {
        mostrarAlerta("alert-warning", "Error al enviar los datos", "Todos los campos deben ser diligenciados");
    } else {
        console.log("iniciando consumo");
        login(data);
    }
});

icon_eye.addEventListener('click', () =>{
    ( icon_eye.classList.contains('fa-eye-slash') ) ? icon_eye.classList.replace('fa-eye-slash','fa-eye') : icon_eye.classList.replace('fa-eye','fa-eye-slash');
    ( icon_eye.classList.contains('fa-eye-slash') ) ? password.type = "password" : password.type = "text" ;
});

const login = async (data) => {
    try {
        var ruta = sessionStorage.getItem('ruta');
        let endpoint = `${ruta}/users/login`;
        let config = {
            method: "POST",
            body: data
        }

        const LoginApi = await fetch(endpoint, config);
        if (LoginApi.ok) {
            const result = await LoginApi.json();
            // console.log(result);
            // Para guardar el token en sessionStorage
            let key_token = result.access_token;
            sessionStorage.setItem('token', key_token);  //El session solo va a funcionar si se encuentra en la misma ventana o pestaña (Sí, puedes acceder a los datos almacenados en sessionStorage desde diferentes archivos JavaScript siempre que estos archivos estén en la misma ventana del navegador y pertenezcan al mismo origen (protocolo, dominio y puerto))
            sessionStorage.setItem('email', result.correo);
            if (result.rol == "BARBERO") {
                window.location.href = 'dashboard.html';
            } else {
                window.location.href = 'dashboardAdmin.html';
            }

        } else if (LoginApi.status == 401) {
            mostrarAlerta("alert-warning", "Error al autenticarse", "No autorizado vefique sus datos");
        } else if (LoginApi.status == 403) {
            mostrarAlerta("alert-danger", "Error Usuario inactivo", "Actualmente su usuario esta inactivo");
        }
    } catch (error) {
        console.log(error);
    }
}







