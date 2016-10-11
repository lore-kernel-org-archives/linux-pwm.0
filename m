From: LABBE Corentin <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/5] pwm: Add Allwinner A31 SoC support
Date: Tue, 11 Oct 2016 11:02:01 +0200
Message-ID: <20161011090201.GA5736@Red>
References: <20161011063449.54775-1-icenowy@aosc.xyz>
 <20161011063449.54775-2-icenowy@aosc.xyz>
Reply-To: clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBD7YLCN32UNBBDOV6K7QKGQETGOIYFA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20161011063449.54775-2-icenowy-ymACFijhrKM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hello

I have a minor comment below

On Tue, Oct 11, 2016 at 02:34:46PM +0800, Icenowy Zheng wrote:
> This adds a generic PWM framework driver for the PWM controller found
> on Allwinner A31 and A31s SoCs.
> 
> The PWM controller is different with other Allwinner SoCs, with a
> control register per channel (in other SoCs the control register is
> shared), and each channel are allocated 16 bytes of address (but only 8
> bytes are used.)
> 
> In order to use the driver for all channels, device nodes should be
> created per channel.
> 
> Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
> ---
>  drivers/pwm/Kconfig     |  10 ++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-sun6i.c | 323 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 334 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sun6i.c
> 
> +
> +static int sun6i_pwm_probe(struct platform_device *pdev)
> +{
> +	struct sun6i_pwm_chip *pwm;
> +	struct resource *res;
> +	u32 val;
> +	int ret;
> +	const struct of_device_id *match;
> +
> +	match = of_match_device(sun6i_pwm_dt_ids, &pdev->dev);

match is not used after.

Regards

Corentin Labbe
