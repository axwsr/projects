let table_users = document.getElementById("table_users");
var token = sessionStorage.getItem('token');
let rutaApi = sessionStorage.getItem("ruta");

// verificar si se ha logueado
if (token === null) {
    window.location.href = 'index.html';
}
window.onload = function(){
    getUsers();
}


const getUsers = async () => {
    let headers = new Headers({
        "accept": "application/json",
        "Authorization": `Bearer ${token}`,
        "Content-Type": "application/json"
    });
    
    const requestOptions = {
        method: 'GET',
        headers: headers
    };
    
    let endPoint = rutaApi+"/users/get-all-users";
    const getAllUsersApi = await fetch(endPoint, requestOptions);
    if (getAllUsersApi.ok){
        const dataUsers = await getAllUsersApi.json();
        if (dataUsers.length > 0){
            crearFila(dataUsers);
        }
    }else if (getAllUsersApi.status === 401) {
        Swal.fire({
            title: "No está autorizado",
            text: "El usuario no tiene permisos.",
            icon: "error"
        });
    }
}

const crearFila = (data) =>{
    table_users.innerHTML = "";
    
    data.forEach(respuesta => {
        let tRow = document.createElement("tr");

        let tDescriptionCorreo = document.createElement("td");
        tDescriptionCorreo.textContent = respuesta.correo;

        let tDescriptionRol = document.createElement("td");
        tDescriptionRol.textContent = respuesta.rol;

        // let iconEdit = document.createElement("i");
        // iconEdit.classList.add("bi", "bi-pencil-square");
        
        let tDescriptionStatus = document.createElement("td");
        tDescriptionStatus.textContent = respuesta.estado_usuario ? "Activo" : "Inactivo";
        
        let tDescriptionEliminar = document.createElement("td");
        
        
        let buttonEliminar = document.createElement("button");
        respuesta.estado_usuario ? buttonEliminar.classList.add("btn", "btn-light","text-center", "w-50" ):  buttonEliminar.classList.add("btn", "btn-dark", "text-center", "w-50");
        respuesta.estado_usuario ? buttonEliminar.textContent = "Desactivar":  buttonEliminar.textContent = "Activar"

        buttonEliminar.addEventListener("click",  () => {
            const swalWithBootstrapButtons = Swal.mixin({
                customClass: {
                  confirmButton: "btn btn-success",
                  cancelButton: "btn btn-danger"
                },
                buttonsStyling: false
              });
              swalWithBootstrapButtons.fire({
                title: `¿Está seguro de modificar el estado de ${respuesta.correo}?`,
                text: "Puede revertir la decisión!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Confirmar",
                cancelButtonText: "Cancelar",
                reverseButtons: true
              }).then((result) => {
                if (result.isConfirmed) {
                  actualizarStatus(respuesta.id_usuario ,respuesta.estado_usuario);
                } else if (
                  /* Read more about handling dismissals below */
                  result.dismiss === Swal.DismissReason.cancel
                ) {
                  swalWithBootstrapButtons.fire({
                    title: "Cancelado",
                    text: "Todo vuelve a la normalidad :)",
                    icon: "error"
                  });
                }
            });

            
        });

        tDescriptionEliminar.appendChild(buttonEliminar);



        tRow.append(tDescriptionCorreo, tDescriptionRol, tDescriptionStatus, tDescriptionEliminar);

        table_users.appendChild(tRow);

    });
}

const actualizarStatus = async (id_usuario, status_actual) => {
    let statusUpdate = status_actual ? false : true;

    let dataUpdateStatus = {
        "user_id": id_usuario,
        "estado_usuario": statusUpdate
    }

    let headers = new Headers({
        "accept": "application/json",
        "Authorization": `Bearer ${token}`,
        "Content-Type": "application/json"
    });

    let config = {
        method:"POST",
        headers:headers, 
        body:JSON.stringify(dataUpdateStatus)
    };

    let endpoint = rutaApi+"/users/update-user-status"
    const resUpdStatus = await fetch(endpoint, config);
    if (resUpdStatus.ok){
        getUsers();
    }else{
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Parece que algo salió mal!",
        });
        console.log("Error al actualizar el status");
    }
}

