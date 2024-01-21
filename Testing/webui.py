# RMIT University Vietnam
# Course: COSC2767 Systems Deployment and Operations
# Semester: 2023C
# Assessment: Assignment 3
# Author: Group 3
# Created  date: 02/01/2023
# Last modified: 20/01/2023
# Acknowledgement: None

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

def check_search_form(url, geckodriver_path):
    options = webdriver.FirefoxOptions()
    options.binary_location = geckodriver_path
    driver = webdriver.Firefox(options=options, executable_path=geckodriver_path)

    try:
        driver.get(url)
        search_button = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.CLASS_NAME, "nav_searchFrom"))
        )
        search_button.click()
        search_form = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.CLASS_NAME, "searchForm"))
        )
        return True

    except Exception as e:
        print(f"An error occurred: {e}")
        return False

    finally:
        driver.quit()

def check_links_not_404(links, geckodriver_path):
    options = webdriver.FirefoxOptions()
    options.binary_location = geckodriver_path
    driver = webdriver.Firefox(options=options, executable_path=geckodriver_path)

    try:
        for link in links:
            driver.get(link)
            status_code = driver.execute_script(
                "return (function() {var xhr = new XMLHttpRequest(); "
                "xhr.open('HEAD', window.location.href, false); "
                "xhr.send(); return xhr.status;})();"
            )

            if status_code == 404:
                print(f"Error: {link} resulted in a 404 error.")
            else:
                print(f"Success: {link} is accessible.")

    except Exception as e:
        print(f"An error occurred: {e}")

    finally:
        driver.quit()

# Replace the URL with your actual URL
base_url = "http://54.174.242.128:8081"
# Replace the path with the actual path to geckodriver executable
geckodriver_path = "/path/to/geckodriver"

# Call the function to check the search form
result_search_form = check_search_form(base_url, geckodriver_path)
print(f"Search Form Test Result: {result_search_form}")

# Test the provided links
links_to_test = [
    "https://www.campusstore.rmit.edu.au/collections/clothing",
    "https://www.campusstore.rmit.edu.au/collections/accessories",
    "https://www.campusstore.rmit.edu.au/collections/stationery",
    "https://www.campusstore.rmit.edu.au/collections/course",
    "https://www.campusstore.rmit.edu.au/collections/special-collection",
    "https://www.campusstore.rmit.edu.au/collections/sale"
]

check_links_not_404(links_to_test, geckodriver_path)
