document.addEventListener('DOMContentLoaded',() => {
    var token = sessionStorage.getItem('token');
    var ruta = sessionStorage.getItem('ruta');
    // verificar si se ha logueado
    if (token === null) {
        window.location.href = 'index.html';
    
    }

    let correo = document.getElementById('correo');
    let passw = document.getElementById('passw');
    let btn_crear = document.getElementById('btn_crear');

    const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        timerProgressBar: true,
        showConfirmButton: false,
        timer: 1200,
        didOpen: (toast) => {
            toast.onmouseenter = Swal.stopTimer;
            toast.onmouseleave = Swal.resumeTimer;
        }
    });
    
    function alertError(msg) {
        Toast.fire({
            icon: 'error',
            title: msg
        });
    };
    
    function alertSuccess(msg) {
        Toast.fire({
            icon: 'success',
            title: msg
        });
    }

    const create_new_user = async (datos) => {
        let headers = new Headers({
            "accept": "application/json",
            "Authorization": `Bearer ${token}`,
            "Content-Type": "application/json"
        });
        
        const requestOptions = {
            method: 'POST',
            headers: headers,
            body:JSON.stringify(datos)
        };
        
        let endPoint = ruta+"/users/create/";
        const peticion = await fetch(endPoint, requestOptions);
        if (peticion.ok){
            alertSuccess('Barbero creado con éxito');
            setTimeout(function() {
                window.location.href = "dashboardAdmin.html";
            }, 2000);
        }else if (peticion.status === 401) {
            Swal.fire({
                title: "No está autorizado",
                text: "El usuario no tiene permisos.",
                icon: "error"
            });
        }
    }

    btn_crear.addEventListener('click',() => {
        console.log("se dio click");
        if (correo.value != '' || passw.value != '') {
            console.log("iniciando creacion");
            let dataUser = {
                'correo':correo.value,
                'contrasenia':passw.value
            }
            create_new_user(dataUser);
        }else{
            alertError('verifique los datos!');
        }
    });


});