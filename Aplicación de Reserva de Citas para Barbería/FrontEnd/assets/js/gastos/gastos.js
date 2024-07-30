document.addEventListener('DOMContentLoaded', () => {
    var token = sessionStorage.getItem('token');
    var ruta = sessionStorage.getItem('ruta');
    let btn_gasto = document.getElementById('btn_gasto');
    let btn_update = document.getElementById('btn_update');
    let btn_delete = document.getElementById('btn_delete');
    let formGasto = document.getElementById('formGasto');
    let FormUpdate = document.getElementById('FormUpdate');
    let FormPeriod = document.getElementById('FormPeriod');
    let total_expense = document.getElementById('total_expense');
    let tbody = document.getElementById('tbody');

    let id_gasto = document.getElementById('id_gasto');
    let update_descripcion = document.getElementById('update_descripcion');
    let update_valor = document.getElementById('update_valor');
    let dataDefault = {
        "tipo": "SEMANA"
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

    let backgroundColors = [
        '#ffcccc', '#ffcc99', '#87f5e6', '#dffc86', '#c1a2f5',
        '#f54579', '#4a42bd', '#ff99ff', '#6294f0', '#3c72bd',
        '#ff9966', '#eaf28d', '#49b879', '#ff99cc', '#b048b0',
        '#ff66ff', '#ff66cc', '#ff6699', '#ff6666', '#ff6633',
        '#ff6600', '#528aeb', '#bfbabb', '#6df2ca', '#ff4d4d',
        '#81de7a', '#ff4d1a', '#ff33ff', '#ff33cc', '#ff3399'
    ];

    const generarColores = (cant) => {
        const paleta = backgroundColors.slice(0, cant);
        return paleta;
    }

    const dataDona = (array) => {
        let values = [];
        let labels = [];
        
        array.forEach(element => {
            values.push(element.cuenta);
            labels.push(element.descripcion);
        });
        
        let colores = generarColores(array.length);
        doughnut(values,labels,colores);
    }

    const doughnut = (values,labels,colores) => {
        var ctx = document.getElementById('donutChart').getContext('2d');
        var data = {
            labels: labels,
            datasets: [{
                data: values,
                backgroundColor: colores
            }]
        };
    
        var options = {
            legend: {
                display: false
            },
            cutoutPercentage: 50,
            maintainAspectRatio: false,
            responsive: true
        };
        

        new Chart(ctx, {type: 'doughnut',data: data,options: options });
    }


    btn_gasto.addEventListener('click',() => {
        let dataExpense = new FormData(formGasto);
        let descripcion = dataExpense.get('descripcion');
        let cuenta = dataExpense.get('valor');
        let fecha = dataExpense.get('fecha');
        
        if (descripcion.length <= 0 || cuenta.length <= 0 || fecha.length <= 0) {
            return alertError("Error en los datos.");
        }

        let postData = {
            'tipo_movimiento':'GASTO',
            'descripcion':descripcion,
            'cuenta':cuenta,
            'fecha':fecha
        }
        console.log(postData);
        formGasto.reset();
        createExpense(postData);
        $('#exampleModalCenter').modal('hide');
    });

    btn_delete.addEventListener('click',() => {
        $('#modalUpdate').modal('hide');
        const swalWithBootstrapButtons = Swal.mixin({
            toast:true,
            customClass: {
              confirmButton: "m-2 btn btn-success",
              cancelButton: "m-2 btn btn-danger"
            },
            buttonsStyling: false
          });
          swalWithBootstrapButtons.fire({
            title: `¿Deseas borrar el gasto?`,
            // text: "Puede revertir la decisión!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonText: "Si",
            cancelButtonText: "No",
            reverseButtons: true
          }).then((result) => {
            if (result.isConfirmed) {
              let dataDelete = {
                'id_movimientos':id_gasto.value,
                'estado_gasto':false
              }
              console.log(dataDelete);
              deleteExpense(dataDelete);
            } else if (result.dismiss === Swal.DismissReason.cancel) {
              
            }
        });
    });

    btn_update.addEventListener('click', () => {
        let updateData = new FormData(FormUpdate);
        let descripcion = updateData.get('descripcion');
        let cuenta = parseInt(updateData.get('valor'));
        let id_gasto = parseInt(updateData.get('id_gasto'));
        let postData = {
            'tipo_movimiento':'GASTO',
            'descripcion':descripcion,
            'cuenta':cuenta,
            'id_movimientos':id_gasto
        }

        console.log(postData);
        FormUpdate.reset();
        updateExpense(postData);
        $('#modalUpdate').modal('hide');
    });


    const showModalUpdate = (data) => {
        FormUpdate.reset();
        update_valor.value = data.cuenta;
        update_descripcion.value = data.descripcion;
        id_gasto.value = data.id_movimientos;
    }

    const showExpenses = (array) => {
        tbody.innerHTML = "";
        if (array.length <= 0) {
            let tr = document.createElement("tr");
            let td = document.createElement("td");
            td.setAttribute("colspan", "4");
            td.classList.add("text-center");
            td.textContent = "No hay gastos";
            tr.appendChild(td);
            tbody.appendChild(tr);
        }else{
            array.forEach(element => {
                let tr = document.createElement('tr');
        
                let tdValor = document.createElement('td');
                tdValor.textContent = element.cuenta;
        
                let tdDescripcion = document.createElement('td');
                tdDescripcion.textContent = element.descripcion;
    
                let tdEditar = document.createElement('td');
                let btnEditar = document.createElement('button');
                btnEditar.classList.add("btn","btn-light");
                btnEditar.textContent = "Editar";
                btnEditar.setAttribute('data-toggle','modal');
                btnEditar.setAttribute('data-target','#modalUpdate');
                btnEditar.addEventListener('click',() => {
                    showModalUpdate(element);
                });
    
                tdEditar.appendChild(btnEditar);
                tr.append(tdValor,tdDescripcion,tdEditar);
                tbody.append(tr);
            });
        }
    }

    const updateExpense = async (datos) => {
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
    
        let endpoint = ruta + "/movimientos/update-movimiento"
        const peticion = await fetch(endpoint, config);
        if (peticion.ok) {
            const response = await peticion.json();
            console.log(response);
            get_weekly_expense(dataDefault);
            alertSuccess('Gasto editado éxito.');
        } else {
            console.log("Error al actualizar el gasto");
        }
    }

    const deleteExpense = async (datos) => {
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
    
        let endpoint = ruta + "/movimientos/update-movimientos-status"
        const peticion = await fetch(endpoint, config);
        if (peticion.ok) {
            const response = await peticion.json();
            console.log(response);
            get_weekly_expense(dataDefault);
            alertSuccess('Gasto eliminado éxito.');
        } else {
            alertError("Error al borrar el gasto,sistema caido");
        }
    }

    const createExpense = async (datos) => {
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
    
        let endpoint = ruta + "/movimientos/create/"
        const peticion = await fetch(endpoint, config);
        if (peticion.ok) {
            const response = await peticion.json();
            console.log(response);
            get_weekly_expense(dataDefault);
            alertSuccess('Gasto registrado éxito.');
        } else {
            alertError("Error al crear el gasto, caido el sistema");
        }
    }

    const get_weekly_expense = async (datos) => {
        let headers = new Headers({
            "accept": "application/json",
            "Authorization": `Bearer ${token}`,
            "Content-Type": "application/json"
        });

        let config = {
            method:"POST",
            headers:headers,
            body: JSON.stringify(datos)
        };

        let endpoint = ruta + "/movimientos/weekly-expenses"
        const peticionBack = await fetch(endpoint,config);
        if(peticionBack.ok){
            const response = await peticionBack.json();
            console.log(response);
            showExpenses(response.details);
            dataDona(response.details);
            total_expense.textContent = `Total: ${response.total_expenses}`;
        }else{
            alertError("error al obtener los datos");
        }
    }


    const get_consulted_expenses = async (datos) => {
        let headers = new Headers({
            "accept": "application/json",
            "Authorization": `Bearer ${token}`,
            "Content-Type": "application/json"
        });

        let config = {
            method:"POST",
            headers:headers,
            body: JSON.stringify(datos)
        };

        let endpoint = ruta + "/movimientos/consulted_expenses"
        const peticionBack = await fetch(endpoint,config);
        if(peticionBack.ok){
            const response = await peticionBack.json();
            console.log(response);
            showExpenses(response.details);
            dataDona(response.details);
            total_expense.textContent = `Total: ${response.total_expenses}`;
        }else{
            alertError('Error al obtener los datos, sistema caido');
        }
    }
    
    document.getElementById('btn_today').addEventListener('click', async () => {
        let postData = {
            "tipo": "HOY"
        };
        await get_weekly_expense(postData);
    });
    
    document.getElementById('btn_week').addEventListener('click', async () => {
        let postData = {
            "tipo": "SEMANA"
        };
        await get_weekly_expense(postData);
    });
    document.getElementById('btn_month').addEventListener('click', async () => {
        let postData = {
            "tipo": "MES"
        };
        await get_weekly_expense(postData);
        
    });
    
    document.getElementById('btn_period').addEventListener('click', async () => {
        let datos_fecha = new FormData(FormPeriod);
        let fecha_inicio = datos_fecha.get('fecha_inicio');
        let fecha_fin = datos_fecha.get('fecha_fin');

        let postData = {
            "start_week": fecha_inicio,
            "end_week" : fecha_fin
        };
        await get_consulted_expenses(postData);
        FormPeriod.reset();
    });

    get_weekly_expense(dataDefault);

});