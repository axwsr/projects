let form_add = document.getElementById('form_add');
let btns_form = document.getElementById("btns_form");
let tbody = document.getElementById('tbody');
var token = sessionStorage.getItem('token');
let input_1 = document.getElementById("input-1");
let input_2 = document.getElementById("input-2");
let btn_cancelar = document.getElementById("btn_cancelar");
var rutaAPI = sessionStorage.getItem('ruta');

// verificar si esta logueado
if (token === null) {
    window.location.href = 'index.html';
}

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

form_add.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    let datos = new FormData(form_add);
    let costoInt = parseInt(datos.get("costo"));
    let descripcion = datos.get("descripcion");
    
    if (costoInt > 0 && descripcion.length > 0) {
        let postData = {
            "descripcion":descripcion,
            "costo":costoInt
        }
    
        form_add.reset();
        await createTarifa(postData);
    }else{
        alertError("Error, verifique los datos");
    }


    
})

const createTarifa = async (campos)  =>{

    let headers = new Headers({
        "accept": "application/json",
        "Authorization": `Bearer ${token}`,
        "Content-Type": "application/json"
    });

    const requestOptions = {
        method: 'POST',
        headers: headers,
        body:JSON.stringify(campos)
    };

    let endpoint = rutaAPI+"/tarifas/create-tarifa/";
    const response = await fetch(endpoint, requestOptions);
    if (!response.ok) {
        alertError("Error al crear la tarifa.");
        const errorData = await response.json();
        console.error("Error en la solicitud:", errorData);
        // Manejar el error según sea necesario
    } else {
        validationClearTbody(1);
        const data = await response.json();
        let tr = document.createElement('tr');
    
        let td_descripcion = document.createElement('td');
        td_descripcion.textContent = data.descripcion;

        let td_costo = document.createElement('td');
        td_costo.textContent = data.costo;

        let td_id_tarifa = document.createElement('td');
        td_id_tarifa.textContent = data.id_tarifa;
        td_id_tarifa.style.display = 'none';

        let btn_table = document.createElement('button');
        btn_table.textContent = "Editar";
        btn_table.setAttribute("class","btn btn-light");
        btn_table.addEventListener('click',() => {
            infoFila(tr);
        });
        tr.append(td_id_tarifa,td_descripcion,td_costo,btn_table);
        tbody.insertBefore(tr, tbody.firstChild);
        console.log(data);
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

    let endpoint = rutaAPI+"/tarifas/get-tarifas/";
    const response = await fetch(endpoint, requestOptions);
    if (!response.ok) {
        if (response.status == 404) {
            console.log("no hay tarifas");
        }else{ 
            alertError("Error, sistema caido");
        }        
    }else{
        const data = await response.json();
        if (data.length > 0) {
            tbody.innerHTML = "";
            data.forEach(element => {
                let tr = document.createElement('tr');
        
                let td_descripcion = document.createElement('td');
                td_descripcion.textContent = element.descripcion;
        
                let td_costo = document.createElement('td');
                td_costo.textContent = element.costo;

                let td_id_tarifa = document.createElement('td');
                td_id_tarifa.textContent = element.id_tarifa;
                td_id_tarifa.style.display = 'none';
                
                let btn_table = document.createElement('button');
                btn_table.textContent = "Editar";
                btn_table.setAttribute("class","btn btn-light");
                btn_table.addEventListener('click',() => {
                    infoFila(tr);
                });

                tr.append(td_id_tarifa,td_descripcion,td_costo,btn_table);
                tbody.append(tr);
            });
        }else{
            Toast.fire({
                icon: 'warning',
                title: "No tiene tarifas creadas."
            });
            validationClearTbody(0);
        }
    }
}

const validationClearTbody = (number) => {
    let firstTD = tbody.firstElementChild;
    if (firstTD) {
        if (firstTD.getElementsByClassName("text-center").length == number) {
            tbody.innerHTML = "";
        }
    }
}


const infoFila = (fila) => {
    // Obtener datos de la fila
    var datosFila = [];
    fila.querySelectorAll('td').forEach(function(td) {
        datosFila.push(td.textContent);
    });

    btns_form.innerHTML = "";
    btn_cancelar.innerHTML = "";
    // Imprimir la información en la consola
    input_1.value = datosFila[1];
    input_2.value = datosFila[2];

    let btn_update = document.createElement('button');
    btn_update.setAttribute("class","btn btn-light m-2");
    btn_update.setAttribute("type","button");
    btn_update.textContent = "EDITAR";
    
    
    btn_update.addEventListener('click',() => {
        updateTarifa(datosFila[0]);
    });
    
    
    let btn_eliminar = document.createElement('button');
    btn_eliminar.classList.add("btn", "btn-danger", "m-2");
    btn_eliminar.setAttribute("type", "button");
    btn_eliminar.textContent = "Eliminar"

    
    
    btn_eliminar.addEventListener('click', () =>{
        eliminar_tarifa(datosFila[0]);
    });
    
    let btn_cancel = document.createElement('button');
    btn_cancel.setAttribute("class","btn btn-light m-2");
    btn_cancel.setAttribute("type","button");
    btn_cancel.textContent = "CANCELAR";
    btn_cancel.addEventListener('click',() => {
        cancelar_update();
    });
    
    btn_cancelar.appendChild(btn_cancel);
    btns_form.append(btn_update,btn_eliminar);
}


const eliminar_tarifa = async (id_tarifa) => {
    let id_tarifa_bd = parseInt(id_tarifa);

    let dataDelete = {
        "id_tarifa":id_tarifa_bd
    }

    let headers = new Headers({
        "accept": "application/json",
        "Authorization": `Bearer ${token}`,
        "Content-Type": "application/json"
    });

    const requestOptions = {
        method: 'POST',
        headers: headers,
        body:JSON.stringify(dataDelete)
    };


    let endpoint = rutaAPI+"/tarifas/update-tarifa-status/"
    const response = await fetch(endpoint, requestOptions);
    if (!response.ok) {
        alertError("Error al eliminar la tarifa.");
    }else{
        let dataRespuesta = await response.json();
        cancelar_update();
        await getTarifas();
        console.log(dataRespuesta);
    }
}

const cancelar_update = () => {
    btns_form.innerHTML = "";
    btn_cancelar.innerHTML = "";
    input_1.value = "";
    input_2.value = "";

    let btn_add_tarifa = document.createElement('button');
    btn_add_tarifa.setAttribute('class','btn btn-light');
    btn_add_tarifa.setAttribute('type','submit');
    btn_add_tarifa.textContent = "AGREGAR TARIFA";
    btns_form.append(btn_add_tarifa);

}

const updateTarifa = async (id_tarifa) => {
    let contendInputDescription = input_1.value;
    let contendInputCosto = input_2.value;

    input_1.value = "";
    input_2.value = "";
    let ID_tarifa = parseInt(id_tarifa);
    let Costo = parseInt(contendInputCosto);
    

    let datosUpdate = {
        "id_tarifa":ID_tarifa,
        "descripcion":contendInputDescription,
        "costo":Costo
    }

    let headers = new Headers({
        "accept": "application/json",
        "Authorization": `Bearer ${token}`,
        "Content-Type": "application/json"
    });

    const requestOptions = {
        method: 'POST',
        headers: headers,
        body:JSON.stringify(datosUpdate)
    };

    let endpoint = rutaAPI+"/tarifas/update-tarifa/";
    const response = await fetch(endpoint, requestOptions);
    if (!response.ok) {
        const errorData = await response.json();
        console.error("Error en la solicitud:", errorData);
        alertError("Error al actualizar la tarifa.");
        // Manejar el error según sea necesario
    } else {
        console.log(response);
        let respuestaAPI = await response.json();
        cancelar_update();
        getTarifas();
        console.log(respuestaAPI);
    }
}


getTarifas();
