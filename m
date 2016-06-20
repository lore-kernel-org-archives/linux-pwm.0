From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 4/4] ARM: dts: meson8b: Add Meson8b PWM Controller nodes
Date: Mon, 20 Jun 2016 12:06:34 +0200
Message-ID: <5767C02A.50700@baylibre.com>
References: <201606180219.HabMMLCO%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201606180219.HabMMLCO%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, thierry.reding@gmail.com, carlo@caione.org, khilman@baylibre.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 06/17/2016 08:21 PM, kbuild test robot wrote:
> Hi,
> 
> [auto build test ERROR on next-20160617]
> [cannot apply to pwm/for-next robh/for-next v4.7-rc3 v4.7-rc2 v4.7-rc1 v4.7-rc3]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Neil-Armstrong/pwm-Add-Amlogic-Meson-SoC-PWM-Controller/20160617-223758
> config: arm-multi_v7_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
>>> Error: arch/arm/boot/dts/meson8b.dtsi:167.17-18 syntax error
>    FATAL ERROR: Unable to parse input tree
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

I'll fix this for V2.

Neil
