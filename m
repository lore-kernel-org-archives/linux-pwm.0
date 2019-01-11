From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/3] drivers: pwm: pwm-bcm-kona: Add pwm-kona-v2 support
Date: Fri, 11 Jan 2019 14:51:25 +0100
Message-ID: <20190111135125.GC1895@lunn.ch>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547184076-20521-3-git-send-email-sheetal.tigadoli@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547184076-20521-3-git-send-email-sheetal.tigadoli@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-pwm@vger.kernel.org, Praveen Kumar B <praveen.b@broadcom.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Jan 11, 2019 at 10:51:15AM +0530, Sheetal Tigadoli wrote:
> From: Praveen Kumar B <praveen.b@broadcom.com>
> 
> Add support for new version of pwm-kona.
> Add support to make PWM changes configured and stable.
> 
> Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm-kona.c | 128 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 98 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
> index 09a95ae..2b44ad8 100644
> --- a/drivers/pwm/pwm-bcm-kona.c
> +++ b/drivers/pwm/pwm-bcm-kona.c
> @@ -45,30 +45,39 @@
>   *    high or low depending on its state at that exact instant.
>   */
>  
> -#define PWM_CONTROL_OFFSET			(0x00000000)
> +#define PWM_CONTROL_OFFSET			0x00000000
>  #define PWM_CONTROL_SMOOTH_SHIFT(chan)		(24 + (chan))
>  #define PWM_CONTROL_TYPE_SHIFT(chan)		(16 + (chan))
>  #define PWM_CONTROL_POLARITY_SHIFT(chan)	(8 + (chan))
>  #define PWM_CONTROL_TRIGGER_SHIFT(chan)		(chan)
>  
> -#define PRESCALE_OFFSET				(0x00000004)
> +#define PRESCALE_OFFSET				0x00000004
>  #define PRESCALE_SHIFT(chan)			((chan) << 2)
>  #define PRESCALE_MASK(chan)			(0x7 << PRESCALE_SHIFT(chan))
> -#define PRESCALE_MIN				(0x00000000)
> -#define PRESCALE_MAX				(0x00000007)
> +#define PRESCALE_MIN				0x00000000
> +#define PRESCALE_MAX				0x00000007

Hi Praveen

These changes are unrelated to adding support for a new PWM. So
ideally they should be in a separate patch.

> +static int kona_pwmc_wait_stable(struct pwm_chip *chip, unsigned int chan,
> +				 unsigned int kona_ver)
> +{
> +	struct kona_pwmc *kp = to_kona_pwmc(chip);
> +	unsigned int value;
> +	unsigned int count = PWM_MONITOR_TIMEOUT_US * 1000;
> +
> +	switch (kona_ver) {
> +	case KONA_PWM_V1:
> +		/*
> +		 * There must be a min 400ns delay between clearing trigger and
> +		 * settingit. Failing to do this may result in no PWM signal.
> +		 */
> +		ndelay(400);
> +		return 0;
> +	case KONA_PWM_V2:
> +		do {
> +			value = readl(kp->base + PWM_MONITOR_OFFSET);
> +			if (!(value & (BIT(chan))))
> +				return 0;
> +			ndelay(1);
> +		} while (count--);

You can probably use readl_poll_timeout() here.

    Andrew
