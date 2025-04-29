object paquete {
    var estaPago=false
    var destino= laMatrix
  method estaPago() = estaPago
  method pagarPaquete() {estaPago = true}
  method puedeEntregarse(unMensajero) {return destino.dejaPasar(unMensajero) &&
  self.estaPago()}
method precioTotal() = 50 
  
}
object paquetito {
  method estaPago() = true
   method puedeEntregarse(unMensajero)=true
   method precioTotal() = 0
}
object paqueton {
  const destinos= []
  var importePagado=0
  method precioTotal()= 100 *destinos.size()
  method pagar(unImporte){importePagado=importePagado+unImporte}
   method estaPago() {return
    importePagado>=self.precioTotal()}
   method agregarDestinos(unDestino) {
    destinos.add(unDestino)
   } 
    method puedeEntregarse(unMensajero){
        return
        self.estaPago() &&
        self.puedePasarPorDestinos(unMensajero)
    }
    method puedePasarPorDestinos(unMensajero){
        return
        destinos.all({d=> d.dejaPasar(unMensajero)})
    }

}
object puenteDeBrooklyn {
    method dejaPasar(unMensajero) {
        return
    unMensajero.peso() <1000 //le pregunta al mensajero q va x parametro su peso
  }
}
object laMatrix {
    method dejaPasar(unMensajero) {
        return
   unMensajero.puedeLlamar() 
  }
}
object roberto {
    var transporte = bicicleta
  
  method peso() = 90+transporte.peso() //polimorfismo
  method puedeLlamar() = false
  method cambiarTransporte(nuevoTransporte) {
    transporte=nuevoTransporte
  }
}
object bicicleta {
   method bicicleta() = 5 
}
object camion {
  var acoplados = 1
  method cantidadAcoplados(unaCantidad) {acoplados=unaCantidad} 
  method peso() = acoplados * 500
}
object chuckNorris {
  method peso() = 80
    method puedeLlamar() = true
}
object neo {
    var tieneCredito = true
   method peso() = 0
    method puedeLlamar() = tieneCredito
    method cargarCredito() { tieneCredito = true}
    method agotarCredito() {tieneCredito = false}  
}

///SEGUNDA PARTE

object empresaMensajeros {
  const mensajeros= []  //conjuntos #{}
  const paquetesPendientes =[]
  const paquetesEnviados =[]


  method mensajeros() =mensajeros
    method contratarMensajero(unMensajero) {
    mensajeros.add(unMensajero)
    } 
    method despedirMensajero(unMensajero) = 
    mensajeros.remove(unMensajero)
method esGrande() = mensajeros.size() > 2
method puedeEntregarsePaquete()
{
    return 
paquete.puedeEntregarse(mensajeros.first())} //puede entregarse x el primero d la lista
method pesoUltimoMensajero() = mensajeros.last().peso() //el peso del ultimo mensajero
method puedeEntregarse(unPaquete){
    return
    mensajeros.any({m=>unPaquete.puedeEntregarse(m)})
}
method loQuePuedeEntregar(unPaquete){
    return
    mensajeros.filter({m=>unPaquete.puedeEntregarse(m)})
}
method tieneSobrePeso(){
return
self.pesosDeLosMensajeros() / mensajeros.size() > 500
}
method pesosDeLosMensajeros() = mensajeros.sum({m=>m.peso()})
method enviar(unPaquete) {
    return
    if(self.puedeEntregarse(unPaquete)){
        paquetesEnviados.add(unPaquete)
    }
    else{
        paquetesPendientes.add(unPaquete)
    }
} 
method facturacion()=
paquetesEnviados.sum({p=>p.precioTotal()})

method enviarPaquetes(listaDePaquetes){return
listaDePaquetes.forEach({p=> self.enviar(p)})
}
method enviarPendientesMasCaro(){
    return
    if(self.puedeEntregarse(self.paquetePendienteMasCaro())){
    self.enviar(self.paquetePendienteMasCaro())
    paquetesPendientes.remove(self.paquetePendienteMasCaro())
}
}
method paquetePendienteMasCaro(){
    return
    paquetesPendientes.max({p=>p.precioTotal()})
}
}


