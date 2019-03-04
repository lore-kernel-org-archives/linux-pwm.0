From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v10 13/27] pwm: jz4740: Use clocks from TCU driver
Date: Mon, 04 Mar 2019 19:18:00 +0100
Message-ID: <1551723480.4932.1@crapouillou.net>
References: <20190302233413.14813-1-paul@crapouillou.net>
        <20190302233413.14813-14-paul@crapouillou.net> <20190304123003.GE9040@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190304123003.GE9040@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Mathieu Malaterre <malat@debian.org>, od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


On Mon, Mar 4, 2019 at 1:30 PM, Thierry Reding 
<thierry.reding@gmail.com> wrote:
> On Sat, Mar 02, 2019 at 08:33:59PM -0300, Paul Cercueil wrote:
>>  The ingenic-timer "TCU" driver provides us with clocks, that can be
>>  (un)gated, reparented or reclocked from devicetree, instead of 
>> having
>>  these settings hardcoded in this driver.
>> 
>>  While this driver is devicetree-compatible, it is never (as of now)
>>  probed from devicetree, so this change does not introduce a ABI 
>> problem
>>  with current devicetree files.
>> 
>>  Note that the "select REGMAP" has been dropped because it's
>>  already enabled by the "select INGENIC_TIMER".
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net 
>> <mailto:paul@crapouillou.net>>
>>  Tested-by: Mathieu Malaterre <malat@debian.org 
>> <mailto:malat@debian.org>>
>>  Tested-by: Artur Rojek <contact@artur-rojek.eu 
>> <mailto:contact@artur-rojek.eu>>
>>  ---
>> 
>>  Notes:
>>           v9: New patch
>> 
>>           v10: Explain in commit message why "select REGMAP" was 
>> dropped
>> 
>>   drivers/pwm/Kconfig      |  3 ++-
>>   drivers/pwm/pwm-jz4740.c | 39 
>> ++++++++++++++++++++++++++-------------
>>   2 files changed, 28 insertions(+), 14 deletions(-)
>> 
>>  diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>>  index ace8ea4b6247..4e201e970509 100644
>>  --- a/drivers/pwm/Kconfig
>>  +++ b/drivers/pwm/Kconfig
>>  @@ -204,7 +204,8 @@ config PWM_IMX
>>   config PWM_JZ4740
>>   	tristate "Ingenic JZ47xx PWM support"
>>   	depends on MACH_INGENIC
>>  -	select REGMAP
>>  +	depends on COMMON_CLK
>>  +	select INGENIC_TIMER
> 
> Okay... sounds like this would be okay. I'm assuming you go through 
> that
> extra step of selecting REGMAP in the prior patch and dropping it here
> again so that you keep the series bisectible?

Yes, exactly.

>>   	help
>>   	  Generic PWM framework driver for Ingenic JZ47xx based
>>   	  machines.
>>  diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
>>  index 8dfac5ffd71c..c6136bd4434b 100644
>>  --- a/drivers/pwm/pwm-jz4740.c
>>  +++ b/drivers/pwm/pwm-jz4740.c
>>  @@ -28,7 +28,7 @@
>> 
>>   struct jz4740_pwm_chip {
>>   	struct pwm_chip chip;
>>  -	struct clk *clk;
>>  +	struct clk *clks[NUM_PWM];
>>   	struct regmap *map;
>>   };
>> 
>>  @@ -40,6 +40,9 @@ static inline struct jz4740_pwm_chip 
>> *to_jz4740(struct pwm_chip *chip)
>>   static int jz4740_pwm_request(struct pwm_chip *chip, struct 
>> pwm_device *pwm)
>>   {
>>   	struct jz4740_pwm_chip *jz = to_jz4740(chip);
>>  +	struct clk *clk;
>>  +	char clk_name[16];
>>  +	int ret;
>> 
>>   	/*
>>   	 * Timers 0 and 1 are used for system tasks, so they are 
>> unavailable
>>  @@ -48,16 +51,29 @@ static int jz4740_pwm_request(struct pwm_chip 
>> *chip, struct pwm_device *pwm)
>>   	if (pwm->hwpwm < 2)
>>   		return -EBUSY;
>> 
>>  -	regmap_write(jz->map, TCU_REG_TSCR, BIT(pwm->hwpwm));
>>  +	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
>> 
>>  +	clk = clk_get(chip->dev, clk_name);
>>  +	if (IS_ERR(clk))
>>  +		return PTR_ERR(clk);
>>  +
>>  +	ret = clk_prepare_enable(clk);
>>  +	if (ret) {
>>  +		clk_put(clk);
>>  +		return ret;
>>  +	}
>>  +
>>  +	jz->clks[pwm->hwpwm] = clk;
>>   	return 0;
>>   }
> 
> Since you're already using ->request(), why not add a per-PWM 
> structure
> that tracks the clock? There are a number of other PWMs that already 
> do
> something similar. You can use pwm_{set,get}_chip_data() to associate
> chip-specific extra data with a PWM.
> 
> Thierry

Good idea.

-Paul
