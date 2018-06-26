import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;

public class login {

    public static void main(String[] args) {

        //Create in instance of the driver
        WebDriver driver = new FirefoxDriver();

        //Navigate to a web page
        driver.get("http://farm05.ewi.utwente.nl:7027/Cofano-C/login");

        WebElement loginButtonElement = driver.findElement(By.name("login"));
    }

}
