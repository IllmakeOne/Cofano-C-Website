
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;


import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import org.junit.Assert;

public class login {

    public static void main(String[] args) {

        //Create in instance of the driver
        WebDriver driver = new FirefoxDriver();

        //Navigate to a web page
        driver.get("http://farm05.ewi.utwente.nl:7027/Cofano-C/login");

        //Find the login button
        WebElement loginButtonElement = driver.findElement(By.id("loginButton"));
        //Click the login button
        loginButtonElement.click();
        WebDriverWait wait = new WebDriverWait(driver, 10);
        By loginWidget = By.id("loginWidget");
        WebElement messageElement = wait.until(ExpectedConditions.visibilityOfElementLocated(loginWidget));

        //Find username and password field
        WebElement usernameElement = driver.findElement(By.id("username"));
        WebElement passwordElement = driver.findElement(By.id("password"));

        //Enter username and password
        usernameElement.sendKeys(args[0]);
        passwordElement.sendKeys(args[1]);
        passwordElement.submit();


    }

}
