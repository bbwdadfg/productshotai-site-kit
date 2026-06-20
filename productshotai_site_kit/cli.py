"""Command line helpers for ProductShot AI product-photo workflows."""

from __future__ import annotations

import argparse
import csv
import json
import re
import sys
from pathlib import Path
from typing import Iterable, TextIO

from . import metadata, workbench_url

IMAGE_EXTENSIONS = {".avif", ".gif", ".jpeg", ".jpg", ".png", ".webp"}


def slugify(value: str) -> str:
    """Return a stable slug for a product name or image stem."""
    text = re.sub(r"[^a-zA-Z0-9]+", "-", value.strip().lower())
    text = re.sub(r"-+", "-", text).strip("-")
    return text or "product"


def product_name_from_path(path: Path) -> str:
    words = re.split(r"[-_\s]+", path.stem)
    clean = " ".join(part.capitalize() for part in words if part)
    return clean or path.stem


def iter_images(root: Path) -> Iterable[Path]:
    if root.is_file():
        if root.suffix.lower() in IMAGE_EXTENSIONS:
            yield root
        return

    paths = sorted(
        (path for path in root.rglob("*") if not any(part.startswith(".") for part in path.relative_to(root).parts)),
        key=lambda path: (len(path.relative_to(root).parts), path.relative_to(root).as_posix().lower()),
    )
    for path in paths:
        if path.is_file() and not path.name.startswith(".") and path.suffix.lower() in IMAGE_EXTENSIONS:
            yield path


def build_manifest(root: Path) -> list[dict[str, str]]:
    base = root if root.is_dir() else root.parent
    rows = []
    for image in iter_images(root):
        name = product_name_from_path(image)
        rows.append(
            {
                "file_name": image.name,
                "relative_path": image.relative_to(base).as_posix(),
                "product_name": name,
                "product_slug": slugify(name),
                "workbench_url": workbench_url(),
                "productshotai_workbench_url": workbench_url(),
                "notes": "",
            }
        )
    return rows


def build_prompt_sheet(root: Path) -> list[dict[str, str]]:
    rows = []
    for item in build_manifest(root):
        rows.append(
            {
                "product_name": item["product_name"],
                "product_slug": item["product_slug"],
                "source_image": item["relative_path"],
                "prompt": f"Clean ecommerce product photo for {item['product_name'].lower()}",
                "background": "white seamless background",
                "background_style": "clean studio background",
                "scene_prompt": f"Create a polished ecommerce product photo for {item['product_name']}.",
                "negative_prompt": "blurry, distorted, extra logos, unreadable text",
                "output_notes": "",
                "productshotai_workbench_url": item["productshotai_workbench_url"],
            }
        )
    return rows


def write_rows(rows: list[dict[str, str]], output_format: str, stream: TextIO) -> None:
    if output_format == "json":
        json.dump(rows, stream, indent=2)
        stream.write("\n")
        return

    if not rows:
        return

    writer = csv.DictWriter(stream, fieldnames=list(rows[0].keys()))
    writer.writeheader()
    writer.writerows(rows)


def write_output(rows: list[dict[str, str]], output_format: str, output: str | None, stream: TextIO) -> None:
    if output:
        with open(output, "w", encoding="utf-8", newline="") as handle:
            write_rows(rows, output_format, handle)
        return
    write_rows(rows, output_format, stream)


def write_manifest_json(rows: list[dict[str, str]], stream: TextIO) -> None:
    json.dump({"image_count": len(rows), "images": rows}, stream, indent=2)
    stream.write("\n")


def write_prompt_json(rows: list[dict[str, str]], stream: TextIO) -> None:
    json.dump({"prompt_count": len(rows), "prompts": rows}, stream, indent=2)
    stream.write("\n")


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="productshotai-site-kit",
        description="Prepare ProductShot AI product-photo workflow metadata.",
    )
    subcommands = parser.add_subparsers(dest="command", required=True)

    urls = subcommands.add_parser("urls", help="Print ProductShot AI public URLs and metadata.")
    urls.add_argument("--format", choices=["json", "text"], default="json")

    manifest = subcommands.add_parser("manifest", help="Create an image manifest CSV or JSON.")
    manifest.add_argument("path", type=Path, help="Image file or directory to scan.")
    manifest.add_argument("--format", choices=["csv", "json"], default="csv")
    manifest.add_argument("--output", help="Write output to this file instead of stdout.")

    prompt = subcommands.add_parser("prompt-sheet", help="Create a product-shot prompt planning sheet.")
    prompt.add_argument("path", type=Path, help="Image file or directory to scan.")
    prompt.add_argument("--format", choices=["csv", "json"], default="csv")
    prompt.add_argument("--output", help="Write output to this file instead of stdout.")

    return parser


def main(argv: list[str] | None = None, stdout: TextIO | None = None) -> int:
    stream = stdout or sys.stdout
    args = build_parser().parse_args(argv)

    if args.command == "urls":
        data = metadata()
        if args.format == "json":
            json.dump(data, stream, indent=2)
            stream.write("\n")
        else:
            pages = data["canonicalPages"]
            for name in sorted(pages):
                print(f"{name}: {pages[name]}", file=stream)
        return 0

    if args.command == "manifest":
        rows = build_manifest(args.path)
        if args.output:
            write_output(rows, args.format, args.output, stream)
        elif args.format == "json":
            write_manifest_json(rows, stream)
        else:
            write_rows(rows, args.format, stream)
        return 0

    if args.command == "prompt-sheet":
        rows = build_prompt_sheet(args.path)
        if args.output:
            write_output(rows, args.format, args.output, stream)
        elif args.format == "json":
            write_prompt_json(rows, stream)
        else:
            write_rows(rows, args.format, stream)
        return 0

    return 2


if __name__ == "__main__":
    raise SystemExit(main())
