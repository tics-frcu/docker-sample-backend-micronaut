package example.micronaut;

import io.micronaut.http.HttpResponse;
import io.micronaut.http.MediaType;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;
import io.micronaut.http.annotation.Produces;
import org.slf4j.*;

@Controller("/hola")
public class HolaController {

    private static final Logger LOG = LoggerFactory.getLogger(HolaController.class);

    @Produces(MediaType.TEXT_PLAIN)
    @Get("/")
    HttpResponse<String> hola() {
        LOG.info("Recibida solicitud sin nombre...");
        return HttpResponse.ok("Hola Mundo!\n");
    }

    @Produces(MediaType.TEXT_PLAIN)
    @Get("/{nombre}")
    HttpResponse<String> hola(String nombre) {
        LOG.info("Recibida solicitud: " + nombre);
        return HttpResponse.ok("Hola, " + nombre + "!\n");
    }
}
