import browser_cookie3
import os

def secure_to_str(value):
    return "TRUE" if value else "FALSE"

def export_cookies_to_netscape(output_file, target_site):
    try:
        cookies = browser_cookie3.firefox()
    except Exception as e:
        print(f"Failed to load cookies from Firefox: {e}")
        return

    with open(output_file, 'w') as file:
        file.write("# Netscape HTTP Cookie File\n")
        file.write("# Exported Columns: Domain, Include Subdomains, Path, Secure, Expiry, Name, Value\n")

        for cookie in cookies:
            if target_site in cookie.domain:
                include_subdomains = "TRUE"  # Assuming include subdomains for Netscape format
                secure = secure_to_str(cookie.secure)
                expiry = cookie.expires if cookie.expires else 0

                file.write(f"{cookie.domain}\t{include_subdomains}\t{cookie.path}\t"
                           f"{secure}\t{expiry}\t{cookie.name}\t{cookie.value}\n")

    print(f"Cookies exported from {target_site} in Firefox to {output_file} successfully!")

if __name__ == "__main__":
    # Prepare the path for the output file in the parent folder
    script_dir = os.path.dirname(os.path.abspath(__file__))
    output_file = os.path.join(script_dir, '..', 'cookies.txt')

    target_site = ".youtube.com"

    export_cookies_to_netscape(output_file, target_site)
