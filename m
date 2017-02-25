From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 2/3] pwm: sunxi: Add A64 support
Date: Sat, 25 Feb 2017 16:53:03 +0800
Message-ID: <CAGb2v67OaUps1yffyZ8pBvMwbAU+6WC2pPkt25e5i+SYU1nrDw@mail.gmail.com>
References: <20170225074216.64868-1-icenowy@aosc.xyz> <20170225074216.64868-2-icenowy@aosc.xyz>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBB4MYXCQKGQEK2SHRHY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170225074216.64868-2-icenowy-ymACFijhrKM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Sat, Feb 25, 2017 at 3:42 PM, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org> wrote:
> A64 PWM controller has same register layout as sun4i driver, so it works
> by adding A64 specific data.
>
> Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
> ---
>  drivers/pwm/pwm-sun4i.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 1284ffa05921..ca3431e03fb8 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -290,6 +290,12 @@ static const struct sun4i_pwm_data sun4i_pwm_data_h3 = {
>         .npwm = 1,
>  };
>
> +static const struct sun4i_pwm_data sun4i_pwm_data_a64 = {
> +       .has_prescaler_bypass = true,
> +       .has_rdy = true,
> +       .npwm = 1,
> +};
> +

This seems to be tha same as the H3. Any differences between the
H3 and A64? Otherwise please just use that compatible.

ChenYu

>  static const struct of_device_id sun4i_pwm_dt_ids[] = {
>         {
>                 .compatible = "allwinner,sun4i-a10-pwm",
> @@ -307,6 +313,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
>                 .compatible = "allwinner,sun8i-h3-pwm",
>                 .data = &sun4i_pwm_data_h3,
>         }, {
> +               .compatible = "allwinner,sun50i-a64-pwm",
> +               .data = &sun4i_pwm_data_a64,
> +       }, {
>                 /* sentinel */
>         },
>  };
> --
> 2.11.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> For more options, visit https://groups.google.com/d/optout.
