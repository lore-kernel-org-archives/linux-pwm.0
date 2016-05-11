From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: pwm: atmel: PWM may not properly disable
Date: Wed, 11 May 2016 15:39:05 +0200
Message-ID: <20160511133905.GA15651@ulmo.ba.sec>
References: <CABDcavZXCGWGajRucaFztg98KCoUi-bLxV1fj+j8mW+WdSuLBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35536 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932349AbcEKNjM (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 11 May 2016 09:39:12 -0400
Content-Disposition: inline
In-Reply-To: <CABDcavZXCGWGajRucaFztg98KCoUi-bLxV1fj+j8mW+WdSuLBQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 11, 2016 at 10:48:38AM +0200, Guillermo Rodriguez Garcia wrote:
> Hello all,
>=20
> I am seeing a problem with the atmel-pwm driver where disabling a PWM
> channel sometimes leaves the output at the wrong level ("wrong" =3D=3D not
> idle, as per the configured polarity). This causes problems when the
> PWM is used to drive a LED or certain types of buzzers.
>=20
> The issue seems to be in the atmel_pwm_disable function [1], which
> disables the clock immediately after writing to the PWM_DIS register.
> As a result, the write does not seem to take effect.
>=20
> I have verified that this is the cause of the problem this by waiting
> until the channel is effectively disabled (by checking the PWM_SR
> register) before disabling the clock. This fixes the issue and the PWM
> output now stays at the idle level after the channel is disabled.
>=20
> For the above I used a modified version of a patch that was posted to
> the list some time ago [2]. Note that only atmel_pwm_disable needs to
> be patched, there seems to be no need to patch atmel_pwm_enable. The
> code is as follows:
>=20
>      atmel_pwm_writel(atmel_pwm, PWM_DIS, 1 << pwm->hwpwm);
> +    while (atmel_pwm_readl(atmel_pwm, PWM_SR) & (1 << pwm->hwpwm)) {
> +        cpu_relax();
> +    }
>=20
>      clk_disable(atmel_pwm->clk);
>=20
> Is this acceptable? Should I submit an updated patch?
>=20
>  [1]: http://lxr.free-electrons.com/source/drivers/pwm/pwm-atmel.c#L253
>  [2]: https://lkml.org/lkml/2014/10/1/605
>=20
> (If possible, please CC me in any replies)

Okay, so the above makes a lot more sense than Robert's original patch.
The biggest issue that stuck out at the time was that the code kept
writing to the PWM_DIS register. Your example shows that PWM_SR is the
status register and your loop shows that it's enough to simply wait for
the PWM to become enabled (Robert's patch suggested that writes to
PWM_DIS might not make it through, and hence they had to be repeated).

As for atmel_pwm_enable() I'm tempted to request a similar change. The
reason is that the PWM API expects (though it isn't technically enforced
in any way) that the PWM output is enabled after the function exits. It
seems reasonable to me that disabling would take a while (the remainder
of the current period for example) whereas enabling might always be
immediate. As such it wouldn't be technically necessary to have the loop
so I'm not going to insist if everything indicates the above is indeed
how the hardware works.

One thing that I'd request is that instead of the cpu_relax() you use a
usleep_range() within the loop instead. I assume it can potentially take
a long time for the current period to finish, so busy looping isn't such
a great idea. You could possibly use the current period_ns to derive a
meaningful value to pass to usleep_range().

Otherwise it'd be great if you submitted this again. Also make sure to
use a proper commit message as I suggested in a response to Robert's
original patch.

Thanks,
Thierry

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXMzX1AAoJEN0jrNd/PrOhPQgP/ist0wYW7eQQHDfVAx9WDiJA
2+HlnssQZPJdDaTdRSrVZrv+qMA/klmzpD1F/av6cb5yHUmlRo89xPE/VjFxD1KG
JGawgDyss9Pzoj52WdSdmkn/PxJzfEM5HpfEsZZTeEw8EdyMNHvy7YICMIEz8ZQJ
XsCmeKzOyIIZqNkNjANqW/W7tnM8zFpW5C7hPp8D0zKVtlihEtigp1mS55c2Mbj5
N0uikvYUM81jQUWdaadca0p6K4uLd9SsdwpitOcARmTIExWMTJLjX6T3Cwx2p7XR
YmrEQjP8HlC0Ej2yFNqhAK9MIz7XVfbLGrNCgE36AlgSfDXNZoqasuExiVZeki/+
Dk6MAK2xlC4T6jisS27Wl4zr8m49oGg5HWRR6NuRv0xCnLO08ZUeMp1ANedONrkm
q0VPOv8vakafEzRp1GMVymYbLwUpqTOZVNi3fwBiEbt6UJzHZ+o3dhP5v5X52VQ8
95V3hhAaitS3JZsxJKgGY3acpkrjuhQp5ri3oJPbHEeJI9EzRBYtCs3yM9ZfbS9r
9sithXvcQHlJ5rjBxiewz/NcCOhoM6AOoClbklAYI6RimkJ17w/DqldsGvV69dUz
fpfS5gOXm+GgEAACU3zHuSGbhql+TAOTwhwWQs4yhRelKumRx/ZlV8xfBfEmk6pQ
MHju/X+/9ZlWyCwlJxFj
=lV/V
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
