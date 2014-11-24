From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND v4 1/4] pwm: Imagination Technologies PWM DAC
 driver
Date: Mon, 24 Nov 2014 13:28:09 +0100
Message-ID: <20141124122807.GA4061@ulmo.nvidia.com>
References: <1416621212-11701-1-git-send-email-Naidu.Tellapati@gmail.com>
 <1416621212-11701-2-git-send-email-Naidu.Tellapati@gmail.com>
 <20141124101325.GB25912@ulmo.nvidia.com>
 <27E62D98F903554192E3C13AFCC91C3C2F52EE89@hbmail01.hb.imgtec.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:55885 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbaKXM2P (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Nov 2014 07:28:15 -0500
Content-Disposition: inline
In-Reply-To: <27E62D98F903554192E3C13AFCC91C3C2F52EE89@hbmail01.hb.imgtec.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Cc: "naidu.tellapati@gmail.com" <naidu.tellapati@gmail.com>, "abrestic@chromium.org" <abrestic@chromium.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, James Hartley <James.Hartley@imgtec.com>, Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arul Ramasamy <Arul.Ramasamy@imgtec.com>, Sai Masarapu <Sai.Masarapu@imgtec.com>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2014 at 11:22:31AM +0000, Naidu Tellapati wrote:
> Hi Thierry,
>=20
> Many thanks for the review.
>=20
> > On Sat, Nov 22, 2014 at 07:23:29AM +0530, naidu.tellapati@gmail.com wro=
te:
> >> From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> >>
> >> The Pistachio SOC from Imagination Technologies includes a Pulse Width
> >> Modulation DAC which produces 1 to 4 digital bit-outputs which represe=
nt
> >> digital waveforms. These PWM outputs are primarily in charge of contro=
lling
> >> backlight LED devices.
> >>
> >> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> >> Signed-off-by: Sai Masarapu <Sai.Masarapu@imgtec.com>
> >> ---
> >>  drivers/pwm/Kconfig   |   12 ++
> >>  drivers/pwm/Makefile  |    1 +
> >>  drivers/pwm/pwm-img.c |  270 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  3 files changed, 283 insertions(+), 0 deletions(-)
> >>  create mode 100644 drivers/pwm/pwm-img.c
> >>
> >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >> index ef2dd2e..6b4581a 100644
> >> --- a/drivers/pwm/Kconfig
> >> +++ b/drivers/pwm/Kconfig
> >> @@ -110,6 +110,18 @@ config PWM_FSL_FTM
> >>         To compile this driver as a module, choose M here: the module
> >>         will be called pwm-fsl-ftm.
> >>
> >> +config PWM_IMG
>=20
> > This sounds really generic to me. Basically this says that every PWM IP
> > developed by Imagination Technologies will be compatible with this one.
> > It's typical to name modules after <vendor>-<soc> to avoid this type of
> > ambiguity.
>=20
> > Is there any reason why this can't be called PWM_IMG_PISTACHIO?
>=20
> At this moment, this IP Block is available at least on one more SOC from =
Imagination Technologies.
> It is possible that the IP will be available on more SOCs in future.
>=20
> Shall we go ahead with PWM_IMG?

Alright, if ever there's a different PWM IP block from Imagination
Technologies, the driver for that can have a more specific name.

> >> +
> >> +     val =3D img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
> >> +     val |=3D BIT(pwm->hwpwm);
> >> +     img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
> >> +
> >> +     regmap_update_bits(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTR=
OL,
> >> +                        CR_PERIP_PWM_PDM_CONTROL_CH_MASK <<
> >> +                        CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(pwm->hwpwm)=
, 0);
>=20
> > This smells like pinmux and should probably be a separate driver.
>=20
> Hope you are suggesting us to have a separate driver for pin muxing (migh=
t already have one for Pistachio)
> and call the pin muxing driver APIs from here.
>=20
> Please correct me if my understanding is wrong?

I don't think you need to call the pinmux API from here. Rather I'll
assume that the muxing is fixed on a given board, so this configuration
would be part of the static board-level pinmux so it will automatically
be applied at boot time.

Thierry

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUcyRXAAoJEN0jrNd/PrOhERgQAIScSbTHSLdBmEHQSO5XUIho
pXeJpL0N68/wicrKFoT4KV5Evu/0rGUzVMuWCHK/xH/dHQrghXZEdItfX5bO5YPq
i4t1+ixko/P1FLsaT1Qy/Qy6OkXauc41/CyWhg62BJPw3xMRkZZRW7QRC0/3cFKA
qcXxAYZ0W5aiW7oMW2UDhZt/teyywMnyUJnmPgiKAiWii2sHrKKpcakZj75CWVME
oRMO+U70UVhH8GAakXDZMQb8QzGo7Lu0SE3v0V/b+y1bM8SvdU85OmQ7gLDXfgy9
Wis+bZNWGBfjL2MSZzZs9kbxGN1+2xkvLezh48vNCCkHYQ5cAdc/DVZQeuyvS5WM
ILWEhD0I3CodL3adT6MxamL6vo/7+n8MOmkoqzUbn1hD2SmIcUSiLePWXp3bfIn0
0vVx/2BsKOQpuVRDlRBSCKgGTZzg/13rnNBsf6iPNXN6RYBjxUs5vQwFbcVNen0H
cp4NtuG3XQDagOyy3TErJ1kN1V9mnD9dNhQC9vHcyDNRWiuFvRkTvy4HOqRihW9y
t2vUkXeqKksUlBXYi+Z3GI/PEUdC7fPrcQVn7nZ2eXJwEiVuwB+jPl9FP/MTEL/x
4+AHaXC6aWQxlMQS9aBJpEsE6NNF1UmnE12a9ql3Rm6uuMoVbYyYnQcWREK/gQfM
prNAfwql2TsSsmnRfs0d
=2mnl
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
