from appium import webdriver
from appium.options.android import UiAutomator2Options
import time

APPIUM_HOST = '127.0.0.1'
APPIUM_PORT = 4723

def test_connection():
    options = UiAutomator2Options()
    options.platformName = 'Android'
    options.platformVersion = '13'
    options.deviceName = 'M2101K7BNY'
    options.appPackage = 'com.lionparcel.services.consumer'
    options.appActivity = '.view.main.MainActivity'
    options.autoGrantPermissions = True
    
    # Attempt to connect to the Appium server
    try:
        print(f"Connecting to Appium server at {APPIUM_HOST}:{APPIUM_PORT}...")
        driver = webdriver.Remote(f'http://{APPIUM_HOST}:{APPIUM_PORT}', options=options)
        time.sleep(2)  # Allow some time for the driver to initialize
        if driver:
            print("Driver initialized successfully.")
            driver.quit()  # Close the session
        else:
            print("Driver is None. Initialization failed.")
    except Exception as e:
        print("Failed to initialize Appium driver:", e)

if __name__ == "__main__":
    test_connection()
