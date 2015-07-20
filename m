From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCH 02/15] pwm: fix pwm_get_period and pwm_get_duty_cycle
 prototypes
Date: Mon, 20 Jul 2015 09:50:50 +0200
Message-ID: <20150720075049.GC29614@ulmo>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-3-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33521 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669AbbGTHvE (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2015 03:51:04 -0400
Content-Disposition: inline
In-Reply-To: <1435738921-25027-3-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2015 at 10:21:48AM +0200, Boris Brezillon wrote:
> The pwm argument is not modified in pwm_get helpers, make it a const
> argument so that they can be used from the sysfs functions.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  include/linux/pwm.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied with a slightly reworded commit message. The prototypes weren't
"broken" so there's nothing to "fix". Also s/pwm/PWM/.

Thanks,
Thierry

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrKhZAAoJEN0jrNd/PrOhG08QALBNyP8U2H1TjieUoq6OlQ5I
U1fZUZTnTowkC67bxbE375DuSPydr/lUykQfhwS/EGn/WtMNSRNqZETYkU0N7huK
A9jZ3g7aDOXACH6tT4LVwJh5MwZAhXgaLVsbrZiNOD34Slj2m5sOH48x/w3RgJEh
hVg6nauENPBAxDDYKEWFrhkMrkFX+DxMUWBsxUYX5hp0NwfuasmY7UyhM+m4AKtB
bDyBEy5BCI+2X8sZ2wra1VvajVLNktnK1EKLVsBbj40yZI1nArnVsa6O8VZylfjl
dQnjnfcchgS/8UqtUc/zBMNUlEAKS8k1bl1wsNfrMDfeBd6iA8P0ATvMrlHdbT//
zDtYHtboxn8QNpPI6RvPe481XJeDNQ93GCYqNiFxXOUkt9bL5RbzsgFW99p4281k
lnsVB/+5dPrV7oy1BrpNa7fEi1OePfARxw5dFIzij9iLbgIfcnhagxfh7HagNOaL
kwdYSUQ3a8IaufdSj6Ew211XEEsYJzRsJ4J349TAWODw18gpNzoeUxO2eQK3AANI
hN50mLZLua/E6XL7TTDYQRmIb52ZaOU17IUZ624lpnw1m8V59rx2M6fa58WN0WYV
0HDouI9skdiiAYy3wpXua6S+tgE1PueugUgAShqeP2DPDuoUtv7yiMY/XjAxxF3/
LEHTUYLGbIu7tLzGSQwN
=1NiT
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
