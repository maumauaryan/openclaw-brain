const puppeteer = require('puppeteer');

(async () => {
  try {
    console.log('Loading MrBeast specific video...\n');

    const browser = await puppeteer.launch({
      headless: 'new',
      args: ['--no-sandbox', '--disable-gpu', '--window-size=1920,1080']
    });

    const page = await browser.newPage();

    await page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36');

    await page.goto('https://www.youtube.com/watch?v=3GNyw4uaAqU', { timeout: 40000 });
    await new Promise(resolve => setTimeout(resolve, 4000));

    const videoData = await page.evaluate(() => {
      let title, views, uploadDate, channel;

      const titleEl = document.querySelector('#title > h1 > yt-formatted-string') ||
                     document.querySelector('h1.ytd-video-primary-info-renderer');
      title = titleEl?.textContent?.trim();

      const viewsEl = document.querySelector('#count > yt-formatted-string') ||
                     document.querySelector('.view-count');
      views = viewsEl?.textContent?.trim();

      const dateEl = document.querySelector('#info > #info-contents > #date > yt-formatted-string') ||
                    document.querySelector('.date-text');
      uploadDate = dateEl?.textContent?.trim();

      const channelEl = document.querySelector('#owner-name > a') ||
                       document.querySelector('.ytd-channel-name');
      channel = channelEl?.textContent?.trim();

      return { title, views, uploadDate, channel };
    });

    console.log('Video Details:');
    console.log(`  Title:   ${videoData.title || 'Not found'}`);
    console.log(`  Views:   ${videoData.views || 'Not found'}`);
    console.log(`  Date:    ${videoData.uploadDate || 'Not found'}`);
    console.log(`  Channel: ${videoData.channel || 'Not found'}`);

    await browser.close();

    console.log('\n✅ Direct video URL extraction working!');

  } catch (error) {
    console.error('Error:', error.message);
    process.exit(1);
  }
})();
