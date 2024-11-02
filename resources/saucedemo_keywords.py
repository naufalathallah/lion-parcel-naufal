from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

driver = webdriver.Chrome()
BASE_URL = "https://www.saucedemo.com/"
browser = "Chrome"

def open_browser_and_navigate():
    driver.get(BASE_URL)
    driver.maximize_window()

def login(username, password):
    driver.find_element(By.ID, "user-name").send_keys(username)
    driver.find_element(By.ID, "password").send_keys(password)
    driver.find_element(By.ID, "login-button").click()

def verify_products_page():
    WebDriverWait(driver, 10).until(
        EC.visibility_of_element_located((By.CSS_SELECTOR, "[data-test='title']"))
    )
    title_text = driver.find_element(By.CSS_SELECTOR, "[data-test='title']").text
    assert title_text == "Products", f"Expected title to be 'Products' but got '{title_text}'"

def add_product_to_cart(product_name):
    add_to_cart_selector = f"[data-test='add-to-cart-{product_name}']"
    driver.find_element(By.CSS_SELECTOR, add_to_cart_selector).click()

def proceed_to_checkout():
    driver.find_element(By.CSS_SELECTOR, "[data-test='shopping-cart-link']").click()
    driver.find_element(By.CSS_SELECTOR, "[data-test='checkout']").click()

def fill_information(first_name, last_name, postal_code):
    driver.find_element(By.CSS_SELECTOR, "[data-test='firstName']").send_keys(first_name)
    driver.find_element(By.CSS_SELECTOR, "[data-test='lastName']").send_keys(last_name)
    driver.find_element(By.CSS_SELECTOR, "[data-test='postalCode']").send_keys(postal_code)

def continue_checkout():
    driver.find_element(By.CSS_SELECTOR, "[data-test='continue']").click()

def finish_checkout():
    driver.find_element(By.CSS_SELECTOR, "[data-test='finish']").click()

def verify_order_success():
    WebDriverWait(driver, 10).until(
        EC.visibility_of_element_located((By.CSS_SELECTOR, "[data-test='complete-header']"))
    )
    header_text = driver.find_element(By.CSS_SELECTOR, "[data-test='complete-header']").text
    assert header_text == "Thank you for your order!", f"Expected header to be 'Thank you for your order!' but got '{header_text}'"
    
    complete_text = driver.find_element(By.CSS_SELECTOR, "[data-test='complete-text']").text
    expected_text = "Your order has been dispatched, and will arrive just as fast as the pony can get there!"
    assert complete_text == expected_text, f"Expected complete text to be '{expected_text}' but got '{complete_text}'"

def log_out():
    driver.find_element(By.CSS_SELECTOR, "[data-test='back-to-products']").click()
    driver.find_element(By.CLASS_NAME, "bm-burger-button").click()
    WebDriverWait(driver, 5).until(
        EC.visibility_of_element_located((By.CSS_SELECTOR, "[data-test='logout-sidebar-link']"))
    )
    driver.find_element(By.CSS_SELECTOR, "[data-test='logout-sidebar-link']").click()
    driver.quit()
