From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC PATCH 00/15] pwm: add support for atomic update
Date: Thu, 2 Jul 2015 10:17:00 +0300
Message-ID: <5594E56C.3010908@ti.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150702070343.GD11824@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4465670702929940088=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150702070343.GD11824@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Jingoo Han <jingoohan1@gmail.com>, Mark Brown <broonie@kernel.org>, Bryan Wu <cooloney@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Doug Anderson <dianders@google.com>, Thierry Reding <thierry.reding@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-tegra@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

--===============4465670702929940088==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="M9k8jUt8ru3AkjibFGQ7g8jL4uIcQugIR"

--M9k8jUt8ru3AkjibFGQ7g8jL4uIcQugIR
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 02/07/15 10:03, Uwe Kleine-K=F6nig wrote:
> Hello Boris,
>=20
> On Wed, Jul 01, 2015 at 10:21:46AM +0200, Boris Brezillon wrote:
>> This series adds support for atomic PWM update, or ITO, the capability=

>> to update all the parameters of a PWM device (enabled/disabled, period=
,
>> duty and polarity) in one go.
> on first reading the subject of your series I thought it was about
> asserting that the newly set config is active before the call to
> pwm_config (et al) returns. That's a problem I addressed a few times in=

> the past. I wonder if it's only me or if a different wording should be
> used for "update all parameters with a single function call".

In my vocabulary "blocking" means that the work is done before the
function returns, and "atomic" means the work is done in one step.

 Tomi


--M9k8jUt8ru3AkjibFGQ7g8jL4uIcQugIR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVlOVvAAoJEPo9qoy8lh71/8IP/2NdbFL57DIjU27RPVnL8MZ3
tVVRIpo9hnYjmcp0SGspsO6eh4PRk+tCSDmNEHInngaEYktxbQwk3+WwN164ltgV
rCmTDr+hcmFWKfkLooJcG/CSMJb8EKux2qBY/CPLYo6mEMvEyffW4hBLfNePAGUW
aHz+lBwzTk98yje2zzl1XjYqJYJQtKmhQxG0uNviq/LU+GJW/OrwQfNFFCh5hHLC
jpCcRlGCHzOBzRja+yWDQXYMXa48dtTVtE0hITJYW4k2uJ/CQi3Mroq40MQz1Lkr
+hPSucpp/uhB8IjWhFJljuzAnLQeMTVYJHXQ+R8Z1v6556arlo6Pe7qVuIWxf2JO
YK170kSw6wI0Zyzn5QMyf98R6k1uHehc4ifmvqWt76XPA/n2vWIdAjS/gvgE0zrZ
l4iIEItCcJ7UQU+ZjPOkHTS8rZNlS/rkGg3Tq9bfwmkniZtvp3jlj7z9YyRU7fC4
6nULgHfj4S6iwKOJq7FsydtfTGhCE/lN57DHHK6D9pK90zmHBMjcuuiCzYYMaxsA
JcFIpZm+GMDkwqXUCUpGgA3tBwx2b0zM67RbRmeWSiUROPcTQg1MVgtlrHK0BBEE
kcL8Y+QQSKjtczgXyxAciucv93Fyo4OEi4uI3oCxCoSK0X9fC03a1Kbw4KZ9DP0U
Cs+3IcAuZRT2+HbXGC8e
=vGlj
-----END PGP SIGNATURE-----

--M9k8jUt8ru3AkjibFGQ7g8jL4uIcQugIR--


--===============4465670702929940088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4465670702929940088==--
