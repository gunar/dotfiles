#!/usr/bin/env node

const net = require("net");
const { spawn } = require("child_process");

const ssr = spawn("simplescreenrecorder", [
  `--settingsfile=${__dirname}/settings.conf`,
  "--start-recording",
  "--start-hidden"
]);

ssr.stdin.setEncoding("utf-8");
ssr.stderr.on("data", data => {
  const string = data.toString();
  if (string.includes("StopPage] Stopped page.")) {
    notify("Stopped. Shrinking now...");
    const shrink = spawn(`${__dirname}/shrink.sh`, [], {
      shell: true,
    });
    shrink.stderr.on("data", data => {
      require("fs").appendFileSync(
        "/tmp/screenrecorder-coordinator.log",
        `error: ${data.toString()}`
      );
      notify(data.toString());
    });
    shrink.stdout.on("data", data => {
      require("fs").appendFileSync(
        "/tmp/screenrecorder-coordinator.log",
        `info: ${data.toString()}`
      );
      notify(data.toString());
    });
  }
  if (string.includes("StartPage")) {
    notify("Started");
  }
});

// Watchdog
ssr.on("close", code => {
  notify(`Closed with code ${code}`);
});

function notify(msg) {
  const ac = spawn("awesome-client");
  ac.stdin.setEncoding("utf-8");
  ac.stdin.write(
    `require('naughty').notify({ title = 'SSR', text = '${msg}' })\n`
  );
  ac.stdin.end();
}

const server = net.createServer(client => {
  console.log("client connected");
  client.on("end", () => {
    console.log("client disconnected");
  });
  client.on("data", data => {
    console.log(`< ${data.toString()}`);
    ssr.stdin.write(data.toString());
  });
});
server.on("error", err => {
  throw err;
});

const PORT = 8124;
server.listen(PORT, () => {
  console.log(`server bound (${PORT})`);
});
