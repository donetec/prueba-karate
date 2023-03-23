import com.intuit.karate.Runner;
import net.minidev.json.JSONArray;

import java.io.File;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

public class MascotasTest {

    public static void main(String[] args) {
        Map<String, Object> options = new HashMap<>();
        options.put("tags", "@Mascotas-find");

        File currentDirFile = new File(".");
        String path = currentDirFile.getAbsolutePath();

        Map<String, Object> result = Runner.runFeature(new File(path + "\\src\\test\\java\\features\\Mascotas.feature"), options, false);
        List<String> listadoNombres = new ArrayList<>();

        for(int i = 0; i < ((JSONArray)result.get("response")).size(); i++) {
            String name = (String) ((LinkedHashMap)((JSONArray) result.get("response")).toArray()[i]).get("name");

            if(null != name){
                listadoNombres.add(name);
            }
        }

        Map<String, Long> map = listadoNombres.stream().collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));

        System.out.println("-------- Resultado --------");
        System.out.println(map.toString());
    }

}
