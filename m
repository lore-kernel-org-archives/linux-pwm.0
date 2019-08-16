From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 1/10] pwm: mediatek: add a property "num-pwms"
Date: Fri, 16 Aug 2019 09:34:48 +0200
Message-ID: <20190816073448.37cb7imxnnjdwlix@pengutronix.de>
References: <1565940088-845-1-git-send-email-sam.shih@mediatek.com>
 <1565940088-845-2-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565940088-845-2-git-send-email-sam.shih@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Shih <sam.shih@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Aug 16, 2019 at 03:21:19PM +0800, Sam Shih wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
> 
> This adds a property "num-pwms" to avoid having an endless
> list of compatibles with no differences for the same driver.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index eb6674ce995f..f9d67fb66adb 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -55,7 +55,7 @@ static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
>  };
>  
>  struct mtk_pwm_platform_data {
> -	unsigned int num_pwms;
> +	unsigned int fallback_npwms;
>  	bool pwm45_fixup;
>  	bool has_clks;
>  };
> @@ -226,27 +226,36 @@ static const struct pwm_ops mtk_pwm_ops = {
>  
>  static int mtk_pwm_probe(struct platform_device *pdev)
>  {
> -	const struct mtk_pwm_platform_data *data;
> +	struct device_node *np = pdev->dev.of_node;
>  	struct mtk_pwm_chip *pc;
>  	struct resource *res;
> -	unsigned int i;
> +	unsigned int i, npwms;
>  	int ret;
>  
>  	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
>  	if (!pc)
>  		return -ENOMEM;
>  
> -	data = of_device_get_match_data(&pdev->dev);
> -	if (data == NULL)
> -		return -EINVAL;
> -	pc->soc = data;
> +	pc->soc = of_device_get_match_data(&pdev->dev);

Droping the check for of_device_get_match_data returning non-NULL is
unrelated to the official patch's topic.

Other than that I like this patch.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
