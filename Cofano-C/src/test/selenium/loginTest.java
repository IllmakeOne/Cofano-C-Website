import io.github.bonigarcia.wdm.WebDriverManager;
import org.junit.Assert;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;


public class loginTest {

    public static void main(String[] args) {

        WebDriverManager.firefoxdriver().setup();

        //Create in instance of the driver
        WebDriver driver = new FirefoxDriver();

        //Navigate to a web page
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
        WebElement pageHeaderElement = wait1.until(ExpectedConditions.presenceOfElementLocated(By.id("pageHeader")));

        //Run a test
        String message = pageHeaderElement.getText();
        String successMsg = "Dashboard";
        Assert.assertEquals(message, successMsg);

        //Conclude a test
        driver.quit();
    }

}
