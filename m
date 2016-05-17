From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: atmel-hlcdc: Fix default PWM polarity
Date: Tue, 17 May 2016 14:19:17 +0200
Message-ID: <20160517121917.GD26166@ulmo.ba.sec>
References: <1463476352-7485-1-git-send-email-boris.brezillon@free-electrons.com>
 <20160517110005.GA26166@ulmo.ba.sec>
 <20160517140803.078e3f5e@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33915 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932535AbcEQMTV (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2016 08:19:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id n129so4326137wmn.1
        for <linux-pwm@vger.kernel.org>; Tue, 17 May 2016 05:19:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160517140803.078e3f5e@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 17, 2016 at 02:08:03PM +0200, Boris Brezillon wrote:
> Hi Thierry,
>=20
> On Tue, 17 May 2016 13:00:05 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Tue, May 17, 2016 at 11:12:32AM +0200, Boris Brezillon wrote:
> > > The PWM device exposed by the HLCDC IP is configured with an inverted
> > > polarity by default. Registering the PWM chip with the normal polarity
> > > was not a problem before commit 42e8992c58d4 ("pwm: Add core
> > > infrastructure to allow atomic updates") because the ->set_polarity()
> > > hook was called no matter the current polarity state, but this is no =
longer
> > > the case.
> > >=20
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Fixes: 42e8992c58d4 ("pwm: Add core infrastructure to allow atomic up=
dates") =20
> >=20
> > That's not technically correct, because it's the driver that has the
> > bug. The core change merely exposes it. How about if I sort this into
> > the pwm-atomic branch and reword the commit message accordingly? That
> > way things should all stay bisectible.
> >=20
> > Then again, given the breakage caused by the pwm_args patch I suppose
> > it doesn't matter much because that's part of a stable branch that I
> > can't rebase.
>=20
> If I understood correctly, you plan to rebase your pwm-atomic branch to
> insert this commit before commit 42e8992c58d4 ("pwm: Add core
> infrastructure to allow atomic updates").
>=20
> Could you consider taking the following commit (or something similar if
> you already have a fix) as the first commit of your pwm-atomic branch?
>=20
> Sorry for the mess around the introduction of pwm_args and pwm_state
> (that's not an excuse, but I've reworked this series so many time that I
> forgot to check bisectibility on the last versions :-().
>=20
> ---
> From ad73fa3a56c7320979425d64ab54c09b9d83d4cf Mon Sep 17 00:00:00 2001
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> Date: Tue, 17 May 2016 13:55:02 +0200
> Subject: [PATCH] pwm: Fix pwm_apply_args() call sites
>=20
> pwm_apply_args() is supposed to initialize a PWM device according to the
> arguments provided by the DT or the PWM lookup, but this function was
> called inside pwm_device_request(), which in turn was called before the
> core had a chance to initialize the pwm->args fields.
>=20
> Fix that by calling pwm_apply_args directly in pwm_get() and of_pwm_get()
> after initializing pwm->args field.
>=20
> This commit also fixes an invalid pointer dereference introduced by
> commit e39c0df1be5a ("pwm: Introduce the pwm_args concept").
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Fixes: e39c0df1be5a ("pwm: Introduce the pwm_args concept")
> ---
>  drivers/pwm/core.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)

This looks good to me. However I can't easily apply this because git
gets confused by the existing headers. Also manually copying out the
patch yields patch corruption that I don't exactly know how to fix.

I think you can inline patches by using a scissor mark (--- >8 ---)
instead of the signature separator (---). Or you can attach the patch
with "Content-Disposition: inline".

Rather than putting this into the pwm-atomic branch, I'll probably stick
it into the pwm-args branch on top of the existing patch. Technically
only the existing patch needs to be stable, so the branch can still
evolve.

Thierry

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXOwxDAAoJEN0jrNd/PrOh9zwP/2VnHpU9sfPqggL1HFa6htEp
VQYxCRzK9I+rJxHe2Vct/ghYpQsRq7YQlZnUEDTaOgON8e23Vt7Cz1hC+UPCmUa/
DooLbhWJ/SubFF+XiIjlkPzKsjUfPsOFbQbDCATW3jPj5gOPHm1thFVppskK/jsK
JtyQxoj1z+vDn74vz+XU9J+OrRDDKgPLJyo0l4+jroDePS89iW6riEUr3pKzxCTs
G2lyHjOfByH5+AgDFJjkJnH5CmfvxPsdX4dDbYXbR5QCj24vk67ft5mjMypX3NvI
hCjaEFQmPeZSmChH0JED/PsyQ+avZyj46xjDEfCrclVCzjPeKRDgTsynN+kHbb5a
CtwT7MCYYj+F/aWpr1Cp2fgiMHoKXitnNawAxn7r7CAIXJrHg/dMSA85FZQD1jVs
9s/PDd4wGJJa4llV8Qyc3vDTEuCc+i1F/w4QHeCneUAAD+J/BmSVfs3Bay16CThR
RPMUTUMPoGpBqwCGOqIrhSuOobocORsTDl2Mk/VVkuiHq225Qn0cJIobKh2ysmfc
kZzcNGUwOFA2gCX/GuK8mgzMvBHHpRX1Cf4eKH9Hc5wo6WaBNmkl72nBBcFUsO+p
Us9XSPjX6tmXvh14KQ36FJnHrVeJ3JKQxLqAYeCRkpvUdS9WZVeuM1EWhGk3vx0Y
4rnLMhZZeqoV2e1o63WN
=qv66
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
