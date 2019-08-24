From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/3] pwm: bcm2835: suppress error message during deferred
 probe
Date: Sat, 24 Aug 2019 11:30:32 +0200
Message-ID: <20190824093032.cunkmukx73vl4hy3@pengutronix.de>
References: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
 <1566630445-4599-4-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1566630445-4599-4-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>
Cc: linux-pwm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Sat, Aug 24, 2019 at 09:07:25AM +0200, Stefan Wahren wrote:
> This suppresses error messages in case the PWM clock isn't ready yet.
> =

> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/pwm/pwm-bcm2835.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
> index 2c82386..ce362be 100644
> --- a/drivers/pwm/pwm-bcm2835.c
> +++ b/drivers/pwm/pwm-bcm2835.c
> @@ -153,7 +153,10 @@ static int bcm2835_pwm_probe(struct platform_device =
*pdev)
> =

>  	pc->clk =3D devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(pc->clk)) {
> -		dev_err(&pdev->dev, "clock not found: %ld\n", PTR_ERR(pc->clk));
> +		if (PTR_ERR(pc->clk) !=3D -EPROBE_DEFER) {
> +			dev_err(&pdev->dev, "clock not found: %ld\n",
> +				PTR_ERR(pc->clk));
> +		}
>  		return PTR_ERR(pc->clk);
>  	}

I would have used:

	if (IS_ERR(pc->clk)) {
		int err =3D PTR_ERR(pc->clk);
		if (err !=3D -EPROBE_DEFER)
			dev_err(&pdev->dev, "clock not found: %d\n", err);

		return err;
	}

This calculates the error code only once and make the dev_err line short
enough to not make it necessary to add a line break.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
