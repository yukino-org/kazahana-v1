// TODO: do this
export const Repos = {
    extensionsStore: {
        repo: {
            owner: "yukino-org",
            repo: "extensions-store",
        },
        commitsApiURL() {
            return `https://api.github.com/repos/${this.repo.owner}/${this.repo.repo}/commits?per_page=1`;
        },
        languagesJson(sha: string) {
            return `https://raw.githubusercontent.com/${this.repo.owner}/${this.repo.repo}/${sha}/lib/assets/languages.json`;
        },
    },
};
