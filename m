From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/6] pwm: sun4i: Add a quirk for bus clock
Date: Mon, 29 Jul 2019 08:38:25 +0200
Message-ID: <20190729063825.wxfky6nswcru26g7@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-4-jernej.skrabec@siol.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190726184045.14669-4-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: thierry.reding@gmail.com, mripard@kernel.org, wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

Hello,

On Fri, Jul 26, 2019 at 08:40:42PM +0200, Jernej Skrabec wrote:
> H6 PWM core needs bus clock to be enabled in order to work.
> 
> Add a quirk for it.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/pwm/pwm-sun4i.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 1b7be8fbde86..7d3ac3f2dc3f 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -72,6 +72,7 @@ static const u32 prescaler_table[] = {
>  };
>  
>  struct sun4i_pwm_data {
> +	bool has_bus_clock;
>  	bool has_prescaler_bypass;
>  	bool has_reset;
>  	unsigned int npwm;
> @@ -79,6 +80,7 @@ struct sun4i_pwm_data {
>  
>  struct sun4i_pwm_chip {
>  	struct pwm_chip chip;
> +	struct clk *bus_clk;
>  	struct clk *clk;
>  	struct reset_control *rst;
>  	void __iomem *base;
> @@ -382,6 +384,16 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  		reset_control_deassert(pwm->rst);
>  	}
>  
> +	if (pwm->data->has_bus_clock) {
> +		pwm->bus_clk = devm_clk_get(&pdev->dev, "bus");

Similar to my suggestion in patch 2: I'd use devm_clk_get_optional() and
drop struct sun4i_pwm_data::has_bus_clock.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
