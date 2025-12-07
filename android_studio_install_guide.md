# Android Studio Otter 2 | 2025.2.2 安装指南 (Windows 版)

**当前版本**: 2025.2.2 (Otter Feature Drop)
**发布日期**: 2025年12月4日
**适用通道**: Stable Channel
**适用系统**: Windows 10/11 (64-bit)

## 1. 为什么升级？ (新特性亮点)

Android Studio Otter 2 引入了多项关键更新，重点提升了 Kotlin 开发体验和 IDE 基础性能：

*   **Kotlin K2 Mode 增强**: 提供更快的代码分析、更稳定的检查 (Inspections) 以及更可靠的脚本执行体验。
*   **终端性能提升**: 重写的集成终端，渲染速度大幅提升。
*   **云端设置同步 (Backup & Sync)**: 使用 Google 或 JetBrains 账号，在不同 PC 间无缝同步你的键位映射 (Keymaps) 和设置。
*   **Gemini AI 集成**: 实验性功能，支持自动生成 Compose 预览，以及通过 Agent Mode 访问 Android 知识库。

## 2. 系统要求 (Windows)

在安装前，请确保您的电脑满足以下要求以获得流畅体验：

*   **操作系统**: 64-bit Windows 10 或 Windows 11。
*   **CPU**: x86_64 架构; Intel Core i5 (8代及以上) 或 AMD Ryzen (Zen及以上) 推荐。
    *   *注意*: 必须在 BIOS 中开启虚拟化支持 (Intel VT-x, AMD-V)。
*   **内存 (RAM)**:
    *   **最低**: 8 GB
    *   **推荐**: 16 GB 或更高 (尤其是同时运行 IDE 和模拟器时)。
*   **硬盘空间**: 至少 8 GB 可用空间 (IDE + SDK + 模拟器)，强烈建议使用 **SSD**。
*   **显示器**: 1280 x 800 最小分辨率。

## 3. 下载与安装

### 方式 A: 自动更新 (推荐)
如果你已经安装了 Android Studio 的旧版本：
1.  打开 Android Studio。
2.  点击顶部菜单栏的 **Help** > **Check for Updates**。
3.  如果没检测到，请确保你的更新通道设置为 **Stable**。
    *   *设置路径*: File > Settings > Appearance & Behavior > System Settings > Updates > 将 "Automatically check updates for" 设置为 "Stable Channel"。

