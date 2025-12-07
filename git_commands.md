# Git 常用指令速查表

## 1. 初始设置 (Setup & Config)

| 指令 | 说明 |
| :--- | :--- |
| `git config --global user.name "你的名字"` | 设置提交时的用户名 |
| `git config --global user.email "你的邮箱"` | 设置提交时的邮箱 |
| `git init` | 在当前目录初始化一个新的 Git 仓库 |
| `git clone [url]` | 克隆远程仓库到本地 |

## 2. 基础操作 (Basic Snapshotting)

| 指令 | 说明 |
| :--- | :--- |
| `git status` | 查看当前仓库状态 (哪些文件修改了、暂存了) |
| `git add [文件名]` | 将指定文件添加到暂存区 (准备提交) |
| `git add .` | 将所有修改过的文件添加到暂存区 |
| `git commit -m "提交信息"` | 提交暂存区的更改到本地版本库 |
| `git commit -am "提交信息"` | 这是一步完成添加和提交 (仅限已跟踪的文件) |

## 3. 分支与合并 (Branching & Merging)

| 指令 | 说明 |
| :--- | :--- |
| `git branch` | 列出本地所有分支，当前分支前有 * 号 |
| `git branch -a` | 列出所有分支 (包括远程分支) |
| `git branch [分支名]` | 创建一个新分支 |
| `git checkout [分支名]` | 切换到指定分支 |
| `git switch [分支名]` | 切换分支 (推荐新版本使用) |
| `git checkout -b [分支名]` | 创建并立即切换到在这个新分支 |
| `git merge [分支名]` | 将指定分支合并到当前分支 |
| `git branch -d [分支名]` | 删除指定分支 |

## 4. 远程同步 (Sharing & Updating)

| 指令 | 说明 |
| :--- | :--- |
| `git remote -v` | 查看远程仓库地址 |
| `git pull` | 拉取远程代码并自动合并到当前分支 |
| `git push` | 将本地提交推送到远程仓库 |
| `git push -u origin [分支名]` | 推送新分支并设置上游关联 |
| `git fetch` | 获取远程仓库的更新，但不合并 (配合 diff 查看) |

## 5. 查看与比较 (Inspection & Comparison)

| 指令 | 说明 |
| :--- | :--- |
| `git log` | 查看提交历史记录 |
| `git log --oneline --graph` | 以图形化简略方式查看历史 |
| `git diff` | 查看工作区尚未暂存的差异 |
| `git diff --staged` | 查看已暂存但尚未提交的差异 |

## 6. 撤销与回滚 (Undoing Changes)

| 指令 | 说明 |
| :--- | :--- |
| `git restore [文件名]` | 丢弃工作区的修改 (文件恢复到最后一次提交的状态) |
| `git restore --staged [文件名]` | 将文件从暂存区移出 (取消 `git add`) |
| `git reset --hard HEAD^` | 回退到上一个版本 (**警告：会丢失未提交的修改**) |
| `git stash` | 暂时保存当前工作进度 (还没写完不想提交时用) |
| `git stash pop` | 恢复之前保存的工作进度 |

## 7. 常见场景

### 忽略文件 (.gitignore)
创建一个名为 `.gitignore` 的文件，在里面列出不想被 Git 管理的文件或文件夹（如编译生成的文件、敏感配置等）。
Example:
```
# 忽略所有 .log 文件
*.log

# 忽略 node_modules 文件夹
node_modules/
```
