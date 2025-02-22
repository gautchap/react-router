module.exports = {
    apps: [
        {
            name: "react-router",
            script: "./build/server.js",
            instances: "max",
            exec_mode: "cluster",
            autorestart: true,
        },
    ],
};