### 方式 B: 全新安装
1.  **下载安装包**:
    *   访问 [Android Studio 官网](https://developer.android.com/studio)。
    *   点击 "Download Android Studio Otter" 下载 Windows 版 `.exe` 安装程序 (约 1.2 GB)。
2.  **运行安装程序**:
    *   双击下载的 `.exe` 文件。
    *   如果弹出 "User Account Control" 窗口，点击 **Yes**。
3.  **安装向导配置**:
    *   **Welcome**: 点击 Next。
    *   **Choose Components**: 确保勾选 **Android Studio** 和 **Android Virtual Device** (如果你打算使用模拟器)。点击 Next。
    *   **Configuration Settings**: 默认安装路径为 `C:\Program Files\Android\Android Studio`。建议保持默认，点击 Next。
    *   **Start Menu Folder**: 点击 Install 开始安装。
    *   安装完成后点击 Finish 启动 Android Studio。

## 4. 初始化配置 (Setup Wizard)

首次启动时，Setup Wizard 会引导你完成环境配置：

1.  **Import Settings**: 如果是全新安装，选择 "Do not import settings"。
2.  **Install Type**: 选择 **Standard** (标准) 即可。它会自动配置最常用的设置。
3.  **Verify Settings**: 向导会列出将要下载的组件 (Android SDK Platform API 35/36, Performance (Intel HAXM/AEHD), Emulator 等)。
    *   *提示*: 如果你的 CPU 是 AMD，这里可能会显示 "Android Emulator Hypervisor Driver for AMD Processors"。
4.  **License Agreement**: 在左侧列表分别点击 `android-sdk-license` 和 `android-sdk-preview-license` (如果有)，然后点击 "Accept" 按钮。
5.  **Finish**: 系统开始下载并解压组件。这可能需要几分钟，取决于你的网速。



## 5. 环境变量配置 (可选但推荐)

虽然 Android Studio 内部可以识别 SDK，但为了方便在命令行使用 `adb`、`emulator` 或其他工具，建议配置环境变量。

### 方式 A: 图形界面配置

1.  **打开设置**: Win + S 搜索 "环境" -> 选择 "编辑系统环境变量" -> 点击 "环境变量"。
2.  **设置 ANDROID_HOME**:
    *   在 "用户变量" 下点击 **新建**。
    *   **变量名**: `ANDROID_HOME`
    *   **变量值**: 你的 Android SDK 路径 (默认通常是 `%LOCALAPPDATA%\Android\Sdk`)。
3.  **添加到 Path**:
    *   在 "用户变量" 中找到 **Path**，点击 **编辑**。
    *   点击 **新建**，分别添加以下 3 行：
        *   `%ANDROID_HOME%\platform-tools`
        *   `%ANDROID_HOME%\emulator`
        *   `%ANDROID_HOME%\cmdline-tools\latest\bin`
    *   一路点击 **确定** 保存。
4.  **验证**: 打开新的 PowerShell 窗口，输入 `adb --version` 或 `emulator -version`。如果显示版本号，则配置成功。

### 方式 B: 命令行配置 (快速)

如果你更喜欢使用命令行，可以用 **管理员权限** 打开 PowerShell，然后依次执行以下命令：

```powershell
# ⚠️ 重要: 此脚本需要【管理员权限】运行
# 请右键点击 PowerShell -> "以管理员身份运行"

# 检查是否具有管理员权限
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Warning "请以【管理员身份】运行此脚本以修改系统环境变量！"
    break
}

# 设置 ANDROID_HOME 系统环境变量
[System.Environment]::SetEnvironmentVariable('ANDROID_HOME', "$env:LOCALAPPDATA\Android\Sdk", 'Machine')

# 获取系统级 Path 并添加 Android 相关路径
$currentPath = [System.Environment]::GetEnvironmentVariable('Path', 'Machine')
$androidPaths = @(
    "$env:LOCALAPPDATA\Android\Sdk\platform-tools",
    "$env:LOCALAPPDATA\Android\Sdk\emulator",
    "$env:LOCALAPPDATA\Android\Sdk\cmdline-tools\latest\bin"
)

foreach ($path in $androidPaths) {
    # 检查路径是否已存在 (忽略大小写)
    if ($currentPath -split ';' -notcontains $path) {
        $currentPath += ";$path"
        Write-Host "准备添加: $path"
    }
}

# 保存更新后的 Path 到系统变量
[System.Environment]::SetEnvironmentVariable('Path', $currentPath, 'Machine')

# 验证
Write-Host "✅ 系统环境变量配置完成！"
Write-Host "⚠️ 注意：你需要【重启所有终端窗口】(包括 VS Code) 才能生效。"
Write-Host "验证命令: adb --version"
```

> **注意**: 如果你的 SDK 安装在其他位置，请将 `$env:LOCALAPPDATA\Android\Sdk` 替换为实际路径。


## 6. 常见问题 (FAQ)



**Q: 安装后创建模拟器报错 "HAXM is not installed" 或 "Hyper-V" 相关错误？**
A: Windows 10/11 推荐使用 WHPX (Windows Hypervisor Platform)。
1.  确保在 BIOS 中开启了 VT-x/AMD-V。
2.  在 Windows 搜索栏输入 "启用或关闭 Windows 功能" (Turn Windows features on or off)。
3.  确保勾选 **Windows Hypervisor Platform**。
4.  重启电脑。

**Q: 可以修改 SDK 的默认下载位置吗？**
A: 可以。在 Setup Wizard 的 "Install Type" 步骤选择 **Custom**，或者在安装完成后进入 File > Settings > Languages & Frameworks > Android SDK 中修改路径。建议不要放在含有中文或空格的路径下。

**Q: 如何验证安装成功？**
A: 在欢迎界面点击 **New Project**，选择 "Empty Activity"，点击 Finish。如果项目能成功构建 (Build Successful) 并能运行在模拟器或真机上，即说明安装成功。
