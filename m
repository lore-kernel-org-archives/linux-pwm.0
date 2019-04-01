From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH] pwm: imx27: use devm_platform_ioremap_resource() to
 simplify code
Date: Mon, 1 Apr 2019 13:30:19 +0530
Message-ID: <4d10cb49-baf0-dc59-6df2-62174bb06931@codeaurora.org>
References: <1554095960-15638-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1554095960-15638-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Anson Huang <anson.huang@nxp.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org


On 4/1/2019 10:54 AM, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/pwm/pwm-imx27.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 8061306..434a351 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -291,7 +291,6 @@ MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
>   static int pwm_imx27_probe(struct platform_device *pdev)
>   {
>   	struct pwm_imx27_chip *imx;
> -	struct resource *r;
>   
>   	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
>   	if (imx == NULL)
> @@ -326,8 +325,7 @@ static int pwm_imx27_probe(struct platform_device *pdev)
>   	imx->chip.of_xlate = of_pwm_xlate_with_flags;
>   	imx->chip.of_pwm_n_cells = 3;
>   
> -	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	imx->mmio_base = devm_ioremap_resource(&pdev->dev, r);
> +	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(imx->mmio_base))
>   		return PTR_ERR(imx->mmio_base);
>   
