import io.github.bonigarcia.wdm.WebDriverManager;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class sidebarTest {
    public static void main(String[] args) {
        WebDriverManager.firefoxdriver().setup();
        WebDriver driver = new FirefoxDriver();

        //Login
        driver.get("http://localhost:8080/Cofano-C/login");

        //Find the login button
        WebElement loginButtonElement = driver.findElement(By.id("loginButton"));
        //Click the login button
        loginButtonElement.click();

        WebDriverWait wait = new WebDriverWait(driver, 10);
        By loginWidget = By.id("loginWidget");
        WebElement loginForm = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("loginWidget")));

        //Find username and password field
        WebElement usernameElement = driver.findElement(By.id("username"));
        WebElement passwordElement = driver.findElement(By.id("password"));

        //Enter username and password
        usernameElement.sendKeys(args[0]);
        passwordElement.sendKeys(args[1]);
        passwordElement.submit();

        //Anticipate web browser response, with an explicit wait
        WebDriverWait wait2 = new WebDriverWait(driver, 10);
        WebElement userElement = wait2.until(ExpectedConditions.presenceOfElementLocated(By.className("wpW1cb")));
        userElement.click();
        WebDriverWait wait1 = new WebDriverWait(driver, 10);
        WebElement titleElement = wait1.until(ExpectedConditions.presenceOfElementLocated(By.id("title")));

        //Testing the sidebar
        WebDriverWait wait3 = new WebDriverWait(driver, 10);
        WebElement sidebarDashboarElement = wait3.until(ExpectedConditions.presenceOfElementLocated(By.id()))

    }
}
