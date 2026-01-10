import requests
import os
import json
from markdownify import markdownify as md

USERNAME = "mkpoli"
BASE_URL = "https://zenn.dev/api/articles"
OUTPUT_DIR = os.path.join(os.path.dirname(__file__), "refs")

def fetch_articles():
    articles = []
    next_page = 1
    
    while next_page:
        url = f"{BASE_URL}?username={USERNAME}&page={next_page}"
        print(f"Fetching list: {url}")
        response = requests.get(url)
        if response.status_code != 200:
            print(f"Error fetching list: {response.status_code}")
            break
            
        data = response.json()
        articles.extend(data.get("articles", []))
        next_page = data.get("next_page")

    return articles

def fetch_article_detail(slug):
    url = f"{BASE_URL}/{slug}"
    print(f"Fetching detail: {url}")
    response = requests.get(url)
    if response.status_code != 200:
        print(f"Error fetching detail for {slug}: {response.status_code}")
        return None
    return response.json().get("article")

def sanitize_filename(title):
    keepcharacters = (' ','.','_','-')
    return "".join(c for c in title if c.isalnum() or c in keepcharacters).rstrip()

def save_article(article):
    if not article:
        return

    title = article.get("title", "Untitled")
    slug = article.get("slug")
    body_html = article.get("body_html", "")
    
    markdown_content = f"# {title}\n\n" + md(body_html, heading_style="ATX")
    
    filename = sanitize_filename(title) + ".md"
    filepath = os.path.join(OUTPUT_DIR, filename)
    
    print(f"Saving to {filepath}")
    with open(filepath, "w", encoding="utf-8") as f:
        f.write(markdown_content)

def main():
    if not os.path.exists(OUTPUT_DIR):
        os.makedirs(OUTPUT_DIR)
        
    articles = fetch_articles()
    print(f"Found {len(articles)} articles.")
    
    for item in articles:
        slug = item.get("slug")
        detail = fetch_article_detail(slug)
        save_article(detail)

if __name__ == "__main__":
    main()
