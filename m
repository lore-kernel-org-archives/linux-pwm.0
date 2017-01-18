From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3] pwm: add depends, COMPILE_TEST and default y for
 brcm-iproc-pwm
Date: Wed, 18 Jan 2017 11:45:27 +0100
Message-ID: <20170118104527.GI18989@ulmo.ba.sec>
References: <1475960045-19313-1-git-send-email-scott.branden@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wZdghQXYJzyo6AGC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1475960045-19313-1-git-send-email-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Branden <scott.branden@broadcom.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
List-Id: linux-pwm@vger.kernel.org


--wZdghQXYJzyo6AGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 08, 2016 at 01:54:05PM -0700, Scott Branden wrote:
> - Add depends on COMMON_CLK for PWM_BCM_IPROC
> - Enable COMPILE_TEST for broader compile coverage.
> - Default y for IPROC PWM driver for IPROC SoCs.
> This allows you to turn it on simply by selecting CONFIG_PWM.
>=20
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/pwm/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied with a slightly modified commit message.

Thanks,
Thierry

--wZdghQXYJzyo6AGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh/R0YACgkQ3SOs138+
s6G3uRAAnr9QbzOFWXcOWJ2F4xHG90LyN0F5YWXWHPzN2bd3wAXe9dZPH7lhV2tG
NE5EZ4VYobJBF9YyowT0PopLrZkOzH61JEKUdABGnIzUZdusK77VwKyE41OzTC77
iyPVvDIm9vZyGjQ7KU3C4SxnL7Wh1eszwnkoDo487IUMXj3dpF66+9M3TyEBpeVo
7oi6LKg1602m5Tu1XuAAInjz/G3n3w/b4HKFjqf2AfO6thsPzw4Q+LmZd4YY4kEb
7IQwqtEOoc2Ae+omjOOt+dvzQbssxq0FMBYjHFeHsDBl0jOqM4a11HCzb4VaQhPA
Xputdk96AJqMhH3RVtvD/AxtI0Oq8sdM4FyEqNhygi8OKpBTYNMEcMkOd+ySNLTn
PhbAHJrFDJhKQUaMmZDr6Lm7H9x3rHVWQKuh/Ws5xztniHMheMq2D1MnZKi9q6nf
oxk4iAtZ3HJngKQjrh4Oo6A7ewuwbwDqISYn08RYk21IjVI/ko/HqAw6/tc8+weW
/1p1hp8p5IQMqbEYP7SnZJhEoZuV10Jj/rrAaxGQf0QWT1DuWsHuvJpKijwaTa5f
ji7gIu0TFlUj5lxa1AvWDwf/7d02wDNmLvQjZQ7RgMLqLot0zLVvL8wsJHpWL6rX
QZzUcCYmQ4w1aTA2u0CetpYmenYyLoIbUor1JlYSN4xBEhoPYzY=
=ewx+
-----END PGP SIGNATURE-----

--wZdghQXYJzyo6AGC--
