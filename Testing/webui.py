from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

def check_search_form(url, geckodriver_path):
    # Set up the Firefox options with the path to geckodriver
    options = webdriver.FirefoxOptions()
    options.binary_location = geckodriver_path

    # Initialize the WebDriver
    driver = webdriver.Firefox(options=options, executable_path=geckodriver_path)

    try:
        # Open the specified URL
        driver.get(url)

        # Wait for the "nav_searchFrom" button to be clickable
        search_button = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.CLASS_NAME, "nav_searchFrom"))
        )

        # Click the "nav_searchFrom" button
        search_button.click()
 
        # Check if the search bar form shows up
        search_form = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.CLASS_NAME, "searchForm"))
        )

        # If the search form is found, return True
        return True

    except Exception as e:
        print(f"An error occurred: {e}")
        return False

    finally:
        # Close the WebDriver
        driver.quit()

# Replace the URL with your actual URL
url = "http://54.82.43.230:8081/"
# Replace the path with the actual path to geckodriver executable
geckodriver_path = "/path/to/geckodriver"

# Call the function and print the result
result = check_search_form(url, geckodriver_path)
print(result)
