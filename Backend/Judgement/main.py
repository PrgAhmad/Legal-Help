from fastapi import FastAPI, Query
from fastapi.middleware.cors import CORSMiddleware
import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin

BASE_URL = "https://indiankanoon.org"
headers = {"User-Agent": "Mozilla/5.0"}

app = FastAPI()

# Allow Flutter app to call this API
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


def parse_judgment_list(soup):
    """Extract 10 judgments data from search result page."""
    results = []

    for block in soup.select("div.result"):
        title_tag = block.select_one(".result_title a")
        if not title_tag:
            continue
        
        title = title_tag.text.strip()
        link = urljoin(BASE_URL, title_tag["href"])

        # court
        court_tag = block.select_one(".docsource")
        court = court_tag.text.strip() if court_tag else None

        # full doc link
        doc_tag = block.select_one("a.cite_tag[href*='/doc/']")
        doc_link = urljoin(BASE_URL, doc_tag["href"]) if doc_tag else None

        results.append({
            "title": title,
            "court": court,
            "case_link": link,
            "full_document_url": doc_link
        })

    return results



@app.get("/judgments")
def get_judgments(
    fromDate: str,
    toDate: str,
    page: int = 1,
    limit: int = 10,
    court: str = Query()
):
    """
    /judgments?fromDate=01-12-2025&toDate=01-12-2025&page=1&limit=10
    """
    # Calculate IndianKanoon offset
    offset = (page - 1) * limit   # Example: page 2 -> offset 10
    search_url = (
        f"https://indiankanoon.org/search/?formInput="
        f"fromdate%3A%20{fromDate}%20todate%3A%20{toDate}%20sortby%3Amostrecent"
        f"+doctypes:{court}"
        f"&pagenum={offset}"
    )

    print("Fetching:", search_url)

    res = requests.get(search_url, headers=headers)
    soup = BeautifulSoup(res.text, "html.parser")

    data = parse_judgment_list(soup)

    # Return ONLY first 10 items of this page
    data = data[:limit]

    return {
        "page": page,
        "limit": limit,
        "count": len(data),
        "results": data
    }



@app.get("/judgment/details")
def judgment_details(url: str):
    """
    Example:
    /judgment/details?url=https://indiankanoon.org/doc/93110835/
    """

    print("Fetching judgment:", url)

    try:
        res = requests.get(url, headers=headers)
        if res.status_code != 200:
            raise HTTPException(status_code=404, detail="Judgment not found")

        soup = BeautifulSoup(res.text, "html.parser")

        # div.judgments contains full text blocks
        judgment_div = soup.select_one("div.judgments")
        if not judgment_div:
            raise HTTPException(status_code=500, detail="Unable to parse judgment")

        # Court name
        court = soup.select_one("h2.docsource_main")
        court_name = court.get_text(strip=True) if court else None

        # Title
        title = soup.select_one("h2.doc_title")
        title_text = title.get_text(strip=True) if title else None

        # Full judgment text
        full_text = judgment_div.get_text("\n", strip=True)

        return {
            "url": url,
            "court": court_name,
            "title": title_text,
            "full_text": full_text
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
