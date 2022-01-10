import logSymbols from "log-symbols";
import chalk from "chalk";

export class Logger {
    constructor(public readonly _name: string) {}

    log(text: string) {
        console.log(
            `${this.name} ${chalk.cyanBright("INFO")} ${Logger.renderText(
                text
            )}`
        );
    }

    warn(text: string) {
        console.warn(
            `${this.name} ${chalk.yellowBright("WARN")} ${Logger.renderText(
                text
            )}`
        );
    }

    error(text: string) {
        console.error(
            `${this.name} ${chalk.redBright("ERR!")} ${Logger.renderText(text)}`
        );
    }

    get name() {
        return chalk.gray(`[${this._name}]`);
    }

    static renderText(text: string) {
        const regexReplace = (
            text: string,
            regex: RegExp,
            replacer: (match: RegExpMatchArray, str: string) => string
        ) =>
            text.replace(new RegExp(regex, "g"), (x) =>
                replacer(x.match(regex)!, x)
            );

        const replacers: ((text: string) => string)[] = [
            (text: string) =>
                regexReplace(
                    text,
                    /r{clr,([^,]+),([^}]+)}/,
                    ([, mods, data]) => {
                        return mods.split("|").reduce((pv, cv) => {
                            // @ts-ignore
                            const fn = chalk[cv];
                            return typeof fn === "function" ? fn(pv) : pv;
                        }, data);
                    }
                ),
            (text: string) =>
                regexReplace(text, /r{sym,([^,]+)}/, ([, sym], str) => {
                    // @ts-ignore
                    const symbol = logSymbols[sym] as string | undefined;
                    return symbol ?? str;
                }),
        ];

        return replacers.reduce((pv, cv) => {
            return cv(pv);
        }, text);
    }
}
