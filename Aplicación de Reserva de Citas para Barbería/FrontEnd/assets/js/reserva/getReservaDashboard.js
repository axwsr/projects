let token = sessionStorage.getItem('token');
// verificar si se ha logueado
if (token === null) {
    window.location.href = 'index.html';
}

let tbody = document.getElementById('tbody');
let ruta = sessionStorage.getItem("ruta");
let exampleModalCenter = document.getElementById('exampleModalCenter');
let select_tarifas = document.getElementById('select_tarifas');
let etq_id_reserva = document.getElementById('id_reserva');
let name_client = document.getElementById('name_client');
let btn_cancel_reserva = document.getElementById('btn_cancel_reserva');
let btn_finish_reserva = document.getElementById('btn_finish_reserva');
let ingreso = document.getElementById('ingreso');
let account = document.getElementById('account');
let costosTarifa = [];

const format_12_hrs = (time_24) => {
    let time = new Date("2022-01-01 "+ time_24 );
    let time_12hrs = time.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true });
    return time_12hrs;
}

function mostrar(array) {
    tbody.innerHTML = "";
    array.forEach(element => {
        let tr = document.createElement('tr');

        let tdCliente = document.createElement('td');
        tdCliente.textContent = element.cliente;

        let tdHora = document.createElement('td');
        tdHora.textContent = format_12_hrs(element.hora);

        let tdStatus = document.createElement('td');
        let btnStatus = document.createElement('button');
        if (element.estado_reserva === 0) {
            btnStatus.classList.add("btn","btn-sm","btn-warning");
            btnStatus.textContent = "Sin finalizar";
        }
        tdStatus.appendChild(btnStatus);

        let td_id_reserva = document.createElement('td');
        td_id_reserva.textContent = element.id_reserva;
        td_id_reserva.style.display = 'none';

        let tdAction = document.createElement('td');

        let btnAction = document.createElement('button');
        btnAction.classList.add("btn","btn-sm","btn-success");
        btnAction.textContent = "FINALIZAR";
        btnAction.addEventListener('click', () => {
            infoReserva(tr);
        });
        tdAction.append(btnAction);

        tr.append(tdCliente,tdHora,tdStatus,tdAction,td_id_reserva);
        tbody.append(tr);

    });
}

async function getReservas()  {
    let headers = new Headers({
        "accept": "application/json",
        "Authorization": `Bearer ${token}`,
        "Content-Type": "application/json"
    });

    let config = {
        headers:headers,
        method:"GET",
    }

    let rutaApi = ruta + "/reserves/get-reserve-pendiente";

    const peticion = await fetch(rutaApi,config);
    const response = await peticion.json();
    console.log(response);
    if (response.length > 0 ){
        mostrar(response)
    }

}

async function getMoneyAccount()  {
    let headers = new Headers({
        "accept": "application/json",
        "Authorization": `Bearer ${token}`,
        "Content-Type": "application/json"
    });

    let config = {
        headers:headers,
        method:"GET",
    }

    let rutaApi = ruta + "/movimientos/get-cuenta";

    const peticion = await fetch(rutaApi,config);
    if (peticion.ok) {
        const response = await peticion.json();
        console.log(response);
        account.textContent = response.money_account.toLocaleString('es-CO', { style: 'currency', currency: 'COP', minimumFractionDigits: 0 });
        
    }

}

const getTarifas = async ()  =>{
    let headers = new Headers({
        "Authorization": `Bearer ${token}`
    });

    const requestOptions = {
        method: 'GET',
        headers: headers,
    };

    let endpoint = ruta+"/tarifas/get-tarifas/";
    const response = await fetch(endpoint, requestOptions);
    if (!response.ok) {
        if (response.status == 404) {
            console.log("no hay tarifas");
        }else{ 
            console.error(response.text);
        }        
    }else{
        const data = await response.json();
        console.log(data);
        if (data.length > 0) {
            
            data.forEach(element => {
                let option = document.createElement('option');
                option.value = element.id_tarifa;
                option.textContent = element.descripcion +" - "+element.costo.toLocaleString('es-CO', { style: 'currency', currency: 'COP', minimumFractionDigits: 0 });
                option.classList.add("text-dark","bg-light");
                costosTarifa[element.id_tarifa] = element.costo;
                select_tarifas.append(option);
            });
        }else{
            console.log("ojito");
        }
    }
}

const finalizeReservation = async (datos) => {

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

    let rutaApi = ruta + "/reserves/update-reserve-tarifa";

    const peticion = await fetch(rutaApi,config);
    if (peticion.ok) {
        const response = await peticion.json();
        console.log(response);
    }else{
        console.log("error");
        // mostrarAlerta("alert-warning","Ocurrio un error","Vuelve a intentarlo mas tarde.");
    }
}

const addIncome = async (datos) => {

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

    let rutaApi = ruta + "/movimientos/create/";

    const peticion = await fetch(rutaApi,config);
    if (peticion.ok) {
        const response = await peticion.json();
        console.log(response);
    }else{
        console.log("error");
        // mostrarAlerta("alert-warning","Ocurrio un error","Vuelve a intentarlo mas tarde.");
    }
}
const cancelBooking = async (datos) => {

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

    let rutaApi = ruta + "/reserves/delete-reserve";

    const peticion = await fetch(rutaApi,config);
    if (peticion.ok) {
        const response = await peticion.json();
        console.log(response);
    }else{
        console.log("Error");
    }
}

const infoReserva = (tr) => {
    name_client.textContent = "";
    if (etq_id_reserva !== null) {
        etq_id_reserva.value = "";  
    }
    select_tarifas.selectedIndex = null;
    btn_finish_reserva.disabled = true;
    
    var datosFila = [];
    tr.querySelectorAll('td').forEach(function(td) {
        datosFila.push(td.textContent);
    });
    console.log(datosFila);
    name_client.textContent = datosFila[0];
    etq_id_reserva.value = datosFila[4];
    $('#exampleModalCenter').modal('show');

}


select_tarifas.addEventListener('change', () => {
    btn_finish_reserva.disabled = false;
});

btn_cancel_reserva.addEventListener('click',() => {
    let id_reserva = parseInt(etq_id_reserva.value);
    let postData = {
        "id_reserva":id_reserva,
        "estado_reserva":2
    }
    cancelBooking(postData);
    $('#exampleModalCenter').modal('hide');
    setTimeout(function() {
        window.location.reload();
    }, 1000);
});

btn_finish_reserva.addEventListener('click', () => {
    let id_reserva = parseInt(etq_id_reserva.value);
    let id_tarifa = parseInt(select_tarifas.value);
    let cuenta = parseInt(costosTarifa[id_tarifa]);
    let fechaActual = new Date().toISOString().slice(0, 10);
    let postData = {
        "id_reserva": id_reserva,
        "id_tarifa": id_tarifa
    }

    let dataIncome = {
        "tipo_movimiento": "INGRESO",
        "descripcion": "servicio motilada",
        "cuenta": cuenta,
        "fecha":fechaActual
    }
    console.log(dataIncome);
    addIncome(dataIncome);
    finalizeReservation(postData);
    $('#exampleModalCenter').modal('hide');
    setTimeout(function() {
            window.location.reload();
    }, 1000);
});
    

getReservas();
getTarifas();
getMoneyAccount();