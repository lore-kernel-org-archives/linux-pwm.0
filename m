From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] backlight: pwm: don't call legacy pwm request for
 device defined in dt
Date: Fri, 12 Jun 2015 15:19:50 +0200
Message-ID: <20150612131948.GA2392@ulmo.nvidia.com>
References: <1413035186-11771-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1413035186-11771-2-git-send-email-vladimir_zapolskiy@mentor.com>
 <20150612113114.GK19400@ulmo.nvidia.com>
 <557AD755.5050409@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:33424 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbbFLNU3 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2015 09:20:29 -0400
Content-Disposition: inline
In-Reply-To: <557AD755.5050409@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, stable@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2015 at 03:57:57PM +0300, Vladimir Zapolskiy wrote:
> Hi Thierry,
>=20
> On 12.06.2015 14:31, Thierry Reding wrote:
> > On Sat, Oct 11, 2014 at 04:46:25PM +0300, Vladimir Zapolskiy wrote:
> >> Platform PWM backlight data provided by board's device tree should be
> >> complete enough to successfully request a pwm device using pwm_get() A=
PI.
> >>
> >> Based on initial implementation done by Dmitry Eremin-Solenikov.
> >>
> >> Reported-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
> >> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >> Cc: Thierry Reding <thierry.reding@gmail.com>
> >> Cc: Jingoo Han <jg1.han@samsung.com>
> >> Cc: Bryan Wu <cooloney@gmail.com>
> >> Cc: Lee Jones <lee.jones@linaro.org>
> >> ---
> >>  drivers/video/backlight/pwm_bl.c |   14 +++++++-------
> >>  1 file changed, 7 insertions(+), 7 deletions(-)
> >=20
> > This fell off my radar, but I think it's good. I used to have a local
> > patch somewhere that solved the same problem by initializing the pwm_id
> > field of platform_pwm_backlight_data to -1 in pwm_backlight_parse_dt(),
> > but I like this variant better because it's more explicit and doesn't
> > even attempt to request using the legacy API (which will inevitably fail
> > in the DT case anyway).
> >=20
> > Vladimir, do you think you'd have the time to rebase this patch on top
> > of something recent and perhaps extend the commit message with some of
> > the arguments that you brought forth in this thread? Specifically it'd
> > be useful to mention that this enforces the DT binding and fixes a real
> > bug where the legacy path would try to request a PWM that's not
> > necessarily the right one.
>=20
> sure, no problem, I'll find time to rebase on top of Lee's
> backlight/for-backlight-next and resend the change this weekend.
>=20
> Thank you for reviewing :)

I'll be away for two weeks, but feel free to add my:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVetxxAAoJEN0jrNd/PrOhZvUP/RncY+Lre8RowOLMiYzKbOpE
/4YSZ0Xn/WxK8Gyzumdu7K/1L9r8qSLJkqycV0/e59a+wF971cj5zyltEysH02vU
QvwbRIVd/nWJgWFj5EV+EC41ROe+9uwU0X0nFMKBYAZl0UeWIf/wHLwXWL/BUIbG
gjYfbcYIbTzKubiZoLps43WuKbHDxP9h9Q/LATiQLP1DGgpVpyVsamDoIeSfBteQ
5DcKlCNA6TVCmjXxH0rgeXZY6euUbQt9vJyt3mfgZXFKbete7IyAnZyVFs+7+Mbo
y+W5C9d5Yx5YAIPfLCyLFbm8JRt8WmyH4zSoD3nmgmDGP+r8/odsGNiSqWNG217R
2h+WVvsiL8W1LYknfd/+3aSbEfJJc9r3uW42QinuHkSr/ABzGwLKF3oljM5/jF9g
RoetvACT0t23MqLOnC2yjSnm7ILAX59K6mfsdJYpiudZ5WBZjACBq1NcmAXN13Qt
MqrOYtnlhvrcJzrXnbT6/9pisNmVh0B0U8qRx25WObcz+ICBQs37VFF2rHNj9eqk
GYAyoWn3soahltQhMvslEX61/4MlzT0tXWwLxa3OngfZ52Rvvf/UqNUa5yZ0GBAg
C4J9qPkUbwbYa10VuS94hLkk9aTA8EZb42adpCTlqPD3a35OdpU23Jcu9QqcQVWW
te80UcUu7mChowR7L2Br
=V57g
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
