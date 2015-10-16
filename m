From: YH Huang <yh.huang@mediatek.com>
Subject: Re: [RESEND PATCH] pwm-backlight: fix the panel power sequence
Date: Fri, 16 Oct 2015 16:49:50 +0800
Message-ID: <1444985390.18373.2.camel@mtksdaap41>
References: <201510161036.Q5q8ayZx%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201510161036.Q5q8ayZx%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com
List-Id: linux-pwm@vger.kernel.org

On Fri, 2015-10-16 at 10:42 +0800, kbuild test robot wrote:
> Hi YH,
> 
> [auto build test ERROR on pwm/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]
> 
> url:    https://github.com/0day-ci/linux/commits/YH-Huang/pwm-backlight-fix-the-panel-power-sequence/20151016-093957
> config: i386-allmodconfig (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/video/backlight/pwm_bl.c: In function 'pwm_backlight_probe':
> >> drivers/video/backlight/pwm_bl.c:245:20: error: too few arguments to function 'devm_gpiod_get_optional'
>      pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable");
>                        ^
>    In file included from drivers/video/backlight/pwm_bl.c:13:0:
>    include/linux/gpio/consumer.h:80:32: note: declared here
>     struct gpio_desc *__must_check devm_gpiod_get_optional(struct device *dev,
>                                    ^
> 
> vim +/devm_gpiod_get_optional +245 drivers/video/backlight/pwm_bl.c
> 
>    239		pb->notify_after = data->notify_after;
>    240		pb->check_fb = data->check_fb;
>    241		pb->exit = data->exit;
>    242		pb->dev = &pdev->dev;
>    243		pb->enabled = false;
>    244	
>  > 245		pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable");
>    246		if (IS_ERR(pb->enable_gpio)) {
>    247			ret = PTR_ERR(pb->enable_gpio);
>    248			goto err_alloc;
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Sorry, I made a mistake.
I will send patch v2 to fix it.

YH Huang
