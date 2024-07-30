

document.addEventListener('DOMContentLoaded', function() {
    var token = sessionStorage.getItem('token');
    var ruta = sessionStorage.getItem('ruta');
    // verificar si se ha logueado
    if (token === null) {
        window.location.href = 'index.html';
    }
    let tbody = document.getElementById('tbody');
    let formSearch = document.getElementById('formSearch');
    let cliente = document.getElementById('cliente');
    let fecha = document.getElementById('fecha');
    let hora = document.getElementById('hora');
    let total_reservas = document.getElementById('total_reservas');
    let id_reserva = document.getElementById('id_reserva');
    let btn_edit_reserva = document.getElementById('btn_edit_reserva');
    let chageTime = false;
    let searchExist = false;
    let fecha_inicio_element = document.getElementById('fecha_inicio');

    let fechaActual = new Date().toISOString().slice(0, 10); // Obtiene la fecha en formato YYYY-MM-DD
    fecha_inicio_element.setAttribute('max', fechaActual);
    
    let fecha_inicio = "";
    let fecha_fin = "";
    
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
    
    const format_12_hrs = (time_24) => {
        let time = new Date("2022-01-01 "+ time_24 );
        let time_12hrs = time.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true });
        return time_12hrs;
    }

    async function getReservas(fecha_inicio = null, fecha_fin = null) {
        let headers = new Headers({
            "accept": "application/json",
            "Authorization": `Bearer ${token}`,
            "Content-Type": "application/json"
        });
    
        let fechaParam = "";
        if (fecha_inicio !== null && fecha_fin !== null) {
            fechaParam = `?fecha_inicio=${fecha_inicio}&fecha_fin=${fecha_fin}`;
        }
    
        let config = {
            headers: headers,
            method: "GET",
        }
    
        let rutaApi = ruta + "/reserves/get-reserve-all" + fechaParam;
        
        const peticion = await fetch(rutaApi, config);
        if (peticion.ok) {
            const response = await peticion.json();
            // console.log(response,'consulta reservas');
            tbody.innerHTML = "";
            total_reservas.textContent = `Total Reservas: ${response.length}`;
            if (response.length > 0) {
                mostrar(response)
            }else{
                let div = document.createElement("div");
                div.classList.add("col-12","text-center","mt-5");
                let h4 = document.createElement("h4");
                h4.textContent = "No hay reservas";
                div.appendChild(h4);
                tbody.append(div);
            }
        }else{
            alertError("Error caido el sistema.");
        }
        
    }

    function createCard(object) {
        // Crear elementos
        const divCard = document.createElement('div');
        const divCardContent = document.createElement('div');
        const divRow = document.createElement('div');
        const divCol = document.createElement('div');
        const divCardBody = document.createElement('div');
        const divRow1 = document.createElement('div');
        const divCol1 = document.createElement('div');
        const h6Cliente = document.createElement('h6');
        const h5Cliente = document.createElement('h5');
        const divCol2 = document.createElement('div');
        const h6Hora = document.createElement('h6');
        const h5Hora = document.createElement('h5');
        const divRow2 = document.createElement('div');
        const divCol3 = document.createElement('div');
        const h6Estado = document.createElement('h6');
        const btnStatus = document.createElement('button');
        const divCol4 = document.createElement('div');
        const h6Editar = document.createElement('h6');
        const btnEditar = document.createElement('button');
        const iEditar = document.createElement('i');
      
        // Establecer atributos y clases
        divCard.className = 'card mt-3';
        divCard.style.borderRadius = '2em';
        divCardContent.className = 'card-content';
        divRow.className = 'row row-group m-0';
        divCol.className = 'col-12 col-lg-6 col-xl-3 border-light';
        divCardBody.className = 'card-body';
        divRow1.className = 'row text-center mb-1';
        divCol1.className = 'col-8';
        h6Cliente.textContent = 'Cliente';
        h5Cliente.textContent = object.cliente;
        divCol2.className = 'col-4';
        h6Hora.textContent = 'Hora';
        h5Hora.textContent = format_12_hrs(object.hora);
        divRow2.className = 'row text-center mt-2';
        divCol3.className = 'col-8';
        h6Estado.textContent = 'Estado';

        if (object.estado_reserva === 1) {
            btnStatus.classList.add("btn", "btn-sm", "btn-success");
            btnStatus.textContent = "Finalizado";
        }else if(object.estado_reserva === 2){
            btnStatus.classList.add("btn", "btn-sm", "btn-danger");
            btnStatus.textContent = "Cancelado";
        }else if(object.estado_reserva === 0){
            btnStatus.classList.add("btn",'btn-sm','btn-warning')
            btnStatus.textContent = "Sin finalizar";
        }

        divCol4.className = 'col-4';
        h6Editar.textContent = 'Editar';
        btnEditar.className = 'btn btn-light';
        btnEditar.disabled = (object.estado_reserva !== 0)?true:false;
        btnEditar.addEventListener('click',() => {
            infoReserva(object);
        });
        iEditar.className = 'fa-regular fa-pen-to-square';
      
        // Construir la estructura
        divCol1.append(h6Cliente, h5Cliente);
        divCol2.append(h6Hora, h5Hora);
        divRow1.append(divCol1, divCol2);
        divCol3.append(h6Estado, btnStatus);
        btnEditar.append(iEditar);
        divCol4.append(h6Editar, btnEditar);
        divRow2.append(divCol3, divCol4);
        divCardBody.append(divRow1, divRow2);
        divCol.appendChild(divCardBody);
        divRow.appendChild(divCol);
        divCardContent.appendChild(divRow);
        divCard.appendChild(divCardContent);
      
        return divCard;
      }
      
    
    function mostrar(array) {
        array.forEach(element => {
            tbody.append(createCard(element));
        });
    }
    
    const cleanModal = () => {
        cliente.value = "";
        fecha.value = "";
        hora.value = "";
        id_reserva.value = "";
        chageTime = false;
    }
    
    const infoReserva = (element) => {
        // console.log(element);
        cleanModal();
        if (element.estado_reserva === 0) {
            cliente.value = element.cliente;
            fecha.value = element.fecha;
            hora.value = element.hora;
            id_reserva.value = element.id_reserva;
            $('#exampleModalCenter').modal('show');
        }
    }
    
    
    formSearch.addEventListener('submit', (e) => {
        e.preventDefault();
        let dataSearch = new FormData(formSearch);
        fecha_inicio = dataSearch.get('fecha_inicio');
        fecha_fin = dataSearch.get('fecha_fin');
        if (fecha_inicio === "" || fecha_fin === "") {
            alertError("Error, verifique los datos.");
        }else{
            searchExist = true;
            getMoneyAccount(fecha_inicio,fecha_fin);
            getReservas(fecha_inicio,fecha_fin);
        }
    });
    
    hora.addEventListener('change',() => {
        chageTime = true;
    });
    
    btn_edit_reserva.addEventListener('click', async () => {
        // let fechaISO = new Date(fecha).toISOString().split('T')[0];
        let horaISO;
        if (chageTime) {
            horaISO = `${hora.value}:00`;
        }
        let postData = {
            "id_reserva":id_reserva.value,
            "cliente":cliente.value,
            "fecha":fecha.value,
            "hora":(chageTime)?horaISO:hora.value
        }
        // console.log(postData);
        await reserveUpdate(postData);
        $('#exampleModalCenter').modal('hide');
    });
    
    async function getMoneyAccount(fecha_inicio = null, fecha_fin = null) {
        let headers = new Headers({
            "accept": "application/json",
            "Authorization": `Bearer ${token}`,
            "Content-Type": "application/json"
        });
    
        let fechaParam = "";
        if (fecha_inicio !== null && fecha_fin !== null) {
            fechaParam = `?fecha_inicio=${fecha_inicio}&fecha_fin=${fecha_fin}`;
        }
    
        let config = {
            headers: headers,
            method: "GET",
        }
    
        let rutaApi = ruta + "/movimientos/get-cuenta" + fechaParam;
    
        const peticion = await fetch(rutaApi, config);
        if (peticion.ok) {
            const response = await peticion.json();
            // console.log(response);
            account.textContent = response.money_account.toLocaleString('es-CO', { style: 'currency', currency: 'COP', minimumFractionDigits: 0 });
        }else{
            alertError("Error caido el sistema.");
        }
    
    }
    
    const reserveUpdate = async (datos) => {
        let headers = new Headers({
            "accept": "application/json",
            "Authorization": `Bearer ${token}`,
            "Content-Type": "application/json"
        });
    
        let config = {
            method: "POST",
            headers: headers,
            body: JSON.stringify(datos)
        };
    
        let endpoint = ruta + "/reserves/update-reserve"
        const resUpdate = await fetch(endpoint, config);
        if (resUpdate.ok) {
            const response = await resUpdate.json();
            // console.log(response);
            alertSuccess('Reserva editada con éxito.');
            (searchExist)? getReservas(fecha_inicio,fecha_fin) : getReservas();
        } else if(resUpdate.status === 409) {
            alertError("Ya existe una reserva a esa hora.");
        }else{
            alertError("Error al actualizar la reserva");
        }
    }
    
    getReservas();
    getMoneyAccount();

});