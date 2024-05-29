"""
Description: Query Shodan to show public websites with an HTTP title containing "hacked by" and output the results.
"""

import shodan
import vars

# Search Shodan with API key
api = shodan.Shodan(vars.apikey)

# Query
query = 'http.title:"hacked by"'

try:
    # Search Shodan with custom query to show initial results #
    initial_results = api.search(query)

    print(f"\nTotal results: {initial_results['total']}\n")

    lim = int(input("How many results would you like to show? "))

    final_results = api.search(query,limit=lim)

    # Iterate through final results and print relevant data
    for result in final_results['matches']:
        ip_str = result.get('ip_str', 'N/A')
        port = result.get('port', 'N/A')
        hostnames = ", ".join(result.get('hostnames', [])) or 'N/A'
        title = result.get('http', {}).get('title', 'N/A')
        location = result.get('location', {})
        country_name = location.get('country_name', 'N/A')
        city = location.get('city', 'N/A')

        print(f"IP: {ip_str}")
        print(f"Port: {port}")
        print(f"Hostnames: {hostnames}")
        print(f"Title: {title}")
        print(f"Location: {city}, {country_name}")
        print("----------------------------------------")

except shodan.APIError as e:
    print(f"Error: {e}")
