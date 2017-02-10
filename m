From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 1/4] ARM: pwm: sun4i: unification of
 register operations for support sun6i.
Date: Fri, 10 Feb 2017 09:38:04 +0100
Message-ID: <20170210083804.woe3bbc6b6c3vsp3@lukather>
References: <1486489846-662-1-git-send-email-lis8215@gmail.com>
 <1486489846-662-2-git-send-email-lis8215@gmail.com>
 <20170208075219.oo234d5zartzmzsg@lukather>
 <CAKNVLfaYoPf-b-mGc0eSmmAk0QPhMCRt5aT5Z3JBcfKhridWDA@mail.gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3bgobrdjg5sbf3zk"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBB3PX6XCAKGQERGB32WY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAKNVLfaYoPf-b-mGc0eSmmAk0QPhMCRt5aT5Z3JBcfKhridWDA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?utf-8?B?0JLQvtC70LrQvtCyINCh0LXRgNCz0LXQuQ==?= <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--3bgobrdjg5sbf3zk
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 08, 2017 at 07:41:55PM +0300, =D0=92=D0=BE=D0=BB=D0=BA=D0=BE=D0=
=B2 =D0=A1=D0=B5=D1=80=D0=B3=D0=B5=D0=B9 wrote:
> Hello all,
>=20
> >> This patch not introduce new features, just prepare code for
> >> adding sun6i PWM driver in next commits.
> >>
> >> A31 SoC have a different map of PWM registers than others ASoCs,
> >> but register bits purposes are very similar.
> >>
> >> This patch introduce set of register access routines, which
> >> are common for existing in driver ASoCs:
> >>  - ctl_rdy   - checks the ready bit of specified PWM channel,
> >>  - ctl_read  - reads value from control register of specified PWM
> channel,
> >>  - ctl_write - writes significant bits to control register of specifie=
d
> PWM channel,
> >>  - prd_read  - reads value from period register of specified PWM chann=
el,
> >>  - prd_write - writes value to period register of specified PWM channe=
l.
> >> Driver code redesigned to use the new routines.
> >
> > Why don't you use regmap for that?
>=20
> First of all, i'm newbie and its my first patchset. I just remake
> what i see in the driver. I even don't suspect about use regmap
> here.

Don't worry, a review is here to point where things could be better,
which doesn't mean that you did wrong :)

> Second thing - i can't test these driver on all existing sunxi SoCs,
> i have only A31 and A20 based boards where only pwm0 is
> accessible. Huge redesign cause bigger chance to make a mistake.

Don't worry about that either. We have a good number of platforms
using the PWMs already. If there's something broken at some point,
we'll catch it as well.

> If you think regmap solution is a must, then i will do that. This
> will be a good experience for me.

Yes, this really should cover what you're trying to do here,
especially reg_field.

You can have a look at drivers/reset/sti/reset-syscfg.c if you want to
have a look at a rather simple driver using it.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--3bgobrdjg5sbf3zk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYnXvoAAoJEBx+YmzsjxAgZsgQAIHsVd6K68qpA61kXVKKYTRW
klCiGO9ubW7LzfngaW/ghhs4tWSN101DzPNnHEqdajvqcIL3I+fmHia1OFHPMZ3w
Sib4JWWYjGg50TbAYIzlBIjuBSsGqZy040CLqTdEeBl4DBjbCiRWA330hndvhnE9
SK0ohV29OugH9cATZAoRBGNuoCH3mgdWa9Z2wcRCxvZ64QinzjE+aG1gkvFYQOfl
Wd7MnznuMk0f6R0o43lbc8/fueBGKVOGQY2KS2Vj5c2Gvqx4h5w1PAVEWgqHreyU
6A2Z/G5Rx7lWm1EsCgAVScy9sCHdbn58nz2DT/1XNu9FMbvZENkMU0BphS7sgUcP
fA6hmV29O1m6fyBliCWCLBMwDSwoRzXYMXpNCtouZ+3lThBG3qJMUV/6WaBKaBap
cwG5UZBam4Pglro3CxMKuVFyuQocWTsrx8zaIVTTRnMJk9NE483dVswhv6nX4bh0
Hm3stbQHTswMv5gUlFAGdPOaZPEZf/UPCLltQUQXlThtVMBnhOVc1PoHZe70aUqZ
Y/KAO848ky2AuRQBzRTbNB8n54bNbViBrv6HlEsWOfI43j672Oq8Q4p3Scy057Ev
1MKCyVYuEptjLRJJNy16kXwxpD2FPQmFECWpArFCxW6nvkswzVGfDIimthuj5Hyb
RUosY7n4QHXdk3DpIx0X
=gwA9
-----END PGP SIGNATURE-----

--3bgobrdjg5sbf3zk--
