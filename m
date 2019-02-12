From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] pwm: hibvt: Add hi3559v100 support
Date: Tue, 12 Feb 2019 15:28:50 +0100
Message-ID: <20190212142850.iwgi4n6v6oep4oin@pengutronix.de>
References: <20190212094927.5900-1-m.othacehe@gmail.com>
 <20190212094927.5900-2-m.othacehe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212094927.5900-2-m.othacehe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Feb 12, 2019 at 10:49:27AM +0100, Mathieu Othacehe wrote:
> Add support for hi3559v100-shub-pwm and hisilicon,hi3559v100-pwm
> platforms. They require a special quirk: pwm has to be enabled again
> to force duty_cycle refresh.
> 
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
> ---
>  drivers/pwm/pwm-hibvt.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
> index 27c107e78d59..bf33aa24433c 100644
> --- a/drivers/pwm/pwm-hibvt.c
> +++ b/drivers/pwm/pwm-hibvt.c
> @@ -49,6 +49,7 @@ struct hibvt_pwm_chip {
>  	struct clk *clk;
>  	void __iomem *base;
>  	struct reset_control *rstc;
> +	bool quirk_force_enable;
>  };
>  
>  struct hibvt_pwm_soc {
> @@ -56,6 +57,7 @@ struct hibvt_pwm_soc {
>  };
>  
>  static const struct hibvt_pwm_soc pwm_soc[2] = {
> +	{ .num_pwms = 2 },
>  	{ .num_pwms = 4 },
>  	{ .num_pwms = 8 },

The members of this struct are used as of-data (in struct
of_device_id::data below). When looking at the usage:

	{ .compatible = "hisilicon,hi3516cv300-pwm", .data = &pwm_soc[1] },
	{ .compatible = "hisilicon,hi3519v100-pwm", .data = &pwm_soc[2] },
	{ .compatible = "hisilicon,hi3559v100-shub-pwm", .data = &pwm_soc[2] },
	{ .compatible = "hisilicon,hi3559v100-pwm", .data = &pwm_soc[0] },

this isn't exactly easy to understand. I would prefer to do it as
follows:

	static const struct hibvt_pwm_soc hi3516cv300_soc_info = {
		.num_pwms = 2,
	};
	...

	static const struct of_device_id hibvt_pwm_of_match[] = {
		{ .compatible = "hisilicon,hi3516cv300-pwm", .data = &hi3516cv300_soc_info },
		...
	};

Then you could also add a member to hibvt_pwm_soc to signal if that
force_enable quirk is necessary and would not need to use
of_device_is_compatible() to determine this. The result is that you have
a description of all relevant differences in a single place.

@Thierry: Also this is yet another driver instance where a num-pwms
property would simplify the driver because up to before this patch this
was the only difference between the different variants.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
