# 🏠 Colineon's Blog

基于 [Astro](https://astro.build) + [Fuwari](https://github.com/saicaca/fuwari) 的个人博客。

---

## 快速开始

```bash
pnpm install          # 安装依赖（首次）
pnpm dev              # 启动本地开发服务器 → http://localhost:4321
pnpm build            # 构建静态文件到 dist/
```

---

## 写新文章

```bash
# 中文标题 → 需要英文目录名
./scripts/new-post.sh "如何组装一台服务器" "how-to-build-a-server"

# 英文标题 → 自动生成目录名
./scripts/new-post.sh "How to build a server"
```

创建后编辑 `src/content/posts/<slug>/index.md`，必填 frontmatter：

```yaml
---
title: 文章标题
published: 2026-06-16        # 发布日期
description: 一句话简介        # 显示在卡片 + SEO
image:                        # 写 ./cover.jpg = 同目录下封面图，若无封面图则删除此行
tags: [Tag1, Tag2]            # 可选
category: Tech                # 可选
draft: false                  # true = 草稿，首页不显示
---
```

文章用标准 Markdown 写，支持代码高亮、数学公式、表格、Github Admonitions(`> [!note]`)。

---

## 自定义清单

所有关键配置集中在 `src/config.ts`：

| 你要改的 | 配置项 | 怎么改 |
|---------|--------|--------|
| 网站标题 | `siteConfig.title` | 直接改字符串 |
| 副标题 | `siteConfig.subtitle` | 直接改字符串 |
| 主题色 | `siteConfig.themeColor.hue` | 0=红 200=青绿 250=蓝紫 345=粉 |
| 你的昵称 | `profileConfig.name` | 直接改 |
| 个人简介 | `profileConfig.bio` | 直接改 |
| 头像 | `profileConfig.avatar` | 替换 `src/assets/images/demo-avatar.png`，或改路径 |
| 社交链接 | `profileConfig.links` | 增删改链接，图标名去 [icones.js.org](https://icones.js.org) 找 |
| 导航栏 | `navBarConfig.links` | 增删导航项 |
| Banner 图 | `siteConfig.banner` | `enable: true`，替换 `demo-banner.png` |
| Favicon | `public/favicon/` | 替换 8 张图 |
| Giscus 评论 | `src/components/widget/GiscusComment.astro` | 顶部改 `repoId` / `categoryId` |
| About 页 | `src/pages/about.astro` | 直接改里面文字 |
| CC 协议 | `licenseConfig` | 改 `enable` / `name` / `url` |
| 文章列表分页 | `src/pages/[...page].astro` | `perPage: 4` → 改数字 |
| RSS / Sitemap | 自动生成 | `src/pages/rss.xml.ts` 和 sitemap 插件 |

---

## 部署

推送到 `master` 分支即可，GitHub Actions 自动构建部署到 GitHub Pages。

```bash
git add -A && git commit -m "描述你的改动" && git push
```

确保仓库 Settings → Pages → Source 选 **GitHub Actions**。

---

## SEO

以下开箱即用：
- `sitemap.xml` — 搜索引擎自动抓取
- `rss.xml` — RSS 阅读器可订阅
- JSON-LD 结构化数据 — 搜索结果更美观
- 文章 `description` 字段 → `<meta description>`

你要做的是：
1. 每篇文章写好 `description`（Google 搜索结果那段话）
2. 配 `image` 封面图 → 分享到社交平台会带缩略图
3. `public/default-og.jpg` 是全局 OG 图——分享链接时的缩略图，需自己创建一张 1200×630 的图放进去（模板不自带）

---

## 目录结构

```
.
├── public/              # 静态资源（favicon、CNAME、og 图）
│   ├── CNAME            # GitHub Pages 自定义域名
│   └── favicon/         # 替换这些图
├── scripts/
│   └── new-post.sh      # 快速创建文章脚本
├── src/
│   ├── assets/images/   # 头像、banner 等
│   ├── components/      # UI 组件
│   │   └── widget/GiscusComment.astro  # Giscus 评论配置
│   ├── config.ts        # ⭐ 核心配置文件
│   ├── content/
│   │   └── posts/       # ⭐ 所有文章放这里（每篇一个子目录）
│   └── pages/           # 页面
│       ├── about.astro  # 关于页
│       └── posts/[...slug].astro  # 文章详情页模板
└── astro.config.mjs     # Astro 框架配置（一般不用改）
```
