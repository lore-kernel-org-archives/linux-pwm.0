From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 2/2] drivers: pwm: pwm-atmel: add support to allow run
 time changing of pwm parameters
Date: Thu, 23 Feb 2017 11:32:26 +0100
Message-ID: <20170223113226.7b24ffb6@bbrezillon>
References: <1487839120-13650-1-git-send-email-claudiu.beznea@microchip.com>
        <1487839120-13650-3-git-send-email-claudiu.beznea@microchip.com>
        <20170223092148.5qmxy62xkufwbsrw@piout.net>
        <f963def2-6d82-3bf7-22fa-8915f408ca54@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f963def2-6d82-3bf7-22fa-8915f408ca54@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: m18063 <Claudiu.Beznea@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Claudiu,

On Thu, 23 Feb 2017 12:25:58 +0200
m18063 <Claudiu.Beznea@microchip.com> wrote:

> Hi,
> 
> 
> On 23.02.2017 11:21, Alexandre Belloni wrote:
> > On 23/02/2017 at 10:38:40 +0200, Claudiu Beznea wrote:  
> >> sama5d2 supports changing of pwm parameters like period and
> >> duty factor without first to disable pwm. Since pwm code
> >> is supported by more than one SoC add allow_runtime_cfg
> >> parameter to atmel_pwm_chip data structure. This will be
> >> filled statically for every SoC, saved in pwm specific
> >> structure at probing time and checked while configuring
> >> the device. Based on this, pwm clock will not be
> >> enabled/disabled while configuring if it still enabled.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> >> ---
> >>  drivers/pwm/pwm-atmel.c | 24 ++++++++++++++++++------
> >>  1 file changed, 18 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> >> index 4406639..9e1dece 100644
> >> --- a/drivers/pwm/pwm-atmel.c
> >> +++ b/drivers/pwm/pwm-atmel.c
> >> @@ -68,6 +68,8 @@ struct atmel_pwm_chip {
> >>  
> >>  	void (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
> >>  		       unsigned long dty, unsigned long prd);
> >> +
> >> +	bool allow_runtime_cfg;
> >>  };
> >>  
> >>  static inline struct atmel_pwm_chip *to_atmel_pwm_chip(struct pwm_chip *chip)
> >> @@ -114,7 +116,8 @@ static int atmel_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> >>  	u32 val;
> >>  	int ret;
> >>  
> >> -	if (pwm_is_enabled(pwm) && (period_ns != pwm_get_period(pwm))) {
> >> +	if (!atmel_pwm->allow_runtime_cfg &&
> >> +	    pwm_is_enabled(pwm) && (period_ns != pwm_get_period(pwm))) {
> >>  		dev_err(chip->dev, "cannot change PWM period while enabled\n");
> >>  		return -EBUSY;
> >>  	}
> >> @@ -139,10 +142,12 @@ static int atmel_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> >>  	do_div(div, period_ns);
> >>  	dty = prd - div;
> >>  
> >> -	ret = clk_enable(atmel_pwm->clk);
> >> -	if (ret) {
> >> -		dev_err(chip->dev, "failed to enable PWM clock\n");
> >> -		return ret;
> >> +	if (!pwm_is_enabled(pwm)) {
> >> +		ret = clk_enable(atmel_pwm->clk);
> >> +		if (ret) {
> >> +			dev_err(chip->dev, "failed to enable PWM clock\n");
> >> +			return ret;
> >> +		}
> >>  	}
> >>    
> > It is probably worth switching to atomic PWM instead of changing this
> > function. This would simplify the whole driver.  
> I was thinking to switch to atomic PWM in a future patch.

Actually, I think it's better to do it before adding support for the
new IP (even before patch 1), but maybe I'm the only one to think
so :-).

Note that switching to the atomic API is not a big (actually, it should
even simplify the code).

Regards,

Boris
