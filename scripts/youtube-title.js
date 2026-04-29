const puppeteer = require('puppeteer');

(async () => {
  try {
    const browser = await puppeteer.launch({
      headless: 'new',
      args: ['--no-sandbox', '--disable-gpu', '--window-size=1920,1080']
    });

    const page = await browser.newPage();
    await page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36');

    await page.goto('https://www.youtube.com/watch?v=3GNyw4uaAqU', { timeout: 40000 });
    await new Promise(resolve => setTimeout(resolve, 3000));

    const title = await page.evaluate(() => {
      const selectors = [
        'h1.ytd-video-primary-info-renderer',
        '#title h1 yt-formatted-string',
        '#title yt-formatted-string',
        '.ytd-video-info-content-renderer h1'
      ];

      for (const selector of selectors) {
        const el = document.querySelector(selector);
        if (el && el.textContent.trim()) {
          return el.textContent.trim();
        }
      }

      const h1s = Array.from(document.querySelectorAll('h1'));
      for (const h1 of h1s) {
        const text = h1.textContent.trim();
        if (text && text.length > 5 && text.length < 100) {
          return text;
        }
      }

      return null;
    });

    await browser.close();

    console.log(`\nLatest MrBeast video title: ${title || 'Not found on page'}`);

  } catch (error) {
    console.error('Error:', error.message);
    process.exit(1);
  }
})();
