From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH] pwm: Add clk enable/disable for pwm_samsung_enable/pwm_samsung_disable
Date: Wed, 15 Apr 2015 15:47:43 +0530
Message-ID: <CANAwSgSP2R66DY000SAqh-yG=y=5_zOktt8dHFjbogdmDm3Hmw@mail.gmail.com>
References: <1429034708-4537-1-git-send-email-linux.amoon@gmail.com>
	<1429086847.22057.159.camel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1429086847.22057.159.camel@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

hi Sjoerd,

Are you referring to handle of polarity
(PWM_POLARITY_NORMAL/PWM_POLARITY_INVERSED) during enable and disable.

How can I analyses if the clock is high and low.

-Anand Moon

On 15 April 2015 at 14:04, Sjoerd Simons <sjoerd.simons@collabora.co.uk> wrote:
> On Wed, 2015-04-15 at 03:35 +0930, Anand Moon wrote:
>> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
>> index 3e9b583..b579753 100644
>> --- a/drivers/pwm/pwm-samsung.c
>> +++ b/drivers/pwm/pwm-samsung.c
>> @@ -247,6 +247,7 @@ static int pwm_samsung_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>>       tcon &= ~TCON_MANUALUPDATE(tcon_chan);
>>       tcon |= TCON_START(tcon_chan) | TCON_AUTORELOAD(tcon_chan);
>>       writel(tcon, our_chip->base + REG_TCON);
>> +     clk_prepare_enable(our_chip->base_clk);
>>
>>       spin_unlock_irqrestore(&samsung_pwm_lock, flags);
>>
>> @@ -265,6 +266,7 @@ static void pwm_samsung_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>>       tcon = readl(our_chip->base + REG_TCON);
>>       tcon &= ~TCON_AUTORELOAD(tcon_chan);
>>       writel(tcon, our_chip->base + REG_TCON);
>> +     clk_disable_unprepare(our_chip->base_clk);
>>
>>       spin_unlock_irqrestore(&samsung_pwm_lock, flags);
>>  }
>
> As far as i can tell this code doesn't have any effect.
>
> clk_enable is refcounted, so the clock will stay enabled for as long as
> the driver is loaded (as it's enabled in _probe). Your code above just
> raises and lowers the clocks enabled refcount, but won't actually ever
> cause it to be disabled.
>
> With respect to trying to disabling the clocks on pwm_disable, that will
> need some more work to ensure the output signal has the expected level
> when you turn of the clock. Specifically, when disabling from a non-100%
> duty state the driver relies on the PWM turning the output signal low at
> the end of a duty cycle. However if you turn off the clock at the start
> of a duty cycle while the output signal is still high it will
> unexpectedly remain high.
>
>
> --
> Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> Collabora Ltd.
