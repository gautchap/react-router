import type { Route } from "./+types/about";

export function meta({}: Route.MetaArgs) {
    return [{ title: "New React Router App" }, { name: "description", content: "Welcome to React Router!" }];
}

export default function About() {
    return (
        <div>
            <h1 className="text-3xl text-yellow-300">Hello world</h1>
        </div>
    );
}
