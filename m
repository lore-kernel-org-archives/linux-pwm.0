From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4 3/7] pwm: sun4i: Add an optional probe for bus clock
Date: Wed, 13 Nov 2019 09:35:24 +0100
Message-ID: <20191113083524.aqtf2ed4ltuiazjg@pengutronix.de>
References: <20191108084517.21617-1-peron.clem@gmail.com>
 <20191108084517.21617-4-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191108084517.21617-4-peron.clem@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>, devicetree@vger.kernel.org, linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel <pza@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Nov 08, 2019 at 09:45:13AM +0100, Cl=E9ment P=E9ron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> =

> H6 PWM core needs bus clock to be enabled in order to work.
> =

> Add an optional probe for it and a fallback for previous
> bindings without name on module clock.
> =

> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 48 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 2b9a2a78591f..a10022d6c0fd 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -78,6 +78,7 @@ struct sun4i_pwm_data {
>  =

>  struct sun4i_pwm_chip {
>  	struct pwm_chip chip;
> +	struct clk *bus_clk;
>  	struct clk *clk;
>  	struct reset_control *rst;
>  	void __iomem *base;
> @@ -363,9 +364,38 @@ static int sun4i_pwm_probe(struct platform_device *p=
dev)
>  	if (IS_ERR(pwm->base))
>  		return PTR_ERR(pwm->base);
>  =

> -	pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(pwm->clk))
> +	/* Get all clocks and reset line */
> +	pwm->clk =3D devm_clk_get_optional(&pdev->dev, "mod");
> +	if (IS_ERR(pwm->clk)) {
> +		if (PTR_ERR(pwm->rst) !=3D -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "get clock failed %pe\n",
> +				pwm->clk);
>  		return PTR_ERR(pwm->clk);
> +	}
> +
> +	/*
> +	 * Fallback for old dtbs with a single clock and no name.
> +	 * If a parent has a clock-name called "mod" whereas the
> +	 * current node is unnamed the clock reference will be
> +	 * incorrectly obtained and will not go into this fallback.

For me "old dtbs" suggests that today a device tree should have a "mod"
clock. Is this true also for machines other than H6? And I'd put the
comment before the acquisition of the "mod" clock. Something like:

	/*
	 * A clock called "mod" is only required on H6 (for now) and on
	 * other SoCs we expect an unnamed clock. So we request "mod"
	 * first (and ignore the corner case that a parent provides a
	 * "mod" clock) and if this is not found we fall back to the
	 * first clock of the PWM.
	 */

> +	 */
> +	if (!pwm->clk) {
> +		pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> +		if (IS_ERR(pwm->clk)) {
> +			if (PTR_ERR(pwm->rst) !=3D -EPROBE_DEFER)
> +				dev_err(&pdev->dev, "get clock failed %pe\n",
> +					pwm->clk);
> +			return PTR_ERR(pwm->clk);
> +		}
> +	}
> +
> +	pwm->bus_clk =3D devm_clk_get_optional(&pdev->dev, "bus");
> +	if (IS_ERR(pwm->bus_clk)) {
> +		if (PTR_ERR(pwm->rst) !=3D -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "get bus_clock failed %pe\n",
> +				pwm->bus_clk);
> +		return PTR_ERR(pwm->bus_clk);
> +	}
>  =

>  	pwm->rst =3D devm_reset_control_get_optional_shared(&pdev->dev, NULL);
>  	if (IS_ERR(pwm->rst)) {
> @@ -382,6 +412,17 @@ static int sun4i_pwm_probe(struct platform_device *p=
dev)
>  		return ret;
>  	}
>  =

> +	/*
> +	 * We're keeping the bus clock on for the sake of simplicity.
> +	 * Actually it only needs to be on for hardware register
> +	 * accesses.
> +	 */
> +	ret =3D clk_prepare_enable(pwm->bus_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Cannot prepare and enable bus_clk\n");
> +		goto err_bus;
> +	}
> +

Would it make sense to split this patch into "Prefer "mod" clock to
(unnamed) clock" and "Introduce optional bus clock"?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
