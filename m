From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: Missing feedback
Date: Fri, 22 May 2020 17:21:33 +0200
Message-ID: <20200522152133.GA2377357@ulmo>
References: <20200522101355.x4td3ehkfhp636ft@pengutronix.de>
 <20200522114635.GB2163848@ulmo>
 <20200522131512.44pzss7ujsp2wbgw@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729929AbgEVPVh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 11:21:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5379EC061A0E
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2020 08:21:37 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g9so9514367edr.8
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2020 08:21:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200522131512.44pzss7ujsp2wbgw@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2020 at 03:15:12PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Fri, May 22, 2020 at 01:46:35PM +0200, Thierry Reding wrote:
> > Like I said, I'm open to let you take on a more central role eventually,
> > but I'm going to need a bit more time to convince myself that you will
> > be doing a better job than I.
>=20
> I'm also unsure that I can do better than you (and additionally that I
> can be better in your subjective view given that we don't agree on every
> aspect). Also note I don't want to replace you, for some questions I
> don't feel competent to judge. My goal is just to widen the bottle neck.
>=20
> As a sensible step I think getting my hands on patchwork and cleanup up
> there would be a good thing. This would help me seeing what is actually
> still open and also help other interested parties to see the current
> situation.
>=20
> I agree that working with patchwork is tedious, but as soon as there is
> not only a single person who can keep everything in main memory some
> form of such a coordination is useful and important.

Okay, let's start there then. Do you have an account on
patchwork.ozlabs.org? If so, let me know and I can get the admins to add
you as maintainer to the project.

I do also have half-finished scripts somewhere to help with patchwork
maintenance. It might be worth resurrecting them and see if they can be
made more useful. One thing I've been meaning to add is some semi-
automated way of marking patches as superseeded/changes-requested. Or
automatically sending "Applied" replies and marking the patches
"accepted". I think that would go a long way of removing the tediousness
because you only have to work with patches and not worry about keeping
both the maintainer tree and patchwork in sync, and it avoids the need
to send out automatic emails.

Thierry

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7H7f0ACgkQ3SOs138+
s6GSpA/7BHr8CyFbjUooPaYy6W3twQzQleGa+82hQebOgdA3SDOuneVLNnxlcKAS
so3MZIBUEOf7CA8NHy5MZ/ubMxPWSFKmcGA5PDaa7g5JrOBdcZBQWVo7ZYDE+pYy
Pl/Uw1xZJWWlnfA2tNLq/QFjvcjZlyiv0xOkeo+PZeo79vziXW0MjskEJ0qJArN2
KchZtKXLwZDnLxjxMOd0TlN4aDeo11IdL2Q/qg9jEHubd1js/1Lwy7UT5HV+9sir
fdbkNo5GRHBEstQc4Ib+17cFHZI9SAmis63TBHSto26VSho7YVVxK1BctgOfebij
mWz3ZjzWSTPVAgea+UAeTSNfkERIX1qQb7VCcR/MVPimqc80CHcWF+1zbuhOIWBH
4LcAeHwsV3GhDABQRtfkVhL20Erz9ODVIJPoq5PW2alMGxlx/6nLM2AwP6tOwjIb
OwtmmyjM50waYEU6OlXMi3sAAsODZh4T+AJ3YWByARLoVog64XGud2bBv9Q/xo75
sFSy7X1IPXKg0d9uAsCZfOPGgAlNt3YRrUJ9L0UNNo+L0fwxExFEHRwVAWnbfK/k
XAZGLOXhTfnojc+6YY+ob+8kPGDH4+IGTUeMdqxHoktpHPkBxJBI3W+j1xScow/u
6yCK55JgBoB63/N/EfMuAlBtVIQGX2X8d4mCbA6B3YrNdggPV+s=
=mRtg
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
