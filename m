Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v3 11/18] pwm: Add new pwm-samsung driver
Date: Mon, 24 Jun 2013 17:37:14 +0200
Message-ID: <2127827.gZe35M7nEN@flatron>
In-Reply-To: <51C86442.6090406@samsung.com>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com> <2925617.TjWXJcIKRC@flatron> <51C86442.6090406@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Thierry Reding <thierry.reding@gmail.com>

On Tuesday 25 of June 2013 00:22:42 Kukjin Kim wrote:
> On 06/22/13 22:06, Tomasz Figa wrote:
> > This patch introduces new Samsung PWM driver, which is heavily
> > cleaned,
> > multiplatform aware and supports DeviceTree based instantiation.
> > 
> > Since on historical hardware PWM block can be shared with clocksource
> > driver, a shared spinlock is used to protect access to shared
> > registers, already exported from the clocksource driver.
> > 
> > Signed-off-by: Tomasz Figa<tomasz.figa@gmail.com>
> > ---
> > 
> >   drivers/pwm/Makefile      |   1 +
> >   drivers/pwm/pwm-samsung.c | 601
> >   ++++++++++++++++++++++++++++++++++++++++++++++ 2 files changed, 602
> >   insertions(+)
> >   create mode 100644 drivers/pwm/pwm-samsung.c
> > 
> > Changes since v2:
> >   - Replaced __raw_{readl,writel} with {readl,writel}.
> >   - Corrected commit message.
> 
> [...]
> 
> > +	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, 
val)
> > {
> > +		if (val>= SAMSUNG_PWM_NUM) {
> > +			pr_warning("%s: invalid channel index in 
samsung,pwm-outputs
> > property\n",
> Just note, checkpatch complains following, so fixed to use pr_warn()
> when I applied.
> 
> WARNING: Prefer pr_warn(... to pr_warning(...
> #471: FILE: drivers/pwm/pwm-samsung.c:432:
> +			pr_warning("%s: invalid channel index in 
samsung,pwm-outputs
> property\n",
> 
> [...]
> 
> > +
> > +static struct dev_pm_ops pwm_samsung_pm_ops = {
> 
> WARNING: struct dev_pm_ops should normally be const
> #622: FILE: drivers/pwm/pwm-samsung.c:583:
> +static struct dev_pm_ops pwm_samsung_pm_ops = {
> 
> fixed to add const when I applied.

Oops, I forgot to fix them, sorry. Thank you for fixing and applying.

Best regards,
Tomasz
