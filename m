From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [NEXT REQUEST][PATCH] backlight: pwm: handle EPROBE_DEFER while
 requesting the PWM
Date: Wed, 27 May 2015 07:20:39 +1000
Message-ID: <20150527072039.07aeea30@canb.auug.org.au>
References: <1424338214-24236-1-git-send-email-nicolas.ferre@atmel.com>
	<20150312090224.GC3314@x1>
	<20150525112718.5f7e2d7d@bbrezillon>
	<20150526073648.GB11677@x1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SytJC+n7YiazyBba3WIZ23P"; protocol="application/pgp-signature"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20150526073648.GB11677@x1>
Sender: linux-next-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-next@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, jg1.han@samsung.com, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

--Sig_/SytJC+n7YiazyBba3WIZ23P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Tue, 26 May 2015 08:36:48 +0100 Lee Jones <lee.jones@linaro.org> wrote:
>
> It looks like my for-backlight-fixes branch isn't in -next.
>=20
> Stephen, could you rectify that please?
>=20
> M: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/SytJC+n7YiazyBba3WIZ23P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVZOOtAAoJEMDTa8Ir7ZwVw58P/id7SKH8e37r5MvfsWfEC7TC
6eZXKjb94dc9Y+7+j7pHQDzEiyENJvqe9orWRFnGLJqZmFgmkDwLnWkpNq7mlnVo
iLKtBhihI9b8fpgieN/VnVA7aGpBFyxPhLL/zYLMXr2bIslTGxP7O6dAHQ5z2nFu
bCbVccenMZPywZIm2tXNLjrENJEmawr8TUq7vHvFJkKYV0Re0buAoDWJ0wZRLWQ6
tGAEVRjyp5UlsQQvB2RLVtvd58kSXdi6Xi85+NZ+fnlD9OlPOlV91/0Tq97Fu2GJ
muaBbvrJRCNXUxqHbiZzv04r9+pHzDlACd0R+XphWvrT0NxW8nKmFXhXZL2Stz9/
MzxypHII8CyJWnDkgmA0K82XvUpzNPXIJSmXTwRo7qZjlqgyYG5UfIc4PAWVQWct
NdVQi2kWCgicoG/XKv6JTNGTWPW0yONbbhWj5sCoGkdc8BIS/qjtTltyxfOTXFiI
giGKJ1BlY6JJMHT24/melolHRwxiKl5KHudf+EvcFMWVCTjjxclzdnF7245Pwz3t
chW0e6pFKL8g0pVo+5eu52pcQXG92BhfhlYoW/hScdlL7Oc3AreL16ao/J5hcynr
2/LaDV79+cnVKDL0k1OwdZMgCJAxO/YEyQUQ2ep0IwTEI1HgDwmWlPtGBD0UrlM0
+iO+Ze6XtFzvJ7CWYq8T
=A7QE
-----END PGP SIGNATURE-----

--Sig_/SytJC+n7YiazyBba3WIZ23P--
