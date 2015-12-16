From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: ftm: fix clock enable/disable when using PM
Date: Wed, 16 Dec 2015 16:55:00 +0100
Message-ID: <20151216155500.GH28947@ulmo>
References: <1448318707-18011-1-git-send-email-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="smOfPzt+Qjm5bNGJ"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35099 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933885AbbLPPzD (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Dec 2015 10:55:03 -0500
Content-Disposition: inline
In-Reply-To: <1448318707-18011-1-git-send-email-stefan@agner.ch>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Xiubo.Lee@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--smOfPzt+Qjm5bNGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2015 at 02:45:07PM -0800, Stefan Agner wrote:
> A FTM PWM instance enables/disables three clocks: The bus clock, the
> counter clock and the PWM clock. The bus clock gets enabled on
> pwm_request, whereas the counter and PWM clocks will be enabled upon
> pwm_enable.
>=20
> The driver has three closesly related issues when enabling/disabling
> clocks during suspend/resume:
> - The three clocks are not treated differently in regards to the
>   individual PWM state enabled/requested. This can lead to clocks
>   getting disabled which have not been enabled in the first place
>   (a PWM channel which only has been requested going through
>   suspend/resume).
>=20
> - When entering suspend, the current behavior relies on the
>   FTM_OUTMASK register: If a PWM output is unmasked, the driver
>   assumes the clocks are enabled. However, some PWM instances
>   have only 2 channels connected (e.g. Vybrid's FTM1). In that case,
>   the FTM_OUTMASK reads 0x3 if all channels are disabled, even if
>   the code wrote 0xff to it before. For those PWM instances, the
>   current approach to detect enabled PWM signals does not work.
>=20
> - A third issue applies to the bus clock only, which can get enabled
>   multiple times (once for each PWM channel of a PWM chip). This is
>   fine, however when entering suspend mode, the clock only gets
>   disabled once.
>=20
> This change introduces a different approach by relying on the enable
> and prepared counters of the clock framework and using the frameworks
> PWM signal states to address all three issues.
>=20
> Clocks get disabled during suspend and back enabled on resume
> regarding to the PWM channels individual state (requested/enabled).
>=20
> Since we do not count the clock enables in the driver, this change no
> longer clears the Status and Control registers Clock Source Selection
> (FTM_SC[CLKS]). However, since we disable the selected clock anyway,
> and we explicitly select the clock source on reenabling a PWM channel
> this approach should not make a difference in practice.
>=20
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Hi Lee,
>=20
> I just found your new email address. Thierry and I already had some
> discussion about the patch here:
> http://thread.gmane.org/gmane.linux.pwm/2878
>=20
> Could you have a look at that patch?
>=20
> Changes since v1:
> - Use the pwm_is_enabled helper
>=20
>  drivers/pwm/pwm-fsl-ftm.c | 58 ++++++++++++++++++++---------------------=
------
>  1 file changed, 25 insertions(+), 33 deletions(-)

Applied, thanks.

Thierry

--smOfPzt+Qjm5bNGJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWcYlTAAoJEN0jrNd/PrOhs1QQAKLQX3Wh1D7isc/qisFEsiWy
ULVeuQ6BhthSNsvMg3DCdduURfojTfquTOKPZt/L0KkpFL+4F1e2Yok7aTJfHjyR
Bt6xp1+xYs5+nBJuj7L+RP5maNpUVVstzFhuKhXaby0oZqD5o9vdEmmRvVw7C8hL
xBf42eLTFH7N9Q3WcedR5meunM7+o2u935h8IBTnJtgjZnA6vZou83AAugT/VqlG
df9c850+8/uZwSgtc1AcqoMZbGFuaTM1z0Gi0HTc8oa8Z/+5JahJNxkjT3CvHB6t
oKoNo3NqRxqJswNvVeS8wDWHxwRJXNyn6X3yMhVtXSwU9ps9AWN+GmoZaj1a7kBt
cuuimsFE3Huv/Cx0Zqy+ySZBUVMOHaPZgP6H0o+th0ya0nuiHqUAve1ERYWYH/Xv
RXRS+7Hb/IzxqOBzpylrOgO1Mn8PAw+F9VHj0cvF+L/TYla2jBvvxg87LTb3Sypf
T513wPu77wY8IcjIOgLrTjRXmQHZpQSmdf5NE+zUSb1UtxfNjW0yaC8qz1frtgYs
MtE69MlLX7F+fFmrraYmcMdTFAi2RyIBwHY1+DtO82WjNjUeuEIgsK0xkRgLEVyi
yzJ91MJj0/JUpTynsqb9tBk7LWIT+z74yFpQFZWhyS1AiyrW0JkiVmOZeF06ijU2
L5uZ3+uX6UHGDRdTLKNb
=o0b3
-----END PGP SIGNATURE-----

--smOfPzt+Qjm5bNGJ--
