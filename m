From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND] pwm: brcmstb: Don't set can_sleep flag
Date: Tue, 24 Nov 2015 17:27:10 +0100
Message-ID: <20151124162710.GD32623@ulmo.nvidia.com>
References: <1448347392.17722.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33176 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbbKXQ1O (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Nov 2015 11:27:14 -0500
Received: by pabfh17 with SMTP id fh17so27709684pab.0
        for <linux-pwm@vger.kernel.org>; Tue, 24 Nov 2015 08:27:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1448347392.17722.1.camel@ingics.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-pwm@vger.kernel.org


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2015 at 02:43:12PM +0800, Axel Lin wrote:
> The .can_sleep flag is used for some PWM controllers that can't be used
> in atomic context. Not such case for this driver, so don't set the
> can_sleep flag.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Brian Norris <computersforpeace@gmail.com>
> ---
> This patch was sent on http://www.spinics.net/lists/linux-pwm/msg03506.ht=
ml
>=20
>  drivers/pwm/pwm-brcmstb.c | 1 -
>  1 file changed, 1 deletion(-)

There's some discussion currently about marking all drivers can_sleep
and modify all users to cope with it correctly. The reason is that we
introduced a mutex in pwm_enable() and pwm_set_polarity() which means
that PWM devices effectively can't be used from interrupt or atomic
contexts.

It also means that the driver is actually currently correct, so I'd
like to leave it as-is until the users have been sorted out, at which
point we can simply get rid of can_sleep.

Thierry

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWVI/eAAoJEN0jrNd/PrOhF8YP/1x3STIvelNNg1WbjTh8OtPE
lwY8CnYjyMR5E5GWAtTpwSLAENd+EFmZdbOGrgYN3fHP7g6mmrkjl4n4po0MGJ8C
1ClrsNz6uB2dmbDwN1ZbVFI2PRZ4kytnxn0q5VM3PFY9sc++l5HIbuuGYSegu186
ibG5PKyoZceSBjv2DC6H1zTqyv80dVHTw76zZ/9PdjnL6x2KJIRLFACbOqMF2iyf
1H9sftJCeSQsTZMHzqfuoGQ7in2aBha/RO9JAaNfxBHLIpjN29rQ4Bo7gujP4SLe
rc+ern0gVE9duJBZYpIEQjd2jaS4sAr6KO/57OG/df55PkBgq8w5JkSTPl+OUlf0
4hMkRg99gwybwqD4ns+Is4FN+Ipkt9YABNwWEV6eqiGDgrnXjQjtK18aeDkywIPU
SHgX94OEw/qklsbcQTyYguKIOez/w4ExmMVaefTcVahWPKuUb3GdSHXBNLGaL3YF
uETnc1pBCU4cubcfSdY2vq9494RatnY1CK9ezsoXejfvCq6CNDnqkI99R0NwfGWr
ykPEgRbvdtzcmft7Jtp8dYK1fSXE4SaT/9LwxNeoqIHGyoNrUMMjIDg3lPYEZ/g9
ISaw30lvqjYbHynQU/jLt7hFMQ7iLTUPCyyHfJK2RGru8zCw/hSKKHCFPozYGh88
AXuY3W9tJNkS+SEFjEsi
=tNUi
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--
