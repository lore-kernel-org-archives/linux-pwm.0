From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 2/5] pwm: sun4i: Add support for PWM
 controller on sun6i SoCs
Date: Wed, 12 Oct 2016 15:30:07 +0800
Message-ID: <CAGb2v65P7SQyEv+b0mU_FA=CQxy7qX9h7HE4NivqjZ-ZBh94ww@mail.gmail.com>
References: <20161012042059.40015-1-icenowy@aosc.xyz> <20161012042059.40015-2-icenowy@aosc.xyz>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBF6N667QKGQEDFIOXPA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161012042059.40015-2-icenowy-ymACFijhrKM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi,

On Wed, Oct 12, 2016 at 12:20 PM, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org> wrote:
> The PWM controller in A31 is different with other Allwinner SoCs, with a
> control register per channel (in other SoCs the control register is
> shared), and each channel are allocated 16 bytes of address (but only 8
> bytes are used.). The register map in one channel is just like a
> single-channel A10 PWM controller, however, A31 have a different
> prescaler table than other SoCs.
>
> In order to use the driver for all 4 channels, device nodes should be
> created per channel.

I think Maxime wants you to support the different register offsets
in this driver, and have all 4 channels in the same device (node).

ChenYu


> Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
> ---
>  drivers/pwm/pwm-sun4i.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 03a99a5..3e93bdf 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -46,7 +46,7 @@
>
>  #define BIT_CH(bit, chan)      ((bit) << ((chan) * PWMCH_OFFSET))
>
> -static const u32 prescaler_table[] = {
> +static const u32 prescaler_table_a10[] = {
>         120,
>         180,
>         240,
> @@ -65,10 +65,30 @@ static const u32 prescaler_table[] = {
>         0, /* Actually 1 but tested separately */
>  };
>
> +static const u32 prescaler_table_a31[] = {
> +       1,
> +       2,
> +       4,
> +       8,
> +       16,
> +       32,
> +       64,
> +       0,
> +       0,
> +       0,
> +       0,
> +       0,
> +       0,
> +       0,
> +       0,
> +       0,
> +};
> +
>  struct sun4i_pwm_data {
>         bool has_prescaler_bypass;
>         bool has_rdy;
>         unsigned int npwm;
> +       const u32 *prescaler_table;
>  };
>
>  struct sun4i_pwm_chip {
> @@ -100,6 +120,7 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>                             int duty_ns, int period_ns)
>  {
>         struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
> +       const u32 *prescaler_table = sun4i_pwm->data->prescaler_table;
>         u32 prd, dty, val, clk_gate;
>         u64 clk_rate, div = 0;
>         unsigned int prescaler = 0;
> @@ -264,24 +285,35 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a10 = {
>         .has_prescaler_bypass = false,
>         .has_rdy = false,
>         .npwm = 2,
> +       .prescaler_table = prescaler_table_a10,
>  };
>
>  static const struct sun4i_pwm_data sun4i_pwm_data_a10s = {
>         .has_prescaler_bypass = true,
>         .has_rdy = true,
>         .npwm = 2,
> +       .prescaler_table = prescaler_table_a10,
>  };
>
>  static const struct sun4i_pwm_data sun4i_pwm_data_a13 = {
>         .has_prescaler_bypass = true,
>         .has_rdy = true,
>         .npwm = 1,
> +       .prescaler_table = prescaler_table_a10,
>  };
>
>  static const struct sun4i_pwm_data sun4i_pwm_data_a20 = {
>         .has_prescaler_bypass = true,
>         .has_rdy = true,
>         .npwm = 2,
> +       .prescaler_table = prescaler_table_a10,
> +};
> +
> +static const struct sun4i_pwm_data sun4i_pwm_data_a31 = {
> +       .has_prescaler_bypass = false,
> +       .has_rdy = true,
> +       .npwm = 1,
> +       .prescaler_table = prescaler_table_a31,
>  };
>
>  static const struct of_device_id sun4i_pwm_dt_ids[] = {
> @@ -298,6 +330,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
>                 .compatible = "allwinner,sun7i-a20-pwm",
>                 .data = &sun4i_pwm_data_a20,
>         }, {
> +               .compatible = "allwinner,sun6i-a31-pwm",
> +               .data = &sun4i_pwm_data_a31
> +       }, {
>                 /* sentinel */
>         },
>  };
> --
> 2.10.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> For more options, visit https://groups.google.com/d/optout.
