From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Date: Fri, 9 Oct 2015 23:02:32 +0200
Message-ID: <20151009230232.6d21d9be@bbrezillon>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBB5WW4CYAKGQEQDN7WRA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1442828009-6241-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

On Mon, 21 Sep 2015 11:33:17 +0200
Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Hello,
>=20
> This series adds support for atomic PWM update, or IOW, the capability
> to update all the parameters of a PWM device (enabled/disabled, period,
> duty and polarity) in one go.

Anything preventing this series from being applied (AKA ping)?

>=20
> Best Regards,
>=20
> Boris
>=20
> Changes since v2:
> - rebased on top of 4.3-rc2
> - reintroduced pwm-regulator patches
>=20
> Changes since v1:
> - dropped applied patches
> - squashed Heiko's fixes into the rockchip driver changes
> - made a few cosmetic changes
> - added kerneldoc comments
> - added Heiko's patch to display more information in debugfs
> - dropped pwm-regulator patches (should be submitted separately)
>=20
> Boris Brezillon (11):
>   pwm: introduce default period and polarity concepts
>   pwm: define a new pwm_state struct
>   pwm: move the enabled/disabled info to pwm_state struct
>   backlight: pwm_bl: remove useless call to pwm_set_period
>   pwm: declare a default PWM state
>   pwm: add the PWM initial state retrieval infra
>   pwm: add the core infrastructure to allow atomic update
>   pwm: rockchip: add initial state retrieval
>   pwm: rockchip: add support for atomic update
>   regulator: pwm: implement ->enable(), ->disable() and ->is_enabled
>     methods
>   regulator: pwm: properly initialize the ->state field
>=20
> Heiko St=C3=BCbner (1):
>   pwm: add information about polarity, duty cycle and period to debugfs
>=20
>  drivers/leds/leds-pwm.c              |   2 +-
>  drivers/pwm/core.c                   | 169 +++++++++++++++++++++++++++++=
++----
>  drivers/pwm/pwm-pxa.c                |   2 +-
>  drivers/pwm/pwm-rockchip.c           | 119 +++++++++++++++++++-----
>  drivers/pwm/pwm-sun4i.c              |   3 +-
>  drivers/regulator/pwm-regulator.c    |  65 ++++++++++++--
>  drivers/video/backlight/lm3630a_bl.c |   4 +-
>  drivers/video/backlight/pwm_bl.c     |  10 ++-
>  drivers/video/fbdev/ssd1307fb.c      |   2 +-
>  include/linux/pwm.h                  |  89 +++++++++++++++---
>  10 files changed, 392 insertions(+), 73 deletions(-)
>=20



--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
