From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH 2/3] leds: pwm: convert to atomic PWM API
Date: Wed, 26 Feb 2020 15:55:44 +0100
Message-ID: <863bdd8c-570d-9cf9-4eda-a873b039696b@kleine-koenig.org>
References: <20200124165409.12422-1-uwe@kleine-koenig.org>
 <20200124165409.12422-3-uwe@kleine-koenig.org>
 <20200126191457.GB2569@labundy.com> <20200226143522.GM4080@duo.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="qQG1WMY8fEYwct1SmvxmX0fcQmkuV2ZCO"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:36920 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgBZO4H (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2020 09:56:07 -0500
In-Reply-To: <20200226143522.GM4080@duo.ucw.cz>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Jeff LaBundy <jeff@labundy.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Dan Murphy <dmurphy@ti.com>, Thierry Reding <thierry.reding@gmail.com>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qQG1WMY8fEYwct1SmvxmX0fcQmkuV2ZCO
Content-Type: multipart/mixed; boundary="iP8xuKjLhapfcuwBWgF3Z5vTF1TAJPYUj";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Pavel Machek <pavel@ucw.cz>, Jeff LaBundy <jeff@labundy.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Dan Murphy
 <dmurphy@ti.com>, Thierry Reding <thierry.reding@gmail.com>,
 "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Message-ID: <863bdd8c-570d-9cf9-4eda-a873b039696b@kleine-koenig.org>
Subject: Re: [PATCH 2/3] leds: pwm: convert to atomic PWM API
References: <20200124165409.12422-1-uwe@kleine-koenig.org>
 <20200124165409.12422-3-uwe@kleine-koenig.org>
 <20200126191457.GB2569@labundy.com> <20200226143522.GM4080@duo.ucw.cz>
In-Reply-To: <20200226143522.GM4080@duo.ucw.cz>

--iP8xuKjLhapfcuwBWgF3Z5vTF1TAJPYUj
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 2/26/20 3:35 PM, Pavel Machek wrote:
>> On Fri, Jan 24, 2020 at 05:54:08PM +0100, Uwe Kleine-K=F6nig wrote:
>>> pwm_config(), pwm_enable() and pwm_disable() should get removed in th=
e
>>> long run. So update the driver to use the atomic API that is here to
>>> stay.
>>>
>>> A few side effects:
>>>
>>>  - led_pwm_set() now returns an error when setting the PWM fails.
>>>  - During .probe() the PWM isn't disabled implicitly by pwm_apply_arg=
s()
>>>    any more.
>>>
>>> Signed-off-by: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
>=20
>> And so:
>>
>> Tested-by: Jeff LaBundy <jeff@labundy.com>
>=20
> Thanks for patches, thanks for testing.
>=20
> 1,2 applied to -for-next.
>=20
> AFAICT 3/3 should really get the default-state: keep support before
> being merged?

Maybe I miss something, but I wonder why default-state: keep support
isn't implemented in the core but in each led driver instead. (And as
soon as someone implements it in the core, patch 3 is the right thing to
do.)

Best regards
Uwe


--iP8xuKjLhapfcuwBWgF3Z5vTF1TAJPYUj--

--qQG1WMY8fEYwct1SmvxmX0fcQmkuV2ZCO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl5WhvQACgkQwfwUeK3K
7AnIyQf/d9+ahtGs0D5wcATDf3ev9kBHssA3tIpLzUCgGJdW5JW0/7thzOoeL2kx
t9YJy3VyTDPphs0XSJQ26uMl4cDA+RwGy1+UIcHO9JN/UELLBtplCETAWN4WA8QB
OVryvaZBbs16BzuW2Deoeu8t8rYgqSN5dphFUEtq9e+eB5VpUG+oyXJEbbsX8nRu
u2jjnUR7TqB3t9wj10ysgl3WLF21fuQQacehfTy3F/Rv5nj2Fp+eHGGZfwWyqbBO
UxuJKTJ1Dq3eK/ACy5we8Tz6OyA5/pmAF6MUeDxVpfRkPdnhJbc+pXC9NJnT3+Jl
F3s7We8WF14HjasmDiill4hfn6C9Aw==
=ij5K
-----END PGP SIGNATURE-----

--qQG1WMY8fEYwct1SmvxmX0fcQmkuV2ZCO--
