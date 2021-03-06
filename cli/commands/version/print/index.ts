import { join } from "path";
import { readFile } from "fs-extra";
import { config } from "../../../config";

export const matchRegex = /version:(.*)/;

export const getVersion = async () => {
    const path = join(config.base, "pubspec.yaml");
    const content = (await readFile(path)).toString();
    return content.match(matchRegex)![1].trim();
};
