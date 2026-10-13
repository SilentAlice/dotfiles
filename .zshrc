# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
 if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
 fi

# ===== Harmony PC 环境配置 =====
# 追加各工具链 bin 到 PATH（放在最前，优先使用 harmonybrew 的完整版 zsh）
export PATH="/data/storage/el2/base/files/npm_global_modules/bin:$PATH" # npm全局包
export PATH="$HOME/.harmonybrew/bin:$PATH"                        	# harmonybrew（含完整版 zsh）
export PATH="/data/service/hnp/bin:$PATH"                         	# node/npm/npx/python
export PATH="$HOME/.local/bin:$PATH"					# my local bin

# ===== Oh My Zsh =====
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
#ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)

# 关闭 compaudit 安全校验警告（compaudit:142: unknown group）
ZSH_DISABLE_COMPFIX="true"

HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=30

source $ZSH/oh-my-zsh.sh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ===== HarmonyOS 修复：禁用 p10k 的 gitstatus =====
# 原因：HarmonyOS 环境 zsh 无控制终端(job control)，gitstatus 启动即报
#       "can't change option: monitor"，导致 git status 报错刷屏。
# 此变量必须放在 source ~/.p10k.zsh 之后，否则会被其 unset -m 'POWERLEVEL9K_*' 清掉。
# git 相关功能由 oh-my-zsh 自带 git 插件提供。
export POWERLEVEL9K_DISABLE_GITSTATUS=1
