import type { Route } from "./+types/test";

export function meta({}: Route.MetaArgs) {
    return [{ title: "New React Router App" }, { name: "description", content: "Welcome to React Router!" }];
}

export default function Test() {
    return (
        <div>
            <h1 className="text-5xl text-red-500">This is test Route</h1>
        </div>
    );
}
