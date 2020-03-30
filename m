From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
Date: Mon, 30 Mar 2020 17:38:10 +0200
Message-ID: <20200330153810.GA2817345@ulmo>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
 <20200330130757.GC2431644@ulmo>
 <CAHp75VeY9ZGUD_=N=R2vsJFY-4P5-L1+ZzjKHU2cygcbML0zOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55247 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgC3Piq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 11:38:46 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75VeY9ZGUD_=N=R2vsJFY-4P5-L1+ZzjKHU2cygcbML0zOw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 04:19:55PM +0300, Andy Shevchenko wrote:
> On Mon, Mar 30, 2020 at 4:10 PM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> >
> > On Wed, Feb 26, 2020 at 02:52:27PM +0100, Matthias Schiffer wrote:
> > > The interaction of the ALL_LED PWM channel with the other channels was
> > > not well-defined. As the ALL_LED feature does not seem very useful and
> > > it was making the code significantly more complex, simply remove it.
> > >
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > ---
> > >  drivers/pwm/pwm-pca9685.c | 115 ++++++------------------------------=
--
> > >  1 file changed, 17 insertions(+), 98 deletions(-)
> >
> > Applied, thanks.
>=20
> This seems to be ABI breakage.

Nothing seemed to be using that feature. As a matter of fact, I don't
really see anyone using this chip in an upstream kernel, so it's
difficult to understand what the dependencies are.

> Thierry, do you have hardware to test?

No, I don't. Do you?

Does anybody have a good understanding of where the users of this are
and where the code is? There seems to be a lot of confusion around this
driver/chip and how it's being used and it keeps causing a lot of this
back and forth, so can we please gather some basic information and then
I'll add that to the driver along with perhaps a list of contacts that
want to be involved.

As it is, it seems like applying patches as I see fit is the only way to
get people to object, which is a suboptimal way to do things. =3D)

Thierry

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6CEmAACgkQ3SOs138+
s6GhMA//QXptmnJALfUYiX+M0Q8w8ZlqrU3s3Zth8HvqhMnhoYTCsuwQ6Keqpb7s
ZlMGD21yL8fcL8spiI/cGA3SqrNKdVV9/Ejy4sUteXB5JPDi4n/fU1Ed1+bLMuJF
7yTY8FL58Z3C/Z0FIWfxjJ+wBGbsO9cSNYuswdKBhzSeVxGR3sDDEmFZSXQ2EKr5
MgFq/Icb4tR5JykUlojHenbYd6ocfZqfUKKpRG4VUd4hHR5oG5zH8VjNBgkhNYRl
62ojPYdJ3/WhW6YOcYObFJrH4eQ0fC99FovDc0JfqsSuF4kaM/EAqdqOXs01v5xM
K5ELLsS0oXlUz/N+u7JCfGgFKg7eiSnT6DJm8SKzoOq+H/Qzc/C31oAG3e1C9yHt
hjZw8rhTz4EuqhBtctFAQG5ZrLyNV4w8dMBhRclOFVCfLBWYrzc2U5Faqsp2HsNX
9TVPu9PBvBTi0teUOtmXTCWCB9SbwRemoEwQRSh1UbEUXQeTThUjCnz76j/wR6D3
4mz2A0RRvtGFiS4DtAF9v108AcfAiGkFyoKEFKNj4xchttpaII9blX47OPaH79C5
zk7/X5ULp3dUKMnavSSkSW6A7y4Oa641UZoc6LdFhIc1a+KFhwVUsgVG6VBbTwsP
RJ/0I7RWzfHHnpLmEgBW/NnfGUM+7FvbGI4FjEnmsVMrsK+7PMs=
=m4iH
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
