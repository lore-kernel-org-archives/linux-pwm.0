From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: improve args checking in pwm_apply_state()
Date: Fri, 10 Jun 2016 14:20:30 +0200
Message-ID: <20160610122030.GA27142@ulmo.ba.sec>
References: <1464367549-111530-1-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35150 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbcFJMUf (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Jun 2016 08:20:35 -0400
Content-Disposition: inline
In-Reply-To: <1464367549-111530-1-git-send-email-briannorris@chromium.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Doug Anderson <dianders@chromium.org>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 27, 2016 at 09:45:49AM -0700, Brian Norris wrote:
> It seems like in the process of refactoring pwm_config() to utilize the
> newly-introduced pwm_apply_state() API, some args/bounds checking was
> dropped.
>=20
> In particular, I noted that we are now allowing invalid period
> selections. e.g.:
>=20
>   # echo 1 > /sys/class/pwm/pwmchip0/export
>   # cat /sys/class/pwm/pwmchip0/pwm1/period
>   100
>   # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
>   [... driver may or may not reject the value, or trigger some logic bug =
=2E..]
>=20
> It's better to see:
>=20
>   # echo 1 > /sys/class/pwm/pwmchip0/export
>   # cat /sys/class/pwm/pwmchip0/pwm1/period
>   100
>   # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
>   -bash: echo: write error: Invalid argument
>=20
> This patch reintroduces some bounds checks in both pwm_config() (for its
> signed parameters; we don't want to convert negative values into large
> unsigned values) and in pwm_apply_state() (which fix the above described
> behavior, as well as other potential API misuses).
>=20
> Fixes: 5ec803edcb70 ("pwm: Add core infrastructure to allow atomic update=
s")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> v2:
>  * changed subject, as this covers more scope now
>  * add Fixes tag, as this is a v4.7-rc regression
>  * add more bounds/args checks in pwm_apply_state() and pwm_config()
>=20
>  drivers/pwm/core.c  | 3 ++-
>  include/linux/pwm.h | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXWrCFAAoJEN0jrNd/PrOh8UwP/iQzsNwAQd0bdF4WmWOLb7ux
2rRQXLUNETYIoboLzVhvim0g1xMf2E3+PV5vQERIKLZISQlSEm0NGr/8oF6xWHlq
+UTSMMKtrjguNgG9G0cl/rAWGCuM9MmdyFKRzPbHpKxe1ozZD+Vyls3B1QZLc8CK
mmlKIHA+XL0t4+Q1hYLWpwe3elLYNvq2b9LHw/cAKTE6CJfSQWl5kUOV0TZSbRsw
IdDHLfRIIzcUArfiPwDtwYyn4FmirdaapXPWupTnvwkiWTt2PAOKBl5TUTQ/83/q
ZnYBYUEe2qhkHPFir0nb5YqM6oQHVt+It7gLXhnNoCJn8kG7S7ClR3QAzeson3xP
d30k13peimupyWo4rdc58mRFX64eQrww5g0Q7eTVueKTwDJ6QamrW015WX/Cstc1
F2eC8sINlCrxOqW/Z17vWoX8bNK4uFfwf8WxKvb+XTOpFByUt6Bzc0ozb4edARIf
8Rd6dsMO9Su1C1T1Ly8NLYRMv99QoexW+TSrGbHsnaLHbbLgl9R2ItaIoeA0AHZK
qOi0wQWvsEHT1uotqNRynCLunrxr1D9HrfBGB59Vw7ubZk9fcSr4QjKApy1uC0ud
MeatlMaS7rByNNMZk+F1HfedBBJr3RloFqplWkQqq+vNSIj+wWHcKukcXQI3n87o
GUQRwodFgiX7ZvTo0UgY
=lp7/
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
