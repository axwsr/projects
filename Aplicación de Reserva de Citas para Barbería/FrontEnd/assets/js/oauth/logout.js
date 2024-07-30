document.addEventListener('DOMContentLoaded', function() {
    var logoutItem = document.getElementById("logoutt");
    var token = sessionStorage.getItem('token');

    const cerrarS = async () => {
        try {
            var ruta = sessionStorage.getItem('ruta');
    
            let headers = new Headers({
                "accept": "application/json",
                "Authorization": `Bearer ${token}`,
                "Content-Type": "application/json"
            });
    
            let config = {
                headers: headers,
                method: "POST",

            }
    
            let endpoint = `${ruta}/users/logout?token=${token}`;
            const LogoutAoi = await fetch(endpoint, config);
            if (LogoutAoi.ok) {
                const result = await LogoutAoi.json();
                
                if (result.status) {
                    window.location.href = "index.html";
                }
            }
        } catch (error) {
            console.log(error);
        }
    }
    

    logoutItem.addEventListener("click", function() {
        cerrarS();
        eliminarTokenWeb();
    });

    const eliminarTokenWeb = () => {
        // Para eliminar el token de sessionStorage
        sessionStorage.removeItem('token');
    }
})
