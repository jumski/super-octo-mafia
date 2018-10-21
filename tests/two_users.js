const puppeteer = require('puppeteer')
const fetch = require('node-fetch')

let is_headless = false;
global.fetch = fetch;

(async () => {

  const b1 = await puppeteer.launch({ context: 'default', headless: is_headless, args: ['--no-sandbox', '--disable-setuid-sandbox'], });
  const b2 = await puppeteer.launch({ context: 'joe', headless: is_headless, args: ['--no-sandbox', '--disable-setuid-sandbox'], });
  const p1 = await b1.newPage();
  const p2 = await b2.newPage();

  await p1.goto(`http://localhost:5000/`);
  await p1.type('#town_slug', 'Swiebodzin');
  await p1.type('#player_name', 'Dziku');
  await p1.click('#create_town');

  await p2.goto(`http://localhost:5000/towns/Swiebodzin`);
  await p1.waitForSelector('#waiting_for_players');
  await p2.type('#player_name', 'Przemo');
  await p2.waitForSelector('#join_town')
  await p2.click('#join_town');

  // await p1.waitForSelector('#start-game');
  // await p1.click('#start-game');
})();
