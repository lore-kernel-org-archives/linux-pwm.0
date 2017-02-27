From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 2/9] pwm: sunxi: Use regmap fields for
 bit operations.
Date: Mon, 27 Feb 2017 10:28:14 +0100
Message-ID: <20170227092814.7g5fnfvew3hcqefl@lukather>
References: <1487914876-8594-1-git-send-email-lis8215@gmail.com>
 <1487914876-8594-3-git-send-email-lis8215@gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u2tohkwig3p2rtor"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBL7CZ7CQKGQERFS2RSI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1487914876-8594-3-git-send-email-lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--u2tohkwig3p2rtor
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Fri, Feb 24, 2017 at 08:41:09AM +0300, lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> +static const struct reg_field
> +sun4i_pwm_regfields[SUN4I_MAX_PWM_CHANNELS][NUM_FIELDS] = {
> +	{
> +		[FIELD_PRESCALER]  = REG_FIELD(PWM_CTRL_REG,  0,  3),
> +		[FIELD_POLARITY]   = REG_FIELD(PWM_CTRL_REG,  5,  5),
> +		[FIELD_CLK_GATING] = REG_FIELD(PWM_CTRL_REG,  6,  6),
> +		[FIELD_READY]      = REG_FIELD(PWM_CTRL_REG, 28, 28),
> +	},
> +	{
> +		[FIELD_PRESCALER]  = REG_FIELD(PWM_CTRL_REG, 15, 18),
> +		[FIELD_POLARITY]   = REG_FIELD(PWM_CTRL_REG, 20, 20),
> +		[FIELD_CLK_GATING] = REG_FIELD(PWM_CTRL_REG, 21, 21),
> +		[FIELD_READY]      = REG_FIELD(PWM_CTRL_REG, 29, 29),
> +	},
> +};
> +

I'm not sure you need something that complicated.

What about something like:

struct sun4i_chan_fields {
       struct reg_field	prescaler;
       struct reg_field	polarity;
       struct reg_field	clk_gating;
       struct reg_field	ready;
};

And in sun4i_pwm_data add an array of this struct.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--u2tohkwig3p2rtor--
