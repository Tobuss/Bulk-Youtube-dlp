import browser_cookie3
import os

def secure_to_str(value):
    return "TRUE" if value == 1 else "FALSE"

def export_cookies_to_netscape(output_file, target_site):
    try:
        cookies = browser_cookie3.chrome()
    except Exception as e:
        print(f"Failed to load cookies from Google Chrome: {e}")
        return

    with open(output_file, 'w') as file:
        file.write("# Netscape HTTP Cookie File\n")
        file.write("# Exported Columns: Domain, Include Subdomains, Path, Secure, Expiry, Name, Value\n")

        for cookie in cookies:
            if target_site in cookie.domain:
                include_subdomains = secure_to_str

                secure = secure_to_str(cookie.secure)

                expiry = cookie.expires if cookie.expires is not None else 0

                file.write(f"{cookie.domain}\t{'TRUE'}\t{cookie.path}\t"
                           f"{secure}\t{expiry}\t{cookie.name}\t{cookie.value}\n")

    print(f"Cookies exported from {target_site} in Google Chrome to {output_file} successfully!")

if __name__ == "__main__":
    output_file = ".\cookies.txt"
    target_site = ".youtube.com"

    export_cookies_to_netscape(output_file, target_site)
