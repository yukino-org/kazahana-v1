import { join } from "path";
import { writeFile } from "fs-extra";
import png2ico from "png-to-ico";
import { config } from "../../../config";
import { Logger } from "../../../logger";

const logger = new Logger("windows:icons");

export const path = join(
    config.windows.project,
    `/runner/resources/app_icon.ico`
);

export const generate = async () => {
    logger.log(`Icon path: r{clr,cyanBright,${config.windows.icon}}.`);

    const ico = await png2ico(config.windows.icon);
    await writeFile(path, ico);
    logger.log(`Generated: r{clr,cyanBright,${path}}.`);
};
