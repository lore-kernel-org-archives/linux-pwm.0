From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 15/32] pwm: rockchip: convert to
 devm_platform_ioremap_resource
Date: Mon, 30 Dec 2019 09:39:38 +0100
Message-ID: <3343090.K8KIS9te04@phil>
References: <20191229080610.7597-1-tiny.windzz@gmail.com>
 <20191229080610.7597-15-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191229080610.7597-15-tiny.windzz@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, thierry.reding@gmail.com, linux-riscv@lists.infradead.org, festevam@gmail.com, f.fainelli@gmail.com, shc_work@mail.ru, khilman@baylibre.com, wens@csie.org, jonathanh@nvidia.com, linux-rockchip@lists.infradead.org, ludovic.desroches@microchip.com, bcm-kernel-feedback-list@broadcom.com, linux-imx@nxp.com, slemieux.tyco@gmail.com, linux-pwm@vger.kernel.org, rjui@broadcom.com, s.hauer@pengutronix.de, u.kleine-koenig@pengutronix.de, mripard@kernel.org, vz@mleia.com, linux-mediatek@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, paul.walmsley@sifive.com, matthias.bgg@gmail.com, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, sbranden@broadcom.com, linux@prisktech.co.nz, palmer@dabbelt.com, kernel@pengutronix.de, shawnguo@kernel.org, claudiu.beznea@micro
List-Id: linux-pwm@vger.kernel.org

Am Sonntag, 29. Dezember 2019, 09:05:53 CET schrieb Yangtao Li:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


> ---
>  drivers/pwm/pwm-rockchip.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index 73352e6fbccb..f0549b82338d 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -292,7 +292,6 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *id;
>  	struct rockchip_pwm_chip *pc;
> -	struct resource *r;
>  	int ret, count;
>  
>  	id = of_match_device(rockchip_pwm_dt_ids, &pdev->dev);
> @@ -303,8 +302,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>  	if (!pc)
>  		return -ENOMEM;
>  
> -	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	pc->base = devm_ioremap_resource(&pdev->dev, r);
> +	pc->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pc->base))
>  		return PTR_ERR(pc->base);
>  
> 
