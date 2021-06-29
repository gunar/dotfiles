#!/usr/bin/env node

const net = require("net");
const { spawn } = require("child_process");

let ssr = spawnSimpleScreenRecorder();
let xautolock = spawnXautolock();
let shuttingDown = false;
let lastStop = 0;

function spawnSimpleScreenRecorder() {
  const child = spawn("simplescreenrecorder", [
    `--settingsfile=${__dirname}/settings.conf`,
    "--start-recording",
    "--start-hidden",
  ]);

  child.stdin.setEncoding("utf-8");
  child.stderr.on("data", (data) => {
    const string = data.toString();
    if (string.includes("StopPage] Stopped page.")) {
      notify("SSR: New StopPage event")
      lastStop = Date.now();
      if (shuttingDown) {
        return;
      }

      notify("Stopped. Shrinking now...");
      const shrink = spawn(`${__dirname}/shrink.sh`, [], {
        shell: true,
      });
      shrink.stderr.on("data", (data) => {
        require("fs").appendFileSync(
          "/tmp/screenrecorder-shrinking.log",
          `error: ${data.toString()}`
        );
      });
      shrink.stdout.on("data", (data) => {
        require("fs").appendFileSync(
          "/tmp/screenrecorder-shrinking.log",
          `info: ${data.toString()}`
        );
      });
    }
    if (string.includes("StartPage")) {
      notify("SSR: Started recording");
    }
  });

  // Watchdog
  child.on("close", (code) => {
    if (shuttingDown) {
      notify("SSR: Closed with no restart");
      return;
    }
    notify(`SSR: Closed but restarting (${code || 0})`);
    // Restart process
    ssr = spawnSimpleScreenRecorder();
  });

  return child;
}

function spawnXautolock() {
  notify("xautolock: spawning");
  const child = spawn(
    "xautolock",
    "-corners +-+- -cornerdelay 2 -time 5 -locker ~/dotfiles/manjaro/lock.sh -detectsleep".split(
      " "
    )
  );

  // Watchdog
  child.on("close", (code) => {
    if (shuttingDown) {
      notify("xautolock: Closed with no restart");
      return;
    }
    notify(`xautolock: Closed but restarting (${code || 0})`);
    // Restart process
    xautolock = spawnXautolock();
  });

  return child;
}
function restartXautolock() {
  // Get's automatically restarted by the child.on("close") event handler
  xautolock.kill();
}

const server = net.createServer((client) => {
  notify("client connected");
  client.on("end", () => {
    notify("client disconnected");
  });
  client.on("data", (data) => {
    notify(`< ${data.toString()}`);
    ssr.stdin.write(data.toString());
  });
});
server.on("error", (err) => {
  throw err;
});

const PORT = 8124;
server.listen(PORT, () => {
  notify(`server bound (${PORT})`);
});

function notify(msg, ...args) {
  const ac = spawn("awesome-client");
  ac.stdin.setEncoding("utf-8");
  ac.stdin.write(
    `require('naughty').notify({ title = 'SSR', text = '${msg}' })\n`
  );
  ac.stdin.end();
  console.log(msg, ...args);
}

// screen updating
(async () => {
  let numberOfScreens;
  while (true) {
    const _ = await getNumberOfScreens();
    if (numberOfScreens === undefined) {
      notify("Init", { screens: _ });
    } else if (numberOfScreens === 1 && _ === 2) {
      notify("Adding screen");
      await run("xrandr", "--output HDMI1 --auto".split(" "));
      await run(
        "xrandr",
        "--output HDMI1 --left-of eDP1 --rotate left".split(" ")
      );
      await run("awesome-client", [], "awesome.restart()")
        // awesome-client always fails when doing a restart
        .catch(() => undefined);
      await restartSimpleScreenRecoder();
      restartXautolock();
    } else if (numberOfScreens === 2 && _ === 1) {
      notify("Removing screen");
      await run("xrandr", "--output HDMI1 --auto".split(" "));
      await run("awesome-client", [], "awesome.restart()")
        // awesome-client always fails when doing a restart
        .catch(() => undefined);
      await restartSimpleScreenRecoder();
      restartXautolock();
    } else {
      // Noop
    }
    numberOfScreens = _;
    await new Promise((res) => setTimeout(res, 1000));

    async function restartSimpleScreenRecoder() {
      notify("SSR: Restarting");
      await ssrStopRecording();
      // XXX: SSR is restarted automatically upon kill
      ssr.kill();
    }
  }
})();

async function ssrStopRecording() {
  notify("SRR: Stopping (record-save)");
  let _ = Number(lastStop);
  ssr.stdin.write("record-save\n");
  while (lastStop <= _) {
    // Wait for recording to stop
    await new Promise((res) => setTimeout(res, 100));
    if (ssr.signalCode) {
      notify("SSR: Got killed by some other process (ungraceful shutdown)")
      break;
    }
  }
  notify("SRR: Stopped");
}

async function getNumberOfScreens() {
  return new Promise((resolve, reject) => {
    const ssr = spawn("xrandr", []);
    // ssr.stdin.setEncoding("utf-8");
    let output = "";
    ssr.stdout.on("data", (data) => {
      output += data.toString();
    });
    ssr.on("close", (code) => {
      if (code > 0) return reject();
      const count = (output.match(/ connected/g) || []).length;
      resolve(count);
    });
  });
}

async function run(command, args = [], input = "") {
  return new Promise((resolve, reject) => {
    const child = spawn(command, args);
    if (input) {
      child.stdin.setEncoding("utf-8");
      child.stdin.write(input);
      child.stdin.end();
    }
    let output = "";
    child.stdout.on("data", (data) => {
      output += data.toString();
    });
    child.on("close", (code) => {
      notify("run", { command, code });
      if (code > 0) return reject();
      resolve(output);
    });
  });
}

process.on("SIGTERM", () => {
  shutdown();
});
process.on("SIGINT", () => {
  shutdown();
});
async function shutdown() {
  notify("Shutting everything down");
  shuttingDown = true;
  try {
    await ssrStopRecording();
  } catch (e) {
    console.error(e);
  }
  try {
    xautolock.kill();
  } catch (e) {
    console.error(e);
  }
  process.exit(0);
}
