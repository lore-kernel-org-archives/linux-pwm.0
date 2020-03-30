From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle struct element
Date: Mon, 30 Mar 2020 18:02:38 +0200
Message-ID: <20200330160238.GD2817345@ulmo>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200330130743.GB2431644@ulmo>
 <CAHp75Vc_=czuRtyqgnmnYfie50gDnzrNqq3Bt+Gp_42MikX6VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40391 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgC3QCo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 12:02:44 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75Vc_=czuRtyqgnmnYfie50gDnzrNqq3Bt+Gp_42MikX6VA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 04:18:22PM +0300, Andy Shevchenko wrote:
> On Mon, Mar 30, 2020 at 4:09 PM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> >
> > On Wed, Feb 26, 2020 at 02:52:26PM +0100, Matthias Schiffer wrote:
> > > duty_cycle was only set, never read.
> > >
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > ---
> > >  drivers/pwm/pwm-pca9685.c | 4 ----
> > >  1 file changed, 4 deletions(-)
> >
> > Applied, thanks.
>=20
> I'm not sure this patch is correct.

What makes you say that? If you look at the code, the driver sets this
field to either 0 or some duty cycle value but ends up never using it.
Why would it be wrong to remove that code?

> We already have broken GPIO in this driver. Do we need more breakage?

My understanding is that nobody was able to pinpoint exactly when this
regressed, or if this only worked by accident to begin with. It sounds
like Clemens has a way of testing this driver, so perhaps we can solve
that GPIO issue while we're at it.

The last discussion on this seems to have been around the time when you
posted a fix for it:

    https://patchwork.ozlabs.org/patch/1156012/

But then Sven had concerns that that also wasn't guaranteed to work:

    https://lkml.org/lkml/2019/6/2/73

So I think we could either apply your patch to restore the old behaviour
which I assume you tested, so at least it seems to work in practice,
even if there's still a potential race that Sven pointed out in the
above link.

I'd prefer something alternative because it's obviously confusing and
completely undocumented. Mika had already proposed something that's a
little bit better, though still somewhat confusing.

Oh... actually reading further through those threads there seems to be a
patch from Sven that was reviewed by Mika but then nothing happened:

	https://lkml.org/lkml/2019/6/4/1039

with the corresponding patchwork URL:

	https://patchwork.ozlabs.org/patch/1110083/

Andy, Clemens, do you have a way of testing the GPIO functionality of
this driver? If so, it'd be great if you could check the above patch
=66rom Sven to fix PWM/GPIO interop.

Thierry

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6CGBsACgkQ3SOs138+
s6HsHg/+Pi6XaLknGm/+8Ptmf1d/2GeTnb0tvZJ8PkG8OR6UCJPn6xsw0duDorYv
Idj+Wy+V4lWH2UKY+tYjEGuf4lONZpBA2gTjdGkfp63AoO934itx9z9hvcNzCL+0
+WIJlgdMJ4j03/VLJ/y8iuOD09tuta6ardRHIcP/xKDzIjj9GG9UmGjaMgqq4uSh
m70l+QfvAeQPx6qoVm5unb6OrXHJzv0bii21JdWCrzlIdhUH6zjTXklMRe8dy6/U
oyZ8VHJEZtPr7sHk9HZjVqUyhGz+yJZfIxbW1jx1kVKvq4UgLvgMFgmygzn7pMXv
vLxsAZzKoo6nDJZG6n//bNJfU1NtSOrQNlrR8JUmD19/8JUDuGZaBdtHXgmuy790
0iR/yjxJWvHZaGkhzg4vXVhJpQ5ceNLFQNCP0H6W1oEK2BPSP+UKaiVVRuJQVeZ/
NQEW2sze4DHwZMxRpgyMT1c4OJ9nk8J/kaCT7z+WgnRLiVcnj7LqIW5Q8iXFcmhX
akkhUyxj3G/nIfJXbOd9Z+uCQVJ9DQNmROloKZBrb04MpRdOoRbdsv8TlkX7jeBM
AE6yiYNlvMxS2aySFYvWQfmDOJanr4G7T9a11FXODTElgwuy+jTxIgLV6Vds3P2Y
LXzPlPfuZxw1OYfzT3b+q6VYa7Sbw4ajN7sv0QXEnEhqqXG1zlA=
=i5xF
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
