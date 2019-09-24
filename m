From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH] pwm: pwm-imx27: Use 'dev' instead of dereferencing it
 repeatedly
Date: Tue, 24 Sep 2019 09:46:20 +0000
Message-ID: <6cfb1595992b46dc884731555e6f0334@AcuMS.aculab.com>
References: <1569315593-769-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1569315593-769-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Anson Huang' <Anson.Huang@nxp.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Linux-imx@nxp.com" <Linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org

From: Anson Huang
> Sent: 24 September 2019 10:00
> Add helper variable dev = &pdev->dev to simply the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/pwm/pwm-imx27.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 434a351..3afee29 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -290,27 +290,28 @@ MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
> 
>  static int pwm_imx27_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct pwm_imx27_chip *imx;
> 
> -	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
> +	imx = devm_kzalloc(dev, sizeof(*imx), GFP_KERNEL);
>  	if (imx == NULL)
>  		return -ENOMEM;
> 
>  	platform_set_drvdata(pdev, imx);
> 
> -	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> +	imx->clk_ipg = devm_clk_get(dev, "ipg");
>  	if (IS_ERR(imx->clk_ipg)) {
> -		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
> +		dev_err(dev, "getting ipg clock failed with %ld\n",
>  				PTR_ERR(imx->clk_ipg));
>  		return PTR_ERR(imx->clk_ipg);
>  	}
> 
> -	imx->clk_per = devm_clk_get(&pdev->dev, "per");
> +	imx->clk_per = devm_clk_get(dev, "per");
>  	if (IS_ERR(imx->clk_per)) {
>  		int ret = PTR_ERR(imx->clk_per);
> 
>  		if (ret != -EPROBE_DEFER)
> -			dev_err(&pdev->dev,
> +			dev_err(dev,
>  				"failed to get peripheral clock: %d\n",
>  				ret);

Hopefully the compiler will optimise this back otherwise you've added another
local variable which may cause spilling to stack.
For a setup function it probably doesn't matter, but in general it might
have a small negative performance impact.

In any case this doesn't shorten any lines enough to remove line-wrap
and using &pdev->dev is really one less variable to mentally track
when reading the code.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
