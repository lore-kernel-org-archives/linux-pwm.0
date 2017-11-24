From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RFT] pwm: stmpe: Fix wrong register offset for hwpwm=2
 case
Date: Fri, 24 Nov 2017 11:42:44 +0100
Message-ID: <20171124104244.GA3792@ulmo>
References: <20171107051853.14492-1-axel.lin@ingics.com>
 <CACRpkda1G635V3kNXzVcnUStB8tjCdHupf3PcR_t2H5ZX0OftQ@mail.gmail.com>
 <CAFRkauBhALFxedJ-4nBXpjBF9Sd-NW9bQrgwtHUbYjQ3yZGTCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:42746 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753100AbdKXKmr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Nov 2017 05:42:47 -0500
Received: by mail-wm0-f47.google.com with SMTP id 124so4821249wmv.1
        for <linux-pwm@vger.kernel.org>; Fri, 24 Nov 2017 02:42:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAFRkauBhALFxedJ-4nBXpjBF9Sd-NW9bQrgwtHUbYjQ3yZGTCw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2017 at 05:10:14PM +0800, Axel Lin wrote:
> 2017-11-09 16:45 GMT+08:00 Linus Walleij <linus.walleij@linaro.org>:
> > On Tue, Nov 7, 2017 at 6:18 AM, Axel Lin <axel.lin@ingics.com> wrote:
> >
> >> Fix trivial copy/paste bug.
> >>
> >> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> >> ---
> >> Hi Linus,
> >> I don't have this h/w to test.
> >> Appreciate if you can review and test this patch.
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Hi Thierry,
> Seems this one is still not apply. Should I resend?

No need to resend, I can see it in patchwork. I'm not exactly sure what
happened, but it looks like this may have just missed the cut-off point
for v4.15-rc1. Is this a serious bug? Do you want it to go into v4.15?
By the looks of it this has been wrong since forever (no changes since
the original patch adding the driver), so I'm wondering if anybody has
ever used this third PWM at all.

I'm fine either way. If this is something that's creating problems, let
me know and I'll queue it for v4.15-rc2. If so, you may want it to be
backported to stable kernel, in which case:

Fixes: ef1f09eca74a ("pwm: Add a driver for the STMPE PWM")

Thierry

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloX96EACgkQ3SOs138+
s6FYphAAm/8HS9GGogPgK4Ycx3neotP6lpgUH66GTkM2QjKS2PLvFL/rmnVg70uO
3qYULhm7K/r7wbIhPUPjHW+LOE6nxq3fPe7mNLNMANDID1YQf3qOxHM5/n9QYiIL
J7cN6YSc37KySi2w5uu8WXNJATOrV11dMLbXoe+j+/1GjPb0V26TGYzrUGkZOzPD
xm/G7jAdMlC2atxNbEOyO1394eLtCXTwyEHWBlYFWYlsGXVqhIH4/93bZXfPjAwA
v9ubYz2euW6qVLiT2I2c/c6KeOtWEb2jmQ13s1p0Xli3M9QuBp3SlB1PdpSHjhZJ
ElLIk3VZ5jItsJ3W84aB2rpGgx0ZL1UTXItZXRGjzu8iPqnU+yj5PxebltNMZBWu
QatOOWc7b2Sg46snbX7Rc/eMjQmr8HAJVV03ldloqsppGZx+w8DGz4mse5WeYtHg
QtR48IR9DzWyulwn9lmAxShCCo3aMU/89Vrm2QagKaJ7iDDYcIMdO72qII0PqM9H
dtc20WhWxIarSs+OfZtlB0PDQI72DTmogogrfkRD8qDEXOkmZL3yURLXErdc+FK9
s54xOHLev3XDp+sDRcEZGa8vTyhy/ArLzrvS0Y5gYtvfpnMd42XiBD9oxfUolxtO
3Sx89OcVd2Cvpb2uk1m19nb/1le5ORPGxenn9srq8DYSRrMm/cs=
=np++
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
