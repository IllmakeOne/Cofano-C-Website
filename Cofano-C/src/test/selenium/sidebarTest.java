import io.github.bonigarcia.wdm.WebDriverManager;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.edge.EdgeDriver;
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
        WebElement loginForm = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("loginWidget")));

        //Find username and password field
        WebElement usernameElement = driver.findElement(By.id("username"));
        WebElement passwordElement = driver.findElement(By.id("password"));

        //Enter username and password
        usernameElement.sendKeys(args[0]);
        passwordElement.sendKeys(args[1]);
        passwordElement.submit();

        //Anticipate web browser response, with an explicit wait
        WebElement userElement = wait.until(ExpectedConditions.presenceOfElementLocated(By.className("wpW1cb")));
        userElement.click();
        WebElement element;

        //Testing the sidebar

        //Testing the dashboard button
        element = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("dashboard")));
        element.click();
        String URL = driver.getCurrentUrl();
        Assert.assertEquals(URL, "http://localhost:8080/Cofano-C/");

        //Testing the recently added button
        element = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("recent_data")));
        element.click();
        URL = driver.getCurrentUrl();
        Assert.assertEquals(URL, "http://localhost:8080/Cofano-C/history");

        //Testing the users button
        element = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("users")));
        element.click();
        String shipsURL = driver.getCurrentUrl();
        Assert.assertEquals(shipsURL, "http://localhost:8080/Cofano-C/users");

        //Testing the applications button
        element = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("applications")));
        element.click();
        URL = driver.getCurrentUrl();
        Assert.assertEquals(URL, "http://localhost:8080/Cofano-C/applications");

        //Testing the ships button
        element = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("ships")));
        element.click();
        URL = driver.getCurrentUrl();
        Assert.assertEquals(URL, "http://localhost:8080/Cofano-C/ships");

        //Testing the container types button
        element = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("container_types")));
        element.click();
        URL = driver.getCurrentUrl();
        Assert.assertEquals(URL, "http://localhost:8080/Cofano-C/containers");

        //Testing the terminals button
        element = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("terminals")));
        element.click();
        URL = driver.getCurrentUrl();
        Assert.assertEquals(URL, "http://localhost:8080/Cofano-C/terminals");

        //Testing the UNDGs button
        element = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("UNDGs")));
        element.click();
        URL = driver.getCurrentUrl();
        Assert.assertEquals(URL, "http://localhost:8080/Cofano-C/undgs");

        //Testing the settings button
        element = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("settings")));
        element.click();
        URL = driver.getCurrentUrl();
        Assert.assertEquals(URL, "http://localhost:8080/Cofano-C/settings");

        //Testing the ports button
        element = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("ports")));
        element.click();
        URL = driver.getCurrentUrl();
        Assert.assertEquals(URL, "http://localhost:8080/Cofano-C/ports");

        //Stopping the driver
        driver.quit();

    }
}
