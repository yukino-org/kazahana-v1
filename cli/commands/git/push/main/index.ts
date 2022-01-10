import { config } from "../../../../config";
import { Logger } from "../../../../logger";
import { spawn } from "../../../../spawn";

const logger = new Logger("git:push:main");

const next = "next";
const main = "main";

export const pushMain = async () => {
    await spawn("git", ["checkout", main], { cwd: config.base });
    logger.log(`Checked out to r{clr,cyanBright,${main}}.`);

    await spawn("git", ["merge", next], { cwd: config.base });
    logger.log(`Merged r{clr,cyanBright,${next}}.`);

    await spawn("git", ["push", "origin", main], { cwd: config.base });
    logger.log(`Pushed r{clr,cyanBright,${main}}.`);

    await spawn("git", ["checkout", next], { cwd: config.base });
    logger.log(`Checked out to r{clr,cyanBright,${next}}.`);

    logger.log(
        `Merged r{clr,cyanBright,${next}} with r{clr,cyanBright,${main}}.`
    );
};
