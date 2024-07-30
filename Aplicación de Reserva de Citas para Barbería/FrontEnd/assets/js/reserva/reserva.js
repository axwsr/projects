var token = sessionStorage.getItem('token');
var ruta = sessionStorage.getItem('ruta');
// verificar si se ha logueado
if (token === null) {
    window.location.href = 'index.html';
}

let form_reserva = document.getElementById('form_reserva');
form_reserva.addEventListener('submit', async (e) => {
    e.preventDefault();
    let camposForm = new FormData(form_reserva);
    let cliente = camposForm.get('cliente');
    let fecha = camposForm.get('fecha');
    let hora = camposForm.get('hora');

    // Convertir la fecha a formato ISO 8601
    let fechaISO = new Date(fecha).toISOString().split('T')[0];

    // Convertir la hora a formato ISO 8601
    let horaISO = `${hora}:00`;

    let postData = {
        "cliente": cliente,
        "fecha": fechaISO,
        "hora": horaISO
    };
    form_reserva.reset();
    await crearReserva(postData);
});

const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    timerProgressBar: true,
    showConfirmButton: false,
    timer: 2500,
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

const crearReserva = async (datos) => {

    let headers = new Headers({
        "accept": "application/json",
        "Authorization": `Bearer ${token}`,
        "Content-Type": "application/json"
    });

    let config = {
        headers:headers,
        method:"POST",
        body: JSON.stringify(datos)  
    }

    let rutaApi = ruta + "/reserves/create-reserve";

    const peticion = await fetch(rutaApi,config);
    if (peticion.ok) {
        // const response = await peticion.json();
        // console.log(response);
        alertSuccess('Reserva creada con éxito.');
    }else if(peticion.status === 409){
        alertError('Ya existe una reserva con esa hora y fecha.');
    }else{
        alertError('Error, intentalo más tarde.');
    }
}

