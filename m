From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3] clk: Add PWM clock driver
Date: Fri, 12 Dec 2014 10:53:56 +0100
Message-ID: <1418378036.3172.3.camel@pengutronix.de>
References: <1418138392-17081-1-git-send-email-p.zabel@pengutronix.de>
		 <54872810.7000700@elproma.com.pl>
	 <1418223593.3258.10.camel@pengutronix.de> <5489C385.9090305@elproma.com.pl>
	 <5489CE19.8080108@elproma.com.pl> <548AAE51.7060507@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <548AAE51.7060507-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Janusz =?UTF-8?Q?U=C5=BCycki?= <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Janusz,

Am Freitag, den 12.12.2014, 09:58 +0100 schrieb Janusz U=C5=BCycki:
> Hi Philipp,
>=20
> It moved .enable to .prepare which can sleep and it works
> without any bug.
> The dirty fix:
>   const struct clk_ops clk_pwm_ops =3D {
> -       .enable =3D clk_pwm_enable,
> -       .disable =3D clk_pwm_disable,
> +       .prepare =3D clk_pwm_enable,
> +       .unprepare =3D clk_pwm_disable,
>          .recalc_rate =3D clk_pwm_recalc_rate,
>   };
>=20
> What do you think about?

Thanks! Since the pwm API does not give any guarantees that
pwm_enable/disable may be called from atomic context, I think this
change is correct. The PWM documentation says:

   "Currently the PWM core does not enforce any locking to pwm_enable()=
,
    pwm_disable() and pwm_config(), so the calling context is currently
    driver specific. This is an issue derived from the former barebone
    API and should be fixed soon."

clk_enable should support reentrancy, but calling clk_prepare_enable
inside a clk_enable callback is not going to work.

regards
Philipp

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
