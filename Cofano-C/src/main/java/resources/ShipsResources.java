package resources;

import java.awt.List;
import java.util.ArrayList;
import java.util.Map;

import dao.*;
import model.*;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Path("/data/ships")
public class ShipsResources {

	
	@Path("all")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public ArrayList<Ship> getAllCatalogueItems() {
		ArrayList<Ship> items = new ArrayList<Ship>();
		for (Map.Entry<String, Ship> es : Tables.instance.getShips().entrySet())
			items.add(es.getValue());
		return (items);
	}
	
	
}
