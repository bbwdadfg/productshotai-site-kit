"""Public URL helpers for ProductShot AI."""

BASE = "https://productshotai.app"
BRAND = "ProductShot AI"
DESCRIPTION = "AI product photography generator for ecommerce sellers."

def _page(path: str = "/") -> str:
    value = path or "/"
    if not value.startswith("/"):
        value = f"/{value}"
    clean = "/" if value == "/" else value.rstrip("/") + "/"
    return f"{BASE}{clean}"

def localized_url(locale: str, path: str = "/") -> str:
    if locale == "en":
        return _page(path)
    if locale in {"zh", "zh-CN"}:
        value = path or "/"
        if not value.startswith("/"):
            value = f"/{value}"
        return _page("/zh" + ("/" if value == "/" else value))
    raise ValueError(f"unsupported locale: {locale}")

def metadata() -> dict:
    return {
        "name": BRAND,
        "homepage": BASE,
        "description": DESCRIPTION,
        "canonicalPages": {
            "home": home_url(),
            "workbench": workbench_url(),
            "pricing": pricing_url(),
            "blog": blog_url(),
            "about": about_url(),
            "contact": contact_url(),
            "privacy": privacy_url(),
            "terms": terms_url(),
            "refundPolicy": refund_policy_url(),
            "zhHome": zh_home_url(),
        },
        "tags": ["productshot", "ai-product-photography", "ecommerce-product-photos", "url-helpers"],
    }

def home_url() -> str: return _page("/")
def workbench_url() -> str: return f"{BASE}/#workbench"
def pricing_url() -> str: return f"{BASE}/#pricing"
def blog_url() -> str: return _page("/blog")
def about_url() -> str: return _page("/about")
def contact_url() -> str: return _page("/contact")
def privacy_url() -> str: return _page("/privacy")
def terms_url() -> str: return _page("/terms")
def refund_policy_url() -> str: return _page("/refund-policy")
def zh_home_url() -> str: return localized_url("zh", "/")
