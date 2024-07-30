document.addEventListener('DOMContentLoaded', () => {
    var token = sessionStorage.getItem('token');
    var ruta = sessionStorage.getItem('ruta');
    let tbody = document.getElementById('tbody');
    let current_date = document.getElementById('fecha_actual');
    let reserve_date = document.getElementById("reserve_date");
    const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        timerProgressBar: true,
        showConfirmButton: false,
        timer: 1500,
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
    

    document.getElementById('btn_reservations_date').addEventListener('click', () => {
        
        if (reserve_date.value != '') {
            current_date.textContent = reserve_date.value;
            get_reservations_available(reserve_date.value);
            reserve_date.value = '';
        }else{
            alertError('Debe elegir una fecha');
        }
    });

    const format_12_hrs = (time_24) => {
        let time = new Date("2022-01-01 "+ time_24 );
        let time_12hrs = time.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true });
        return time_12hrs;
    }

    const fill_table = (array) => {
        tbody.innerHTML = "";
        array.forEach(element => {
            let tr = document.createElement('tr');
    
            let tdHora = document.createElement('td');
            tdHora.textContent = format_12_hrs(element[0]);

            let tdEstado = document.createElement('td');
            tdEstado.textContent = element[1];
            
            tr.append(tdHora,tdEstado);
            tbody.appendChild(tr);
        });
    }

    const get_reservations_available = async (date = null) => {
        let headers = new Headers({
            "accept": "application/json",
            "Authorization": `Bearer ${token}`,
            "Content-Type": "application/json"
        });

        let dateParam = "";
        if (date !== null) {
            dateParam = `?fecha=${date}`
        }

        let config = {
            method:"GET",
            headers:headers
        }

        let endpoint = ruta + "/reserves/get-reservations-available" + dateParam;
        const peticionBack = await fetch(endpoint,config);
        if(peticionBack.ok){
            const response = await peticionBack.json();
            fill_table(response);
        }else{
            alertError("Error caido el sistema");
        }
    }

    get_reservations_available();

});
