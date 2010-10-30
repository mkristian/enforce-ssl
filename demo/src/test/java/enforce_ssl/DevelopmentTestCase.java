package enforce_ssl;

import junit.framework.TestCase;

import com.thoughtworks.selenium.DefaultSelenium;
import com.thoughtworks.selenium.SeleniumException;

public class DevelopmentTestCase
    extends TestCase
{
    protected DefaultSelenium createSeleniumClient(String url) throws Exception {
        return new DefaultSelenium("localhost", 4444, "*firefox", url);
    }
    
    public void testRedirectToSsl() throws Exception {
        DefaultSelenium selenium = createSeleniumClient("http://localhost:8080");
        selenium.start();

	selenium.open("/users");
	selenium.click("link=New User");
	    selenium.waitForPageToLoad("10000");
	assertEquals("https://localhost:8443/users/new", selenium.getLocation());

        selenium.stop();
    } 

    public void testStayOnSsl() throws Exception {
        DefaultSelenium selenium = createSeleniumClient("https://localhost:8443");
        selenium.start();

	selenium.open("/users");
	selenium.click("link=New User");
	selenium.waitForPageToLoad("10000");
	assertEquals("https://localhost:8443/users/new", selenium.getLocation());

        selenium.stop();
    }
}